function out = Flatten(img,order)

out = zeros(size(img));

for l = 1:size(img,1)
    out(l,:)=LineFit(img(l,:),order);
end

out = int16(out);
end