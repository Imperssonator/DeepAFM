function ImDir = CompileImgs(FolderPath)
disp(FolderPath)

ad = pwd;

% First compile any images from the folderpath
cd(FolderPath)

PNG = dir('*.png');
JPG = dir('*.jpg');
JPEG = dir('*.jpeg');
BMP = dir('*.bmp');
ImDir = [PNG; JPG; JPEG; BMP]; % Generate directory structure of images in FolderPath

for i = 1:length(ImDir)
    ImDir(i).Folder = FolderPath;
    ImDir(i).path = [FolderPath,ImDir(i).name];
end
disp(ImDir)

if isempty(ImDir)
    ImDir = struct('name',{},...
                    'date',{},...
                    'bytes',{},...
                    'isdir',{},...
                    'datenum',{},...
                    'Folder',{},...
                    'path',{});
end

% Now search subdirectories further
SubDirs = FindAllSubDirs();     % Generate list of subdirectories
cd(ad)
if not(isempty(SubDirs))
    for j = 1:length(SubDirs)
        SubImDir = CompileImgs([FolderPath SubDirs{j} '/']);
        disp(SubImDir)
        ImDir = [ImDir; SubImDir];   % If not empty, also run for all subdirectories
    end
end
disp(ImDir)

end

function out = FindAllSubDirs()

% Generate a cell array of the names of all subdirectories in the current
% directory

D = dir;

Names = {D(:).name};

out = {};

for i = 1:length(Names)
    if D(i).isdir
        Name = Names{i};
        if Name(1) ~= '.'
            out = [out; Name];
        end
    end
end

end