%Lagrange polynomials
function [] = Lagrange_polynomials(n,B,m,Q)
  for i=1:m
    Q(i,2) = polynomial(Q(i,1),B,n,m);
  end
   figure;
   for i=1:n
    plot(B(i,1),B(i,2),'*r',"markersize",20);
    hold on;
  end
  for i=B(1,1):0.01:B(n,1)
    plot(i,polynomial(i,B,n,m),'.k',"markersize",5);
    hold on;
  end
  hold off;
  filename = "output1.txt";
  outf = fopen (filename, "w");
  fprintf(outf , "Lagrange Polynomial Method\n(X ,Y) is\n");
  for i=1:m
     fprintf(outf ,"%f ", Q(i,1));
     fprintf(outf ,"%f\n", Q(i,2));
  end
  fclose(outf);
end
