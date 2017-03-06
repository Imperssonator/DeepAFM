function out = LineFit(line,order)

line = double(line)';

switch order
    case 3
        x_line = (1:length(line))';
        X = [ones(size(line)), x_line, x_line.^2, x_line.^3];
        b = regress(line,X);
        y_hat = b(1)*X(:,1) +...
                b(2)*X(:,2) +...
                b(3)*X(:,3) +...
                b(4)*X(:,4);
        out = (line - y_hat)';
%         out = int16(out);
end

end