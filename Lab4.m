t = 0;
s = 75;
T = input('Please enter time period: ');
n = input('Please enter increment value: ');
method = input('Enter the method you want to execute. \n0. Euler\n1. Prediction-Correction\n2. Exact 2nd-order\n3. Midpoint\n4. Ralston \n');
h = T/n;
approx = [];
real = [];
all_t = [];
i = 1;
%{
if (method == 0)
    while t < T
        EU = Euler(t,s,h);
        real_s = real_S(t,s);
        approx(end+1) = EU;
        real(end+1) = real_s;
        all_t(end+1) = t;
        disp('*******************************');
        fprintf('Iteration: %d \n',i);
        fprintf('The Euler Calculation is: %f. \n', EU);
        fprintf('The true value is: %f. \n',real_s);
        t = t + h;
        s = EU; 
        i = i + 1;
    end
    dot_graph_x = all_t;
    dot_graph_y = approx;
    scatter(dot_graph_x,dot_graph_y);
    title('Euler Approximation Graph');
    hold on
        
    line_graph_x = all_t;
    line_graph_y = real;
    plot(line_graph_x,line_graph_y);
    
elseif (method == 1)
    while t < T
        pre = prediction(t,s,t+h,h);
        real_s = real_S(t,s);
        approx(end+1) = pre;
        real(end+1) = real_s;
        all_t(end+1) = t;
        disp('*******************************');
        fprintf('Iteration: %d \n',i);
        fprintf('The Prediction Correction Calculation is: %f. \n', pre);
        fprintf('The true value is: %f. \n',real_s);
        s = pre;
        t = t + h;
        i = i + 1;
    end
    dot_graph_x = all_t;
    dot_graph_y = approx;
    scatter(dot_graph_x,dot_graph_y);
    title('Predction-Correction Approximation Graph');
    hold on
        
    line_graph_x = all_t;
    line_graph_y = real;
    plot(line_graph_x,line_graph_y);
    
elseif (method == 2)
    while t < T
        sec = exact_2nd(t,s,h);
        real_s = real_S(t,s);
        approx(end+1) = sec;
        real(end+1) = real_s;
        all_t(end+1) = t;
        disp('*******************************');
        fprintf('Iteration: %d \n',i);
        fprintf('The Exact 2nd Order Calculation is: %f. \n', sec);
        fprintf('The true value is: %f. \n',real_s);
        t = t + h;
        s = sec;
        i = i + 1;
        
    end
    dot_graph_x = all_t;
    dot_graph_y = approx;
    scatter(dot_graph_x,dot_graph_y);
    title('Second Order Approximation Graph');
    hold on
        
    line_graph_x = all_t;
    line_graph_y = real;
    plot(line_graph_x,line_graph_y);
    
elseif (method == 3)
    while t < T
       middle = midpoint(t,s,h);
       real_s = real_S(t,s);
       approx(end+1) = middle;
       real(end+1) = real_s;
       all_t(end+1) = t;
       disp('*******************************');
       fprintf('Iteration: %d \n',i);
       fprintf('The Midpoint Calculation is: %f. \n', middle);
       fprintf('The true value is: %f. \n',real_s);
       t = t + h;
       s = middle;
       i = i + 1;
    end
    dot_graph_x = all_t;
    dot_graph_y = approx;
    scatter(dot_graph_x,dot_graph_y);
    title('Midpoint Approximation Graph');
    hold on
        
    line_graph_x = all_t;
    line_graph_y = real;
    plot(line_graph_x,line_graph_y);
    
elseif (method == 4)
    while t < T
        rals = ralston(t,s,h);
        real_s = real_S(t,s);
        approx(end+1) = rals;
        real(end+1) = real_s;
        all_t(end+1) = t;
        disp('*******************************');
        fprintf('Iteration: %d \n',i);
        fprintf('The Ralston Calculation is: %f. \n', rals);
        fprintf('The true value is: %f. \n',real_s);
        t = t + h;
        s = rals;
        i = i + 1;
    end
    dot_graph_x = all_t;
    dot_graph_y = approx;
    scatter(dot_graph_x,dot_graph_y);
    title('Ralston Approximation Graph');
    hold on
        
    line_graph_x = all_t;
    line_graph_y = real;
    plot(line_graph_x,line_graph_y);
end
%}
value_EU = 0;
value_pre = 0;
value_sec = 0;
value_middle = 0;
value_rals = 0;
t_EU = t;
t_pre = t;
t_sec = t;
t_mid = t;
t_rals = t;

while t_EU <= T
    EU = Euler(t_EU,s,h);
	real_s = real_S(t_EU,s);
	value_EU = value_EU + (EU - real_s)^2;
    s = EU;
    t_EU = t_EU + h;
end

s = 75;
while t_pre<=T
	pre = prediction(t_pre,s,t_pre+h,h);
	real_pre = real_S(t_pre,s);
	value_pre = value_pre + (pre-real_pre)^2;
    s = pre;
    t_pre = t_pre+h;
end

s=75;
while t_sec<=T
	sec = exact_2nd(t_sec,s,h);
	real_sec = real_S(t_sec,s);
	value_sec = value_sec + (sec - real_sec)^2;
    s = sec;
    t_sec = t_sec + h;
end

s=75;
while t_mid<=T
	middle = midpoint(t_mid,s,h);
	real_middle = real_S(t_mid,s);
	value_middle = value_middle + (middle - real_middle)^2;
    s = middle;
    t_mid = t_mid + h ;
end

s=75;
while t_rals<=T
	rals = ralston(t_rals,s,h);
	real_rals = real_S(t_rals,s);
	value_rals = value_rals + (rals-real_rals)^2;
    s = rals;
    t_rals = t_rals + h;
end

EU_close = sqrt(value_EU);
pre_close = sqrt(value_pre);
sec_close = sqrt(value_sec);
mid_close = sqrt(value_middle);
rals_close = sqrt(value_rals);

fprintf("Euler: %f \t Predction-Correction: %f \t Exact Order: %f \t Midpoint: %f \t Ralston: %f \n",EU_close, pre_close, sec_close, mid_close, rals_close);


function real = real_S(x,y)
    real = (125/3)+(100/3)*exp(-3*x/500);
end

function f = funct_S(x,y)
    f =(1/4)-(3/500)*((125/3)+(100/3)*exp(-3*x/500));
end

function eu = Euler (x,y,h)
    eu = (y+h*funct_S(x,y));
end

function pre_corr = prediction(x,y,x_1,h)
    y_star = y+h*funct_S(x,y);
    pre_corr = (y+h*(funct_S(x,y)+funct_S(x_1,y_star))/2);
end

function second = exact_2nd (x,y,h)
    der = (-3/500)*((1/4)-((3/500)*((125/3)+(100/3)*exp(-3*x/500))));
    second = y+h*funct_S(x,y)+h^2*der/2;
end

function midd = midpoint(x,y,h)
    y_star = y + h*funct_S(x,y)/2;
    midd = y + h*funct_S(x+1/2*h,y_star);
end

function rals = ralston (x,y,h)
    y_star = y +(3/4)*h*funct_S(x,y);
    rals = y + h*((1/3)*funct_S(x,y)+(2/3)*funct_S(x+(3/4)*h,y_star));
end
