function ims = HuAnalysis(ImDir,im_num)

ims = readNanoScopeImage(ImDir(im_num).path);
disp(['Image number ', num2str(im_num), ' of ' num2str(length(ImDir))])
disp(['Image file: ', ImDir(im_num).path])

n_ch = length(ims);
for ch = 1:n_ch
    img_flat = imadjust(Flatten(ims(ch).img,3));
    img_edge = edge(img_flat,'canny');
%     ims(ch).flat = img_flat;
%     ims(ch).edge = img_edge;
    
    eta=SI_Moment(img_edge);
    inv_moments = Hu_Moments(eta);
    ims(ch).Hu = inv_moments;
end

end