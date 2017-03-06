function [] = display_nearest(ImDir,rando,ch,dist_mat,ss_struct)

% rando = randi(length(ImDir));
disp(['Image number: ', num2str(ss_struct(rando).di)])
ims = readNanoScopeImage(ImDir(ss_struct(rando).di).path);
disp(['Image file: ', ImDir(ss_struct(rando).di).path])

img_flat = mat2gray(imadjust(Flatten(ims(ch).img,3)));
imtool(img_flat)
imtool(edge(img_flat,'Canny'))

[~, sort_ind] = sort(dist_mat(rando,:));
near = sort_ind(2);
disp(['Nearest neighbor number: ', num2str(ss_struct(near).di)])
ims2 = readNanoScopeImage(ImDir(ss_struct(near).di).path);
disp(['Nearest neighbor file: ', ImDir(ss_struct(near).di).path])

img_flat2 = mat2gray(imadjust(Flatten(ims2(ch).img,3)));
imtool(img_flat2)
imtool(edge(img_flat2,'Canny'))

end