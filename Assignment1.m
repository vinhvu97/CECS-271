% Vinh Vu, 015347252, Assignment 1

% Prompt user to input an absolute relative approximate error
approx = input ('Enter an absolute approximate error: ');

%default relative error for comparasion to user's input
relative_error = 100;

%Number of rectangles for calculation, starting at 1 rectangle
n = 1;

% Temporary value for (2)
t = 0; 

while relative_error > approx
    
    % The two different area calculations for approximate error 
    present_area = rectangle_approx(n);
    previous_area = rectangle_approx(n-1);
    
    % Absolute approximate error calculations
    approx_error = abs(present_area - previous_area);
    relative_error = (abs(approx_error / present_area))*100;
    
    % Outputing the results for each iteration
    fprintf( 'n: %f \t Approximate value: %f \t Approximate Error: %f \t Relative Error: %f%% \n', n, present_area, approx_error, relative_error);
    
    % Increment the number of rectangles if the error is still larger than
    % user's input
    n = n + 1; 
end
disp('The relative approximation error is now less than your input!');

while(t < 2)
    
    % Inputing range for outputing the elements
    m = input('Enter a a starting point integer: ');
    p = input('Enter an ending point integer: ');
    
    % Power k for the iterations
    k = input('Enter a positive number: ');
    
    % The range of outputing elements
    length = p - m + 1; 
    
    % Displaying the increasing elements user wanted
    for i = length:p
        element = elementAt(i,k);
        fprintf('n = %d \t x_%d = %f \n' ,i, i, element);
    end
    t = t + 1; 
end

% Function derived from (2) equation to solve for a particular term
function term = elementAt(n,k)

    % Default previous element 
    previous = 1;
   
    for i = 1:n
        
        if (i == 1)
            term = 1;
            previous = term ;
        else
            c = (1-1/(i^k));
            term = previous / c;
            previous = term;
        end
    end
end

% Function created to calculate the rectangular approximation
function approx_calc = rectangle_approx(n)
    
    width = (2*pi)/n;
    approx_calc = 0;
    x = 0;
    
    %For loop to calculate the rectangle approximation 
    for iter = 0:n-1
        height = exp(cos(x));
        rectangle = height*width;
        approx_calc = approx_calc + rectangle;
        x = x + width;
    end
end 
