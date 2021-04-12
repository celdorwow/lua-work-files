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

return Array;
