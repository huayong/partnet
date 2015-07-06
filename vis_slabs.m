
function vis_slabs(slabs, seg)

sl_str = slabs;
I = imread(sl_str.img);
I = imresize(I, [100, 100]);

I2 = I;
I2(I2 > 0) = 1;

count = 1;

for i=1:length(sl_str.slab_ids)-1
    sth = sl_str.slab_ids(i);
    enh = sl_str.slab_ids(i+1)-1;
    
%     if(exist('seg', 'var'))
%         %I2(st:en,:) = I2(st:en,:) * seg(i);
%         I2(:,st:en) = I2(:,st:en) * seg(i);  %%%
%     else
%         %I2(st:en,:) = I2(st:en,:) * i;
%         I2(:,st:en) = I2(:,st:en) * i;   %%%
%     end

    if(exist('sl2', 'var'))
        for j=1:length(sl2.slab_ids)-1
            stv = sl2.slab_ids(j);
            env = sl2.slab_ids(j+1)-1;
            I2(sth:enh,stv:env) = I2(sth:enh,stv:env) * count;
            count = count + 4;
        end
    else
        if(exist('seg', 'var'))
            if(slabs.type == 'v')
                I2(:, sth:enh) = I2(:, sth:enh) *  seg(i) * 7;
            elseif(slabs.type == 'h')
                I2(sth:enh, :) = I2(sth:enh, :) *  seg(i) * 7;
            end
        else
            if(slabs.type == 'v')
                I2(:, sth:enh) = I2(:, sth:enh) * i * 7;
            elseif(slabs.type == 'h')
                I2(sth:enh, :) = I2(sth:enh, :) * i* 7;
            end
        end
    end
    
end

figure; image(I2);
%map = colormap('lines');
clrmap=[0,0,0;1,0.0938,0;1,0.1875,0;1,0.2812,0;1,0.375,0;1,0.4688,0;1,0.5625,0;1,0.6562,0;1,0.75,0;1,0.8438,0;1,0.9375,0;0.9688,1,0;0.875,1,0;0.7812,1,0;0.6875,1,0;0.5938,1,0;0.5,1,0;0.4062,1,0;0.3125,1,0;0.2188,1,0;0.125,1,0;0.0312,1,0;0,1,0.0625;0,1,0.1562;0,1,0.25;0,1,0.3438;0,1,0.4375;0,1,0.5312;0,1,0.625;0,1,0.7188;0,1,0.8125;0,1,0.9062;0,1,1;0,0.9062,1;0,0.8125,1;0,0.7188,1;0,0.625,1;0,0.5312,1;0,0.4375,1;0,0.3438,1;0,0.25,1;0,0.1562,1;0,0.0625,1;0.0312,0,1;0.125,0,1;0.2188,0,1;0.3125,0,1;0.4062,0,1;0.5,0,1;0.5938,0,1;0.6875,0,1;0.7812,0,1;0.875,0,1;0.9688,0,1;1,0,0.9375;1,0,0.8438;1,0,0.75;1,0,0.6562;1,0,0.5625;1,0,0.4688;1,0,0.375;1,0,0.2812;1,0,0.1875;1,0,0.0938;1,0.0938,0;1,0.1875,0;1,0.2812,0;1,0.375,0;1,0.4688,0;1,0.5625,0];
clrmap = repmat(clrmap, 10, 1);
%map = [0 0 0; map];
%map(end,:) = [];
colormap(clrmap);


end


