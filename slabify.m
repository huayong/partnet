
function final_slabs = slabify(im, nslabs, horv)
if horv == 'v'
    dvs = cell(1,size(im,2));  %%%
    for i=1:size(im,2)   %%%
        dv = compute_dist_hist(im(:,i)');  %%%
        dvs{i} = dv;
    end
    final_slabs = merge_slabs_inner(dvs, nslabs, size(im,2)); %%%
else
    dvs = cell(size(im,1),1);
    for i=1:size(im,1)  
        dv = compute_dist_hist(im(i,:));
        dvs{i} = dv;
    end
    final_slabs = merge_slabs_inner(dvs, nslabs, size(im,1));
end

end


function final_sl = merge_slabs_inner(dvs, ns, num_cols)


slab_ids = 1:num_cols;
cnslabs = num_cols;

costs0 = zeros(num_cols-1,1);
costs = comp_cands(dvs, 1:length(costs0), costs0);

while(cnslabs > ns)
    
    [mcst, mind] = min(costs);
    slab_ids(mind+1) = [];
    
    ndv = merge_dist_hists(dvs{mind}, dvs{mind+1});
    dvs{mind} = ndv;
    dvs(mind+1) = [];
    
    if(mind == length(costs))
        costs(mind) = [];
        inds = mind-1;
    else
        costs(mind+1) = [];
        if(mind > 1)
            inds = [mind-1, mind];
        else
            inds = mind;
        end
    end
    
    costs = comp_cands(dvs, inds, costs);
    cnslabs = cnslabs - 1;
    
end

final_sl.slab_ids = [slab_ids num_cols+1];
final_sl.dv = dvs;

final_sl = filter_thin_slabs(final_sl, costs, 4);

end


function costs2 = comp_cands(dvs, inds, costs)

costs2 = costs;

for i=1:length(inds)
    
    j = inds(i);
    
    hj1 = dvs{j}.height;
    hj11 = dvs{j+1}.height;
    
    d = slab_dist(dvs{j}, dvs{j+1});
    
    costs2(j) = sqrt(hj1+hj11) * d;
end

end


function slabs2 = filter_thin_slabs(slabs, costs, thin_thresh)

dvs = slabs.dv;
slab_ids = slabs.slab_ids;

flds = cell_struct_field(dvs, 'height');
thin = find(flds < thin_thresh);

while(~isempty(thin))
    curr = thin(1);
    
    if(curr == length(dvs))
        merto = dvs{curr-1};
        %merto = merge_thin_slabs(dvs{curr}, merto, thin_thresh);
        merto = merge_dist_hists(dvs{curr}, merto);
        dvs{curr-1} = merto;
        slab_ids(curr) = [];
        dvs(curr) = [];
        costs(curr-1) = [];
    else
        if(curr == 1 || costs(curr) < costs(curr-1))
            merto = dvs{curr+1};
            %merto = merge_thin_slabs(dvs{curr}, merto, thin_thresh);
            merto = merge_dist_hists(dvs{curr}, merto);
            dvs{curr+1} = merto;
            slab_ids(curr+1) = [];
            dvs(curr) = [];
            costs(curr) = [];
        else
            merto = dvs{curr-1};
            %merto = merge_thin_slabs(dvs{curr}, merto, thin_thresh);
            merto = merge_dist_hists(dvs{curr}, merto);
            dvs{curr-1} = merto;
            slab_ids(curr) = [];
            dvs(curr) = [];
            costs(curr-1) = [];
        end
    end
    
    
    flds = cell_struct_field(dvs, 'height');
    thin = find(flds < thin_thresh);
end

slabs2.dv = dvs;
slabs2.slab_ids = slab_ids;

end



function merged = merge_thin_slabs(mer, merto, thin_thresh)

if(merto.height < thin_thresh)
    merged = merge_dist_hists(mer, merto);
else
    merged = merto;
    merged.height = merto.height + mer.height;
end

end



