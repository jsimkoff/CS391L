function [frame, xvec] = cleandata(filename)
%filename = 'GPdata_SG.csv';
GPdata = load(filename);
%GPdata = load('GPdata_MC.csv');
%GPdata = load('GPdata_CJ.csv');
frame = GPdata(:,1);
x1 = GPdata(:,2);
c1 = GPdata(:,5);

x2 = GPdata(:,6);
c2 = GPdata(:,9);

x3 = GPdata(:,10);
c3 = GPdata(:,13);

x4 = GPdata(:,14);
c4 = GPdata(:,17);

x5 = GPdata(:,18);
c5 = GPdata(:,21);


%figure();subplot(1,2,1); plot(x1); hold on; plot(x2); plot(x3); plot(x4); plot(x5);title('raw data')
%%

for i = 1:length(x1)
    if c1(i) < 0
        x1(i) = x1(i-1) + 0.5*(x1(i-1) - x1(i-2));

    end
    if c2(i) < 0 &&  (i>2)
        x2(i) = x2(i-1) + 0.5*(x2(i-1) - x2(i-2));

    end
   
    
    if c3(i) < 0 && (i > 2)
        x3(i) = x3(i-1) + 0.5*(x3(i-1) - x3(i-2));
  
    end
      if c3(i) < 0 &&  (i<=2)
        x2(i) = x2(i+2) - 0.5*(x2(i+3) - x2(i+2));
    
    end
    
      if c4(i) < 0
        x4(i) = x4(i-1) + 0.5*(x4(i-1) - x4(i-2));

      end
    
    if c5(i) < 0
        x5(i) = x5(i-1) + 0.5*(x5(i-1) - x5(i-2));

    end
end

%subplot(1,2,2); plot(x1); hold on; plot(x2); plot(x3); plot(x4); plot(x5);title('cleaned data')
xvec = [x1 x2 x3 x4 x5];
end