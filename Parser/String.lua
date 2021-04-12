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

return String
