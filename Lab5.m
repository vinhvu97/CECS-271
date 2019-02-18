choice = input('Enter \n1. Cosine coefficients \n2. Sine coefficents \n3. Sum-Squared Error\n4. Graph\n');
if (choice==1)
    k = input('Enter a non-negative k value: ');
    c_val = (1/pi)*simpson(f_cos,0,2*pi,k,100);
    fprintf("C_%d: %f \n",k,c_val);
elseif (choice == 2)
    k = input('Enter a non-negative k value: ');
    d_val = (1/pi)*simpson(f_sin, 0,2*pi,k,100);
    fprintf("D_%d: %f \n",k,d_val);
elseif (choice == 3)
    n = input('Enter an integer greater than 0: ');
    sum = sse(f_c0,n,0,2*pi);
    fprintf('the Sum Squared Error: %f \n',sum);
    
elseif (choice == 4)
    m = input ('Enter number of points: ');
    n = input ('Enter number of Fourier degree: ');
    x = linspace(0,2*pi,m);
    
    y=(cos(3*t));
    plot(x,y)
    
    hold on
    
    y_1=fourier(n,x);
    plot(x,y_1);
end

f_cos = @(t,k) (cos(3*t)) * cos(k*t);
f_sin = @(t,k) (cos(3*t)) * sin(k*t);
f_c0  = @(t,k) (cos(3*t)) + 0*k ;

function  result = simpson(f, a, b, k, n) 
    const = (b - a)/(3*n);
    step_size = (b-a)/n;
    x_val = [];
    
    for i = 0:n
        x = a + i*step_size;
        x_val(end+1) = x; 
    end
    
    for j = 1 : length(x_val)
        if(j == 1)
            result = f(x_val(j),k);
            
        elseif (j == length(x_val))
            result = result + f(x_val(j),k);
        else
            if (mod(j,2) == 0)
                result = result + 4*f(x_val(j),k);
            elseif (mod(j,2) == 1)
                result = result + 2*f(x_val(j),k);
            end
        end
    end
    result = const * result;
end
 
function four = fourier (n,t)
    a=0;
    b=2*pi;
    seg = 100;
    f_cos = @(t,k) (cos(3*t)) * cos(k*t);
    f_sin = @(t,k) (cos(3*t)) * sin(k*t);
    f_c0  = @(t,k) (cos(3*t)) + 0*k ;
    c_0 = simpson(f_c0,a,b,0,seg);
    four = c_0/(2*pi);
    
    for i = 1: n
        ck = (1/pi) * (simpson(f_cos,a,b,i,seg));
        dk = (1/pi) * (simpson(f_sin,a,b,i,seg));
        four = four + (ck*cos(i*t)) + (dk*sin(i*t));
    end
end

function sum_sse = sse(ft, n, a, b)
    x_val=[];
    sum_sse=0;
    seg = 1000;
    step = (b-a)/seg;
    const = (b-a)/(3*seg);
    seg = 1000; 
    for i = 0:seg
        x = a+i*step;
        x_val(end+1)=x;
    end

    for j = 1:length(x_val)
        if (j == 1)
            sum_sse = (ft(x_val(j),0)-fourier(n,x_val(j)))^2;
        elseif (j == length(x_val))
            sum_sse = sum_sse + (ft(x_val(j),0)-fourier(n,x_val(j)))^2;
        else 
            if (mod(j,2)==0)
                sum_sse = sum_sse + 4*((ft(x_val(j),0)-fourier(n,x_val(j))))^2;
            elseif (mod(j,2) == 1)
                sum_sse = sum_sse + 2*((ft(x_val(j),0)-fourier(n,x_val(j))))^2;
            end
        end
    end
    sum_sse = sum_sse * const;
end