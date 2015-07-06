function [T,D]=select(img2)
addpath 'toolbox-master\channels'
dirname='template\data\';
tmpdir=dir(dirname);
tmpsize=size(tmpdir,1);
for j=3:tmpsize
    filedir=dir([dirname char(tmpdir(j).name) '\2\' '*.png']);
    filesize=size(filedir,1);
    for i=1:filesize
        %img1 = 'template\2\hd7.png';
        img1 = [dirname char(tmpdir(j).name) '\2\' char(filedir(i).name)]
        
        type = 'h';
        [sl1h, seg1h, sl2h, seg2h, costh] = transfer(img1, img2, type);
        
        type = 'v';
        [sl1v, seg1v, sl2v, seg2v, costv] = transfer(img1, img2, type);
        
        
        cost =  costh + costv;
        rsl(i).id=char(filedir(i).name);
        rsl(i).dir=char(tmpdir(j).name);
        rsl(i).data=round(cost*1000000);
    end
end
[data,index]=sort([rsl.data]);
T=char(rsl(index(1)).id);
D=char(rsl(index(1)).dir);