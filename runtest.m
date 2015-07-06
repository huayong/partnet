close all;clear all;clc
addpath 'toolbox-master\channels'
%img1 = 'template\data\hairdryer9\2\hd91.png';

for i=2:2
img2 = ['C:\Users\lab\Desktop\hv\test\hairdryer_test\' num2str(i) '.bmp'];

[T,D]=select(img2);
img1=['template\data\' D '\2\' T];
type = 'h';
[sl1h, seg1h, sl2h, seg2h, costh] = transfer(img1, img2, type);
% vis_slabs(sl1h);
% vis_slabs(sl2h);
% vis_slabs(sl1h,seg1h);
% vis_slabs(sl2h,seg2h);
type = 'v';
[sl1v, seg1v, sl2v, seg2v, costv] = transfer(img1, img2, type);
% vis_slabs(sl1v);
% vis_slabs(sl2v);
% vis_slabs(sl1v,seg1v);
% vis_slabs(sl2v,seg2v);

vis_slabs_hv(sl1h, sl1v, seg1h, seg1v);
vis_slabs_hv(sl2h, sl2v, seg2h, seg2v);

costh;
costv;
cost =  costh + costv

mt1h = origin_match(sl1h, seg1h);
mt1v = origin_match(sl1v, seg1v);
mt2h = origin_match(sl2h, seg2h);
mt2v = origin_match(sl2v, seg2v);

% test = imread(img2);
% test(test > 0) = 1;
% [result_r, result_c] = size(test);
% result = zeros(result_r, result_c, 3);
% result(:,:,1) = test;
% result(:,:,2) = test;
% result(:,:,3) = test;

[labelim, ~, alpha]  = imread(['template\data\' D '\1\' T]);
%[labelim, ~, alpha]  = imread(['template\data\hairdryer9\1\hd91.png']);
boo=imread(img2);
%boo(boo > 0) = 1;
%imshow(boo);

for j=1:length(mt1v)-1
    tmp1=0;
    tmp2=0;
    tmp3=0;
    
    for i=1:length(mt1h)-1
        %    for i=1:1
               
        %   for j=1:1

        sth = mt1h(i);
        enh = mt1h(i+1)-1;
        stv = mt1v(j);
        env = mt1v(j+1)-1;
        tempim = labelim(sth:enh,stv:env,:);
        r = tempim(:,:,1);
        g = tempim(:,:,2);
        b = tempim(:,:,3);
        [M,N]=size(r);
        
        %                 re = find(r~=0);
        %                 color_r = 0;
        %                 if(~isempty(re))
        %                     color_r = sum(r(:))/length(re) / 255;
        %                 end
        %                 ge = find(g~=0);
        %                  color_g = 0;
        %                 if(~isempty(ge))
        %                     color_g = sum(g(:))/length(ge) / 255;
        %                 end
        %                 be = find(b~=0);
        %                 color_b = 0;
        %                 if(~isempty(be))
        %                     color_b = sum(b(:))/length(be) / 255;
        %                 end
        
        sth_test = mt2h(i);
        enh_test = mt2h(i+1)-1;
        stv_test = mt2v(j);
        env_test = mt2v(j+1)-1;
        r_test=zeros(enh_test-sth_test+1,env_test-stv_test+1);
        g_test=zeros(enh_test-sth_test+1,env_test-stv_test+1);
        b_test=zeros(enh_test-sth_test+1,env_test-stv_test+1);
        [m,n]=size(r_test);
        for ii=1:m
            for jj=1:n
                if (boo(sth_test+ii-1,stv_test+jj-1)>0)
                    i_t=round(ii*M/m);
                    j_t=round(jj*N/n);
                    if i_t>M
                        i_t=floor(ii*M/m);
                    end
                    if j_t>N
                        j_t=floor(jj*N/n);
                    end
                    if i_t==0
                        i_t=ceil(ii*M/m);
                    end
                    if j_t==0
                        j_t=ceil(jj*N/n);
                    end
                    if (r(i_t,j_t)==0&&g(i_t,j_t)==0&&b(i_t,j_t)==0)
                        r_test(ii,jj)=tmp1;
                        g_test(ii,jj)=tmp2;
                        b_test(ii,jj)=tmp3;
                    else
                        r_test(ii,jj)=r(i_t,j_t);
                        tmp1=r_test(ii,jj);
                        g_test(ii,jj)=g(i_t,j_t);
                        tmp2=g_test(ii,jj);
                        b_test(ii,jj)=b(i_t,j_t);
                        tmp3=b_test(ii,jj);
                    end
                end
            end
        end
        result(sth_test:enh_test,stv_test:env_test,1) = r_test;
        result(sth_test:enh_test,stv_test:env_test,2) = g_test;
        result(sth_test:enh_test,stv_test:env_test,3) = b_test;
        
        %                 result(sth_test:enh_test,stv_test:env_test,1) = result(sth_test:enh_test,stv_test:env_test,1) * color_r;
        %                 result(sth_test:enh_test,stv_test:env_test,2) = result(sth_test:enh_test,stv_test:env_test,2) * color_g;
        %                 result(sth_test:enh_test,stv_test:env_test,3) = result(sth_test:enh_test,stv_test:env_test,3) * color_b;
    end
end

result=uint8(result);
figure;
imshow(result);
imwrite(result, ['C:\Users\lab\Desktop\hv\test\hairdryer_test\new' num2str(i) '.png'], 'png');


end
