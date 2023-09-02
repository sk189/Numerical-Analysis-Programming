%Natural cubic spline
function [] = Natural_cubic_spline(n,B,m,Q)
  A = zeros(n);
  A(1,1) = 1;
  A(n,n) = 1;
  h = zeros(n-1,1);

  for i = 1:n-1
    h(i) = B(i+1,1) - B(i,1); 
  end
  
  for i = 2:n-1 
    A(i,i-1) = h(i-1); 
    A(i,i) = 2*(h(i-1)+h(i)); 
    A(i,i+1) = h(i); 
  end
  
  b = zeros(n,1);
  for i = 2:n-1 
    b(i) = (3/h(i))*(B(i+1,2)-B(i,2)) - (3/h(i-1))*(B(i,2)-B(i-1,2));     
  end
  cj = A\b;
  bj = zeros(n-1,1); 
  for i = 1:1:n-1 
    bj(i) = (1/h(i))*(B(i+1,2)-B(i,2)) - (1/3*h(i))*(2*cj(i)+cj(i+1)); 
  end
  
  dj = zeros(n-1,1); 
  for i = 1:n-1 
    dj(i) = (1/(3*h(i))) * (cj(i+1)-cj(i)); 
  end
  P = zeros(n-1,4); 
  for i = 1:n-1 
    P(i,1) = dj(i); 
    P(i,2) = cj(i); 
    P(i,3) = bj(i); 
    P(i,4) = B(i,2); 
  end
  for i=1:1:m
    jl = 1; 
    ju = n; 
    while (ju - jl > 1) 
      jm = ceil((jl + ju)/2); 
      if (Q(i,1) < B(jm,1)) 
        ju = jm; 
      else 
        jl = jm; 
      end 
    end
    Q(i,2) = polyval(P(jl,:), Q(i,1)-B(jl,1));
  end
  X =zeros(10000);
  j=1;
  for i=B(1,1):0.01:B(n,1)
    X(j,1)=i;
    j=j+1;
  end;
  i=1;
  for j=B(1,1):0.01:B(n,1)
    jl = 1;
    ju = n; 
    while (ju - jl > 1) 
      jm = ceil((jl + ju)/2); 
      if (X(i,1) < B(jm,1)) 
        ju = jm; 
      else 
        jl = jm; 
      end 
    end
    X(i,2) = polyval(P(jl,:), X(i,1)-B(jl,1));
    i=i+1;
  end
  figure;
  for i=1:n
    plot(B(i,1),B(i,2),'*r',"markersize",20);
    hold on;
  end
  j=1;
  for i=B(1,1):0.01:B(n,1)
    plot(i,X(j,2),'.k',"markersize",5);
    hold on;
    j=j+1;
  end
  hold off;
  filename = "output1.txt";
  outf = fopen (filename, "w");
  fprintf(outf , "Natural Cubic Spline Method\n(X ,Y) is\n");
  for i=1:m
     fprintf(outf ,"%f ", Q(i,1));
     fprintf(outf ,"%f\n", Q(i,2));
  end
  fclose(outf);