function x = intersects(a,b,c,d,p,q,r,s)
  det = (c - a) * (s - q) - (r - p) * (d - b);
  if (det == 0)
    x = false;
  else
    lambda = ((s - q) * (r - a) + (p - r) * (s - b)) / det;
    gamma = ((b - d) * (r - a) + (c - a) * (s - b)) / det;
    x = (0 < lambda && lambda < 1) && (0 < gamma && gamma < 1);
  end
end