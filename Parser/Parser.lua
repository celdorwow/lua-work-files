local String = {
   StrTrim = function(s)
      return s:match "^%s*(.*)":match "(.-)%s*$";
   end,
   StrSplit = function(s)
      local t = {};
      for w in s:gmatch("%w+") do
         table.insert(t, w);
      end
      return t;
   end,
};

local Array = {
   Empty = function(t)
      for _ = 1, #t do
         table.remove(t);
      end
   end,
   Copy = function(tsource, tdest)
      tdest = tdest or {};
      for _, v in ipairs(tsource) do
         table.insert(tdest, v);
      end
   end,
   Find = function(par, t)
      local i;
      while next(t, i) do
         i = next(t, i);
         if t[i] == par then
            return i;
         end
      end
   end,
   IsEmpty = function(t)
      if type(t) ~= "table" then
         return
      end
      return not next(t)
   end,
};

local Parser = {
   storedargs = {},
   localargs = {},
   __populatetable = function(self, t_args, p_name, n, l_args)
      local ni = Array.Find(p_name, l_args)
      while ni do
         local temp = { p_name };
         for i = 1, n do
            table.insert(temp, l_args[ni + i]);
         end
         table.insert(t_args, temp);
         -- remove elements already found from temp
         for _ = 1, n + 1 do
            table.remove(l_args, ni);
         end
         -- Check for repeated parameter
         ni = Array.Find(p_name, l_args)
      end
   end,
   -- API
   ParseInput = function(self, p_name, n_args)
      n_args = tonumber(n_args) or 0
      Array.Empty(self.storedargs);
      Array.Empty(self.localargs);
      Array.Copy(self.allargs, self.localargs);
      self:__populatetable(self.storedargs, p_name, n_args, self.localargs)
      return self.storedargs;
   end,
   ParseAllInputs = function(self, lookuptable)
      Array.Empty(self.storedargs);
      Array.Empty(self.localargs);
      Array.Copy(self.allargs, self.localargs);
      for _, e in ipairs(lookuptable) do
         local n_args = tonumber(e[2]) or 0
         self:__populatetable(self.storedargs, e[1], n_args, self.localargs)
      end
      return self.storedargs;
   end,
   New = function(self, str)
      if not str or str == "" then
         return ;
      end
      local o = {
         s = String.StrTrim(str),
         allargs = String.StrSplit(String.StrTrim(str):gsub("[ ]+", " ")),
      };
      setmetatable(o, self);
      self.__index = self;
      return o;
   end,
};

return Parser
