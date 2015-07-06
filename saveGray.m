% objectname = 'hd';
% endnum = 1;
% startnum = 1;
for i=1:36
dirname = ['C:\Users\lab\Desktop\hv\template_back\data\hairdryer' num2str(i)];

%mkdir([dirname 'png\'])
mkdir([dirname '\1']);
mkdir([dirname '\2']);

catcherror = [];
file=dir(dirname);

for filenum=5:length(file)
    
    %filenum

    %try 
%         bmpname = [dirname objectname num2str(filenum) '.png'];
% 
%         bmpim = imread(bmpname);
%         
%         %info = imfinfo(bmpname);
%         %gray = ind2gray(bmpim,info.Colormap);
%         %bmpim = gray;
%         
%         [L,num]=bwlabel(bmpim);
%         st=regionprops(L,'BoundingBox');
%         bb = st(1).BoundingBox;
%         x = fix(bb(1));
%         y = fix(bb(2));
%         w = fix(bb(3));
%         h = fix(bb(4));
%         
%         %newim = zeros(bb(3),bb(4));
%         newim = bmpim(y:y+h,x:x+w);
%         imwrite(newim, [bmpname(1:end-4) '.png'], 'png');
        
        labelname = [dirname '\' file(filenum).name];
        [labelim, ~, alpha]  = imread(labelname);
        I = rgb2gray(labelim);
        [L,num]=bwlabel(I);
        %[L,num]=bwlabel(labelim(:,:,3));
        st=regionprops(L,'BoundingBox');
        bb = st(1).BoundingBox;
        x = fix(bb(1));
        y = fix(bb(2));
        w = fix(bb(3));
        h = fix(bb(4));
        newlabelim = labelim(y:y+h,x:x+w,:);
        Alpha = alpha(y:y+h,x:x+w,:);
        imwrite(newlabelim, [[dirname '\1'] '\hd',num2str(filenum-2),'.png'] ,'Alpha', Alpha);
        
%         I = rgb2gray(labelim);
%         [L,num]=bwlabel(I);
        st=regionprops(L,'BoundingBox');
        bb = st(1).BoundingBox;
        x = fix(bb(1));
        y = fix(bb(2));
        w = fix(bb(3));
        h = fix(bb(4));
        %newim = zeros(bb(3),bb(4));
        newim = I(y:y+h,x:x+w);
        imwrite(newim, [[dirname '\2'] '\hd',num2str(filenum-2),'.png'], 'png');
        
   %{
    catch
        catcherror = [catcherror filenum];
        continue;
    end
        %}
end
end
