local Parser = {
  -- String related methods
  strtrim = function (s)
    return s:match"^%s*(.*)":match"(.-)%s*$";
  end,
  strsplit = function (s)
    local t = {};
    for w in s:gmatch("%w+") do
      table.insert(t, w);
    end
    return t;
  end,
  -- Table related methods
  copytable = function (t)
    local temp = {};
    for _, v in ipairs(t) do
      table.insert(temp, v);
    end
    return temp;
  end,
  findvalue = function (par, t)
    local i;
    while next(t, i) do
      i = next(t, i);
      if t[i] == par then
        return i;
      end
    end
  end,
  -- Processing table related methods
  extargs = function (self, p_name, n_args, t)
    local ni = self.findvalue(p_name, t);
    if not ni then return end
    local temp = { p_name };
    for i = 1, n_args do
      table.insert(temp, t[ni + i]);
    end
    return temp;
  end,
  populatetable = function (self, p_args, p_name, n_args, t)
    while self.findvalue(p_name, t) do
      local ni = self.findvalue(p_name, t)
      table.insert(p_args, self:extargs(p_name, n_args, t));
      -- remove elements already found from temp
      for _ = 1, n_args + 1 do
        table.remove(t, ni);
      end
    end
  end,
  -- API
  ParseInput = function (self, p_name, n_args)
    local p = {};
    n_args = tonumber(n_args) or 0
    self:populatetable(p, p_name, n_args, self.copytable(self.t))
    return p;
  end,
  ParseAllInputs = function (self, lookuptable)
    local p = {};
    local temp = self.copytable(self.t);
    for _, e in ipairs(lookuptable) do
      local n_args = tonumber(e[2]) or 0
      self:populatetable(p, e[1], n_args, temp)
    end
    return p;
  end,
  New = function (self, str)
    if not str or str == "" then return end
    local o = {
      s = self.strtrim(str),
      t = self.strsplit(self.strtrim(str):gsub("[ ]+", " ")),
    };
    setmetatable(o, self);
    self.__index = self;
    return o;
  end,
};

return Parser
