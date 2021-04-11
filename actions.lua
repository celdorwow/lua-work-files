local a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y;
a = aura_env;
d = {};
e = {};
f = 0;
b = a.config;
j = b.batch;
l = b.combine;
m = b.hasted;
n = b.clump;
h = b.adv.tyrext;
i = h / 4;
t = 40;
k = b.adv.leeway;
u = b.persistent;
r = b.topleft;
q = b.limit;
x = "WILD_IMP_CHECK";
y = "SPELL_CAST_SUCCESS";
p = UnitLevel("player") >= 56 and 6 or 5;


if b.colourenabled then
	local z, A, B, C = unpack(b.startcolour);
	local D, E, F, G = unpack(b.endcolour);
	s = {};
	for H = 1, 9 do
		local I = 1 - min((H - 1) / 9, 1);
		s[H] = {WeakAuras.GetHSVTransition(1 - I * I * I, z, A, B, C, D, E, F, G),}
	end
end


c = function()
	o = false;
	WeakAuras.ScanEvents(x, nil)
end


v = function(J, K)
	return J.curEnd < K.curEnd
end


w = function(J, K)
	return #J.imps > #K.imps
end


a.main = function(L, M, N, O, _, P, Q, _, _, R, S, _, _, T, U)
	local V = GetTime();
	local W = M == x;
	local X = W and not not N;
	if M ~= x then
		if P == UnitGUID("player") then
			if O == "SPELL_SUMMON" then
				if T == 265187 then
					local Y = g and h or i;
					e[V + Y] = true;
					g = false;
					for _, Z in pairs(d) do
						Z.ext = max(V, Z.ext) + Y;
						Z.curEnd = Z.curEnd + Y;
						Z.maxEnd = Z.maxEnd + Y;
					end
					W = true
				elseif T == 104317 or T == 279910 then
					local a0, a1 = T == 279910 and 20.2 or t, 0;
					for a2, _ in pairs(e) do
						if V < a2 then
							a1 = a1 + a2 - V;
						else
							e[a2] = nil
						end
					end
					local a3 = V + a0 + a1;
					d[R] = {
						guid = R,
						casts = p,
						act = V,
						maxEnd = a3,
						ext = V + a1,
						curEnd = a3,
						show = false,
					};
				end
			elseif O == y and T == 265187 then
				g = true;
			end
		elseif T == 104318 then
			local Z = d[P];
			if Z then
				if O == "SPELL_CAST_START" then
					local a4, a5 = 2 / (1 + UnitSpellHaste("player") / 100), max(Z.casts, 1);
					if V < Z.ext then
						a5 = a5 + floor((Z.ext - V) / a4)
					end
					local a6 = a4 * min(floor((Z.maxEnd + k - V) / a4), a5);
					Z.cast = V + a4;
					Z.curEnd = V + a6 + k;
					Z.act = Z.cast;
					if not Z.show then
						Z.show = true;
						X = true;
					end
					C_Timer.After(a4 + 0.5, function()
						if Z and Z.cast and GetTime() > Z.cast then
              Z.cast = nil;
              Z.curEnd = Z.maxEnd;
              WeakAuras.ScanEvents(x, nil);
            end
          end)
        elseif O == y then
          if V > (Z.ext or 0) then
            Z.casts = Z.casts - 1;
          end
          if Z.casts <= 0 then
            Z.cast = nil;
          end
        end
      end
    end
  elseif N then
	  f = N;
	  if N == 0 then
		  d = {}
		  for _, a7 in pairs(L) do
			  a7.show = false;
			  a7.changed = true;
		  end
		  return true
	  end
  end

  if X then
  	local a8 = 0;
    for _, Z in pairs(d) do
      if Z.show then
        if V + 0.5 > Z.maxEnd then
          Z.act = 0;
        end
        a8 = a8 + 1;
      end
    end

    while a8 < f do
      local a9 = nil;
      for _, Z in pairs(d) do
        if not Z.show and (not a9 or Z.act > a9.act) then
          a9 = Z;
        end
      end
      if a9 then
        a9.show = true;
        a8 = a8 + 1
      else
        break
      end
    end

    while a8 > f do
      local aa = nil;
      for _, Z in pairs(d) do
        if Z.show and (not aa or Z.act < aa.act) then
          aa = Z
        end
      end
      if aa then
        aa.show = false;
        if aa.act == 0 then
          d[aa.guid] = nil
        end
        a8 = a8 - 1
      else
        break
      end
    end
  end

  if not W then
    return false
  end

  local ab, Y, ac, ad, ae, af;
  ab = 1 + UnitSpellHaste("player") / 100;
  Y = 2 * p / ab;
  ac = V + Y;
  af = j / (m and ab or 1)ae = 0;
  ad = {}

  for _, Z in pairs(d) do
    if Z.show and Z.curEnd > V then
      ad[#ad + 1] = Z
    end
  end

  table.sort(ad, v)
  local ag, ah = {}
  for _, Z in ipairs(ad) do
    if not ah or (not l or ah.endTime < ac) and (q == 0 or #ag < q) and Z.curEnd >= ae + af then
      ah = {
        endTime = max(Z.curEnd, V),
        size = 1,
        imps = {Z},
        casts = max(0, Z.casts),
        indexes = {},
        indexPop = 0,
      };
      ag[#ag + 1] = ah;
      if not u then
        ah.index = #ag
      elseif Z.index then
        ah.indexes[Z.index] = 1;
        ah.index = Z.index;
        ah.indexPop = 1
      end
      ae = Z.curEnd
    else
      ah.size = ah.size + 1;
      ah.casts = ah.casts + max(0, Z.casts);
      ah.imps[#ah.imps + 1] = Z;
      if n then
        ae = Z.curEnd
      end
      if u and Z.index then
        local ai = (ah.indexes[Z.index] or 0) + 1;
        ah.indexes[Z.index] = ai;
        if Z.index == ah.index then
          ah.indexPop = ai
        elseif ai > ah.indexPop or ai == ah.indexPop and Z.index > ah.index then
          ah.indexPop = ai;ah.index = Z.index
        end
      end
    end
  end

  table.sort(ag, w)

  for _, aj in ipairs(ag) do
    local a7 = aj.index and L[aj.index];
    if not a7 or a7.changed then
      local ak = #L + 1;
      a7 = {progressType = "timed", autoHide = false, duration = Y, show = true, index = ak,};
      L[ak] = a7;
    end
    for _, Z in ipairs(aj.imps) do
      Z.index = a7.index
    end
    a7.expirationTime = aj.endTime;
    a7.imps = aj.imps;
    a7.changed = true;
    if s and aj.size ~= a7.stacks then
      a7.colour = s[min(aj.size, 9)]
    end
    if r == 1 then
      local al = floor(aj.casts / aj.size);
      a7.topleft = aj.size..(al > 0 and"/"..al or"");
    elseif r == 2 then
      a7.topleft = aj.size;
    elseif r == 3 then
      a7.topleft = aj.casts > 0 and aj.casts or ""
    else
      local al = floor(aj.casts / aj.size)a7.topleft = al > 0 and al or""
    end
  end

  for _, a7 in pairs(L) do
    if not a7.changed then
      a7.show = false;
    end
  end

  if not o then
    o = true;
    C_Timer.After(0.5, c)
  end

  return true
end
