function mt = origin_match(sl, seg)

I = imread(sl.img);
[h, w] = size(I);

mt = [];
sign = seg(1);
mt = [mt 1];
for i=2:length(seg)
    if(seg(i) ~= sign)
        sign = seg(i);
        mt = [mt sl.slab_ids(i)];
    end
end


if(sl.type == 'h')
    mt = fix(mt ./ 100 * h);
    mt(1) = 1;
    mt = [mt h+1];
else
    mt = fix(mt ./ 100 * w);
    mt(1) = 1;
    mt = [mt w+1];
end
   