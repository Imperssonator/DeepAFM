function Tp = spat_stats_sample(ImDir,rando,ch)

% rando = randi(length(ImDir));
disp(['Image number: ', num2str(rando)])
ims = readNanoScopeImage(ImDir(rando).path);
disp(['Image file: ', ImDir(rando).path])

img_flat = mat2gray(imadjust(Flatten(ims(ch).img,3)));

img_edge=edge(img_flat,'Canny');

% Regular Spat Stats
figure;
T = SpatialStatsFFT(img_edge,img_edge,'periodic',false,'display',true);
Tshift = fftshift(T);
ax=gca;
ax.FontSize=16;

% Polar Spat Stats
Tp = PPFFT(img_edge,5,3);

end