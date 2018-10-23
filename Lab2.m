
% Empty array to store and recursively call on it

poly_array = [];

n = input ('Enter the degree of your polynomial: ');

for i = 0 : n
    
    coeff = input ('Enter the coefficients to your polynomial: ');
    poly_array(end+1) = coeff;
end

x = input('Enter your x value: ');
value = poly(poly_array,x);
fprintf('The sum of your polynomial is: %d \n', value);

prime_value = poly_prime(poly_array,x);
fprintf('The prime total of your polynomial is: %d \n' , prime_value);

%{
approx_array = [];
k = input ('Enter the degree of your polynomial: ');
for i = 0: k
    coef = input ('Enter the coefficients to your polynomial: ');
    approx_array(end+1) = coef; 
end

left_end = input ('Enter a lower end for your polynomial: ');
right_end = input('Enter an upper end for your polynomial: ');
method = input('Enter 1 for bisection, 2 for newton, 3 for second method: ');
error = input('Enter the maximum allowable absolute relation approximation error: ');

newton_x = (left_end + right_end) / 2;

if method == 1
    bi_calc = bisection(approx_array, left_end, right_end, error);
elseif method == 2
    newt_calc = newton(approx_array,newton_x, error);
elseif method == 3
    sec_calc = secant(approx_array,left_end,right_end, error);
else
    disp('Invalid selection.');
end
%}
function bi_x = bisection(a, l, u, error)
   iter = 0;
   relative_error_0 = 100;
   lower = poly(a,l);
   upper = poly(a,u);
   
   if lower*upper > 0
       fprintf('There is no guarantee root in inputed polynomial. \n');
       bi_x = 'error';
       return;
   end
   
   while relative_error_0 >= error 
       iter = iter + 1;
       lower = poly(a,l);
       upper = poly(a,u);
       m = (l + u)/2;
       middle = poly(a,m);
       
       if (lower*middle) == 0
           bi_x = m;
           relative_error = abs((middle-middle)/middle)*100;
           fprintf('x = %f \t poly(a,%f) = %f \t Iteration: %d \t RAE: %f %%\n',m,m,poly(a,m),iter,relative_error);
       end
       
       if (lower*middle) < 0
           relative_error = abs((m-u)/m)*100;
           u = m;
           fprintf('x = %f \t poly(a,%f) = %f \t Iteration: %d \t RAE: %f %%\n',m,m,poly(a,m),iter,relative_error);
       elseif (lower*middle) > 0
           relative_error = abs((m-l)/m)*100;
           l = m;
           fprintf('x = %f \t poly(a,%f) = %f \t Iteration: %d \t RAE: %f %%\n',m,m,poly(a,m),iter,relative_error);
       end
       relative_error_0 = relative_error;
   end
   bi_x = m ; 
end

function sec = secant(a, x_0, x_1, error)
    relative_error = 100;
    iter = 0;
    while relative_error >= error
        iter = iter + 1;
        y_0 = poly(a,x_0);
        y_1 = poly(a,x_1);
        new_x = x_1 - (( y_1*(x_1-x_0))/(y_1-y_0));
        relative_error = abs((new_x-x_1)/new_x)*100;
        x_0 = x_1;
        x_1 = new_x;
        fprintf('x = %f \t poly(a, %f) = %f \t Iteration: %d \t RAE: %f %%\n', x_1,x_1,poly(a,x_1),iter,relative_error);
    end
    sec = x_1;
    
end

function newt = newton (a,x, error)
    relative_error = 100;
    iter = 0;
    while relative_error >= error
        iter = iter + 1;
        y = poly(a,x);
        der = poly_prime(a,x);
        new_x = x - (y/der);
        relative_error = abs((new_x-x)/new_x)*100;
        x = new_x;
        fprintf('x = %f \t poly(a, %f) = %f \t Iteration: %d \t R.A.E: %f \n',x,x,poly(a,x),iter, relative_error);
    end
    newt = x ;
end

function total = poly(a,x)
    k = length(a);
    total = 0;
    for i = 1 : k
        total = total*x + a(i);
    end
end

function prime = poly_prime(a,x)
    k = length(a);
    prime = 0;
    for i = 1 : k-1
        prime = prime*x + (k-i)*a(i);
    end
end