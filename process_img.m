
function I = process_img(imname)
%img1 = 'template\hdlabel1.png';
I = imread(imname);
try
I = rgb2gray(I);
catch
end
I = imresize(I, [100, 100]);
I(I > 0) = 1;
lbl = bwlabel(I);
ulbl = unique(lbl);
% The below parts mean what?
% I know, If there are more than one connected region for object(maybe the white
% part), you must choose best one(which is the best one?), and then you
% only get one object from the gray images.

if(length(ulbl) > 2)
    hst = hist(lbl(:), length(ulbl));  % the result from small number to big number, count the number  
    [~, sind] = sort(hst, 'descend'); % sind is the order Index
    for k=3:length(sind)
        lb = sind(k)-1;
        I(lbl == lb) = 0; 
        % just a problems, why I can't show the I by imshow function in matlab. I know why, next step.
        
    end
end

%I(I==1) = 255;
%figure(2);
%imshow(I);
        
%end