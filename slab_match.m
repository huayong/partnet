
function [cost, mcost, M] = slab_match(sl1, mer1, dstr1, sl2, mer2, dstr2)

sns = length(sl1.dv);
tns = length(sl2.dv);

subtrees = cell(sns,tns);
subtree_costs = -1 * ones(sns,tns);

sbtr.subtrees = subtrees;
sbtr.subtree_costs = subtree_costs;

parent.i = 0;
parent.j = 0;
parent.dist = 0;
parent.match_dist = 0;
parent.dv1 = [];
parent.dv2 = [];


[tree, cost, sbtr] = visit_node(parent, 1, 1, 0, sl1, mer1, dstr1, sl2, mer2, dstr2, sbtr);


node = tree;
M = zeros(sns,tns);

costs = zeros(sns,1);
nsl = zeros(sns,1);

while(1)
    
    M(node.i,node.j) = 1;
    nsl(node.i(1)) = 1;
    costs(node.i(1)) = node.match_dist;
    if(isempty(node.child))
        break;
    end
    
    node = node.child;
end

mcost = sum(costs) / sum(nsl);

% lbls = bwlabel(M,4);
% segi = max(lbls,[],2);
% segj = max(lbls);
% vis_slabs3(sl1,segi);
% vis_slabs3(sl2,segj);



end



function [node, basic_cost, sbtr] = visit_node(parent, i, j, merge, sl1, mer1, dstr1, sl2, mer2, dstr2, sbtr)


node = [];
basic_cost = 1e5;

sz1 = length(sl1.dv);
sz2 = length(sl2.dv);

if(i > sz1 || j > sz2)
    return;
end

if(~merge)
    if(sbtr.subtree_costs(i,j) ~= -1)
        node = sbtr.subtrees{i,j};
        node.parent = parent;
        node.dist = node.match_dist + parent.dist;
        basic_cost = parent.dist + sbtr.subtree_costs(i,j);
        return;
    end
end


pis = parent.i;
pjs = parent.j;

pi = pis(end);
pj = pjs(end);

ptotd = parent.dist;
pmatchd = parent.match_dist;
pdist = ptotd - pmatchd;

pdv1 = parent.dv1;
pdv2 = parent.dv2;

addi = 0;
addj = 0;

if(i > pi)
    addi = 1;
end

if(j > pj)
    addj = 1;
end


if(merge)
    
    ni = pis;
    nj = pjs;
    
    if(addi)
        ni = [pis i];
        
        merged1 = mer1(pis(1), i);
        ndv1 = dstr1{pis(1), i};
    else
        merged1 = 0;
        ndv1 = pdv1;
    end
    
    if(addj)
        nj = [pjs j];
        
        merged2 = mer2(pjs(1), j);
        ndv2 = dstr2{pjs(1), j};
    else
        merged2 = 0;
        ndv2 = pdv2;
    end
    
    matchd = slab_dist2(ndv1, ndv2);
    matchd = matchd * (max(ndv1.height, ndv2.height) / min(ndv1.height, ndv2.height));
    dist = pdist + matchd + merged1 + merged2;
else
    ni = i;
    nj = j;
    ndv1 = dstr1{i,i};
    ndv2 = dstr2{j,j};
    
    matchd = slab_dist2(ndv1, ndv2);
    matchd = matchd * (max(ndv1.height, ndv2.height) / min(ndv1.height, ndv2.height));
    dist = ptotd + matchd;
end


node.parent = parent;
node.i = ni;
node.j = nj;
node.dv1 = ndv1;
node.dv2 = ndv2;
node.dist = dist;
node.match_dist = matchd;
node.child = [];



if(i == sz1 && j == sz2)
    
    basic_cost = node.dist;

    if(~merge)
        sbtr.subtrees{i,j} = node;
        sbtr.subtree_costs(i,j) = basic_cost-ptotd;
    end
    
    return;
end

children = cell(1,4);
bc1 = 1e5;
bc2 = 1e5;
bc3 = 1e5;
bc4 = 1e5;

if(addi && addj)
    
    [cnode1, bc1, sbtr] = visit_node(node, i+1, j+1, 1, sl1, mer1, dstr1, sl2, mer2, dstr2, sbtr);
    children{1} = cnode1;
    
end

[cnode2, bc2, sbtr] = visit_node(node, i+1, j+1, 0, sl1, mer1, dstr1, sl2, mer2, dstr2, sbtr);
children{2} = cnode2;

if(addi)
    [cnode3, bc3, sbtr] = visit_node(node, i+1, j, 1, sl1, mer1, dstr1, sl2, mer2, dstr2, sbtr);
    children{3} = cnode3;
end

if(addj)
    [cnode4, bc4, sbtr] = visit_node(node, i, j+1, 1, sl1, mer1, dstr1, sl2, mer2, dstr2, sbtr);
    children{4} = cnode4;
end


bcs = [bc1 bc2 bc3 bc4];
[mbc, mind] = min(bcs);

basic_cost = mbc;

node.child = children{mind};

if(~merge)
    sbtr.subtrees{i,j} = node;
    sbtr.subtree_costs(i,j) = basic_cost-ptotd;
end

end



