function [sl1, segi, sl2, segj, cost] =  transfer(img1, img2, type)

    I1 = process_img(img1);
    I2 = process_img(img2);

    sl1 = slabify(I1, 20, type); % the second parameter is the maximum slab for images 
    sl1.img = img1;  
    sl1.type = type;
    sl2 = slabify(I2, 20, type);
    sl2.img = img2;
    sl2.type = type;

    %vis_slabs(sl1);
    %vis_slabs(sl2);

    [merges1, dstructs1] = all_merges(sl1,I1);
    [merges2, dstructs2] = all_merges(sl2,I2);

    [cost, ~, M] = slab_match(sl1, merges1, dstructs1, sl2, merges2, dstructs2);

    lbls = bwlabel(M,4);
    segi = max(lbls,[],2);
    segj = max(lbls);

    %vis_slabs(sl1,segi);
    %vis_slabs(sl2,segj);
    
end