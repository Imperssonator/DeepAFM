function [ss_mat,ss_struct] = Driver_SSPCA(ImDir)

NumFiles = 1000;
DirInds = randperm(length(ImDir),NumFiles);

disp('Files:')
disp(NumFiles)

standard_size = 256;
ss_mat = zeros(NumFiles,(standard_size+1)^2);
ss_struct = struct();

for i = 1:NumFiles

    di = DirInds(i);
    ss_struct(i).di = di;
    disp(di)
    ss_struct(i).path = ImDir(di).path;
    disp(ImDir(di).path)
    
    % Read in Nanoscope image
    try
        ims = readNanoScopeImage(ImDir(di).path);
        disp('read success')
    catch
        ims = readNanoScopeImage(ImDir(1).path);
        disp('read fail')
    end
    
    % Take the phase image and flatten it
    if length(ims)>=3
        img_flat = imadjust(Flatten(ims(3).img,3));
    else
        img_flat = imadjust(Flatten(ims(1).img,3));
    end
    
    % Resize and find edges
    img_resize = imresize(img_flat,[standard_size, standard_size]);
    bw = edge(img_resize,'canny');
    
    % Compute Spatial stats
    T = SpatialStatsFFT(bw,bw,'periodic',false,'display',false);
    Tshift = fftshift(T);
    ss_mat(i,:) = Tshift(:)';
    
end

[Coef, Score] = pca(ss_mat);

for i = 1:NumFiles
    
    ss_struct(i).pc1 = Score(i,1);
    ss_struct(i).pc2 = Score(i,2);
    ss_struct(i).pc3 = Score(i,3);
    
end

save('AFM_SS','ss_struct','ss_mat')

figure
scatter3(Score(:,1),Score(:,2),(1:NumFiles)','ob')

end