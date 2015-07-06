
function d = slab_dist2(dv1, dv2)

h1 = dv1.hst ./ dv1.ns;
h2 = dv2.hst ./ dv2.ns;
%h1 = dv1.hst(2:end) ./ dv1.ns;
%h2 = dv2.hst(2:end) ./ dv2.ns;

d = norm(h1-h2);
%d = earthMoverDist(h1,h2);

h1 = dv1.hog ./ dv1.ns;
h2 = dv2.hog ./ dv2.ns;

d2 = norm(h1-h2);

d = d + d2;

end
