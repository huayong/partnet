% computer distance for each row, the parameter is the vector of 0 and 1.
function d = compute_dist_hist(vec)

ons = find(vec); 
fone = min(ons);
lone = max(ons);
vec1 = vec(fone:lone);

dvec1 = compute_dist_vector_inner(vec1, 1);
n = length(vec);
midway = round(n/2);

zer = find(dvec1 == 0);
nz = find(dvec1 > 0);
tmp = dvec1(nz);
nz2 = tmp < midway;
hst = hist([1 midway-1 tmp(nz2)], 5);
hst(1) = hst(1) - 1;
hst(end) = hst(end) - 1;

hst = [length(zer) hst length(nz)-length(nz2)];


d.hst = hst;
d.height = 1;
d.ns = n;


end


function d = compute_dist_hist_old(vec)

dvec1 = compute_dist_vector_inner(vec, 1);
n = length(vec);
midway = round(n/2);

zer = find(dvec1 == 0);
nz = find(dvec1 > 0);
tmp = dvec1(nz);
nz2 = tmp < midway;
hst = hist([1 midway-1 tmp(nz2)], 5);
hst(1) = hst(1) - 1;
hst(end) = hst(end) - 1;

hst = [length(zer) hst length(nz)-length(nz2)];

% tmp1 = find(dvec1 < midway);
% hst = hist([0 midway-1 dvec1(tmp1)], 5);
% hst(1) = hst(1) - 1;
% hst(end) = hst(end) - 1;
% hst = [hst n-length(tmp1)];

d.hst = hst;
d.height = 1;
d.ns = n;

% dvec0 = compute_dist_vector_inner(vec, 0);
% 
% d.d1 = dvec1;
% d.w1 = vec;
% d.d0 = dvec0;
% d.w0 = 1-vec;
% d.height = 1;

end

function dvec = compute_dist_vector_inner(vec, val)

n = length(vec);
nz = find(vec == val);

if(val == 0)
    nz = [0 nz n+1];
else
    if(isempty(nz))
        %nz = [0 n+1];
        dvec = (length(vec)-1)*ones(size(vec));
        return;
    end
end


tmp = 1:n;
nz11 = repmat(nz, 1, length(tmp));
nz12 = repmat(tmp, length(nz), 1);
nz122 = nz12(:)';

dst = abs(nz11 - nz122);
dst2 = reshape(dst, size(nz12));
dvec = dst2;

if(size(dst2,1) > 1)
    dvec = min(dst2);
end

%dvec = uint8(dvec);


end




