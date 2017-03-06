% Create image directory
% dreg = regexpdir('Data','^.*\.\d{3}$',1);
% ImDir = cell2struct(dreg,'path',2);

% Run Hu Analysis and save images
HU=[];
for ii = 1:1000 %length(ImDir)
    ims = HuAnalysis(ImDir,ii);
    ImDir(ii).ims = ims;
    for ch = 1:length(ims)
        HU = [HU; ims(ch).Hu(1:7)];
    end
end

% Save directory with Hu moments and file names

save('ImDir_ReynoldsAFM','ImDir')