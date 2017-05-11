function ims = display_sample(ImDir,rando)

% rando = randi(length(ImDir));
disp(['Image number: ', num2str(rando)])
ims = readNanoScopeImage(ImDir(rando).path);
disp(['Image file: ', ImDir(rando).path])

ff=figure;
ff.Position = [179 24 521 773];

n_im = length(ims);
for ch = 1:n_im
    img_flat = imadjust(Flatten(ims(ch).img,3));
    img_edge = edge(img_flat,'canny');
    
    subplot(n_im,2,ch*2-1), imshow(img_flat)
    subplot(n_im,2,ch*2), imshow(img_edge)
    
%     eta=SI_Moment(img_edge);
%     inv_moments = Hu_Moments(eta);
%     ims(ch).Hu = inv_moments;
end

% disp(ims(1).Hu(1:2))

end