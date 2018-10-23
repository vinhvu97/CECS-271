disp('****************************************');
disp('Part 1: Finding the coefficients of a maxtrix.');
m = input('Please input in a matrix: ');
i = input('Please input a lower bound: ');
j = input('Please input an upper bound: ');
coeff_f = ndff(m,i,j);
fprintf('The coefficient from order pair %d to %d is %f \n',i,j,coeff_f);

disp('****************************************');
disp('Part 2: Finding the sum of an inputed Newton Divided Difference.');
b = input('Please enter a vector b: ');
x = input('Please enter a vector x: ');
z = input('Please enter z value: ');
p_n = poly_newton(b, x, z);
fprintf('The value of your Newton polynomial is: %f \n',p_n);

disp('****************************************');
disp('Part 3: Finding the sums of Newton Divided Difference from multiple z values.');
newton_m = input('Please input Newton-divided Difference matrix: ');
newton_z = input('Please input vector z: ');
P = newton_Divided(newton_m, newton_z);
fprintf('The Newton-Divided Difference polynomial of z value is %f\n', P);

disp('****************************************');
disp('Part 4: Graphing the polynomials');
matrix = input('Please input a matrix for graph: ');
m_graph = input('Please input a positive integer for change of x: ');
graph_matrix = graph(matrix, m_graph);
line_graph_x = matrix(:,1);
line_graph_y = matrix(:,2);
scatter(line_graph_x,line_graph_y);
title('Newton Divided Difference Graph');
hold on
dot_graph_x = graph_matrix(:,1);
dot_graph_y = graph_matrix(:,2);
plot(dot_graph_x,dot_graph_y);

function coeff = ndff(m,i,j)
    if i == j
        coeff = m(i,2);
    elseif (abs(i-j)==1)
        x_1 = m(i,1);
        x_2 = m(j,1);
        y_1 = m(i,2);
        y_2 = m(j,2);
        coeff = (y_2-y_1)/(x_2-x_1);
    else
        coeff = (( ndff(m,i+1,j)- ndff(m,i,j-1)))/ ( m(j,1)- m(i,1));
    end   

end

function pn = poly_newton (b ,x ,z)
    prod = 0;
    for i = 1: length(b)
        if i == 1
            pn = b(i);  
        else 
            prod = 1;
            for k = 1 : i-1
                prod = prod * (z-x(k));
            end 
            prod = prod * b(i);
        end 
        pn = pn + prod;
    end
end
                                                                                                                                                                                                   
function new_P = newton_Divided (m, z)
    p_n = [];
    
    coeff = [];
    for i = 1: size(m,1)
        coeff(end+1) = ndff(m,1,i);
    end
    
    x = [];
    for j = 1 : size(m,1)
        x(end+1) = m(j,1);
    end
    
    for k = 1 : length(z)
        p_n(end+1) = poly_newton(coeff,x,z(k));
    end
    
    new_P = p_n;
    
end

function matrix_z = graph(matrix, m)
    z = [];
    [x,y] = size(matrix);
    delt_x = (matrix(x,1)-matrix(1,1))/m;
    for i = 1 : m
        z_i = matrix(1,1) + i*delt_x;
        z(end+1) = z_i;
    end
    Pn_z = []; 
    for i = 1 : length(z)
        Pn_i = newton_Divided (matrix,z(i));
        Pn_z(end+1) = Pn_i;
    end
    
    vertical_z = reshape(z,[length(z),1]);
    vert_Pn_z = reshape (Pn_z, [length(Pn_z),1]);
    matrix_z = cat(2,vertical_z,vert_Pn_z);
end




