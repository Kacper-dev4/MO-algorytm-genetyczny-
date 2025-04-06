clear all
clc

najlepszy = 0;
ponowneWystapienie = 0;

n = 4;
popSize = 30;

funkcja = @(x) -1*(50 * x(1) + 70 * x(2) + 90 * x(3) + 120 * x(4));

A = [1, 2, 3, 1;
     1, 1, 1, 2;
     2, 3, 1, 0];
B = [100;
     150;
     230];

lb = zeros(1, n); 

% Opcje algorytmu genetycznego
options = optimoptions('ga', ...
    'MaxGenerations', 100, ...
    'PopulationSize', popSize, ...
    'MutationFcn',{@mutationuniform, 0.1},...
    'SelectionFcn','selectionroulette',...
    'CrossoverFcn','crossoversinglepoint',...
    'CrossoverFraction', 0.8, ... 
    'Display', 'iter'); 

% Wywołanie algorytmu genetycznego
for i=1:20
[x, fval] = ga(funkcja, n, A, B, [], [], lb, [], [], 1:n, options);


disp('Najlepszy zestaw: ')
disp(x)
disp(['Maksymalna wartość odzieży: ', num2str(-fval)])

if -fval == najlepszy
    ponowneWystapienie = ponowneWystapienie +1;
end

if -fval > najlepszy
    najlepszy = -fval;
    ponowneWystapienie = 0;
    x_best = x;
end

end

disp('Najlepszy zestaw końcowy: ')
disp(x_best)
disp(['Maksymalna wartość odzieży: ', num2str(najlepszy)])