im=imread('/Users/Imperssonator/CC/DeepAFM/Data/capture/Anna/PEDOT_LiBTI.001_1.tif');

num_gauss=8;

if length(size(im))>2
    gray=rgb2gray(im);
else
    gray=im;
end

g3 = zeros(size(gray,1),size(gray,2),num_gauss);
R=zeros(num_gauss,1);
for i = 1:num_gauss;
    R(i)=i;
    g3(:,:,i)=imgaussian(double(gray),R(i));
end

im_density=zeros(size(gray));
for i =1:size(gray,1)
    for j = 1:size(gray,2)
        
        gg=g3(i,j,:); gg=gg(:);
        B=regress(log(gg),[ones(size(gg)), log(R)]);
        im_density(i,j)=B(2);
    end
end

imtool(im_density)
