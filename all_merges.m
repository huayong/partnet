

function [merges, dstructs] = all_merges(slabs,img)

dvs = slabs.dv;
num = length(dvs);

merges = zeros(num);
dstructs = cell(num);

for k=1:num
    for m=1:num-k+1
        if(k == 1)
            ndv = compute_hog_for_slab(slabs,m,img);
            hd = 0;
        end

        if(k >= 2)

            dv1 = dstructs{m,m+k-2};
            dv2 = dstructs{m+k-1,m+k-1};
            hd = slab_dist2(dv1, dv2);
            ndv = merge_slabs(dv1, dv2);
        end

        merges(m, m+k-1) = hd;
        dstructs{m, m+k-1} = ndv;
    end
end


end




function sl2 = compute_hog_for_slab(sl,d,img)

%ncols = size(img,2);
sids = sl.slab_ids;

st = sids(d);
en = sids(d+1)-1;
%nrows = en-st+1;
prt = img(st:en,:);
% fh = fhog(single(prt),1);% nrows);
% sfh = sum(fh,1);
% sfh2 = sum(sfh,2);
% hhst = reshape(sfh2,[1 32]);
% hhst = hhst(19:27);
% %hhst = hhst ./ (nrows*ncols);

[M1,O1] = gradientMag(single(prt),0,0,0,1);
hhst = hist([O1(:); 0; 2*pi], 9);
hhst(1) = hhst(1) - 1;
hhst(end) = hhst(end) - 1;

sl2 = sl.dv{d};
sl2.hog = hhst;


end


