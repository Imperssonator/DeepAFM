function ims = imtool_sample(ImDir,rando,ch)

% rando = randi(length(ImDir));
disp(['Image number: ', num2str(rando)])
ims = readNanoScopeImage(ImDir(rando).path);
disp(['Image file: ', ImDir(rando).path])

img_flat = mat2gray(imadjust(Flatten(ims(ch).img,3)));

imtool(img_flat)
imtool(edge(img_flat,'Canny'))

end