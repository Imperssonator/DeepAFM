function ImDir = Make_Image_Files(ImDir)

NumFiles = length(ImDir);
% DirInds = randperm(length(ImDir),NumFiles);

disp('Files:')
disp(NumFiles)

for di = 1:length(ImDir)
    
    disp('---------')
    disp([num2str(di), 'of', num2str(length(ImDir))])
    disp(ImDir(di).path)
    
    % Read in Nanoscope image
    try
        ims = readNanoScopeImage(ImDir(di).path);
        disp('read success')
    catch
        ims = [];
        disp('read fail')
    end
    
    if not(isempty(ims))
        
        % Add ims to the ImDir structure
        % Write a tif to a file next to the raw file
        for ch = 1:length(ims)
            ims(ch).img_flat = imadjust(Flatten(ims(ch).img,3));
            ims(ch).img_path = [ImDir(di).path(1:end), '_', num2str(ch), '.tif'];
            imwrite(mat2gray(ims(ch).img_flat),ims(ch).img_path)
        end
        
    end
    
end