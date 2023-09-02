clear;
fprintf("Give your no. of data and data points along with the the qwery abscissa value in a file named 'input1.txt'\n");
fprintf("Press ENTER to continue\n\n");
fid = fopen("input1.txt");
line =fgetl(fid);
n = sscanf(line, '%f ');
B = zeros(n,2);
for i=1:1:n
  line = fgetl(fid);
  B(i,1:1:2) = sscanf(line, '%f ');
end
line =fgetl(fid);
m = sscanf(line, '%f ');
Q = zeros(m,2);
for i=1:1:m
  line = fgetl(fid);
  Q(i,1) = sscanf(line, '%f ');
end
fprintf("Enter the method you want to use\n");
fprintf("1. Lagrange polynomial\n2. Natural cubic spline\n");
method = input("");

if method == 1
  Lagrange_polynomials(n,B,m,Q);
end

if method == 2
  Natural_cubic_spline(n,B,m,Q);
end