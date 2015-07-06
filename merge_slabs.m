
function d = merge_slabs(dv1, dv2)

h1 = dv1.hst;
h2 = dv2.hst;

h = h1+h2;

d.hst = h;

h1 = dv1.hog;
h2 = dv2.hog;

h = h1+h2;

d.hog = h;

d.height = dv1.height + dv2.height;
d.ns = dv1.ns + dv2.ns;

end
