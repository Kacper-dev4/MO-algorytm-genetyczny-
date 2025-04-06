clear all
clc

najlepszy = 0;
ponowneWystapienie = 0;

n = 3;
popSize = 10;

funkcja = @(x) -1*(20000 * x(1) + 25000 * x(2) + 30000 * x(3));

A = [1, 2, 3;
     1, 1, 1];
B = [100;
     150];

lb = zeros(1, n); 

% Opcje algorytmu genetycznego
options = optimoptions('ga', ...
    'MaxGenerations', 10, ...
    'PopulationSize', popSize, ...
    'MutationFcn',{@mutationuniform, 0.1},...
    'SelectionFcn','selectionroulette',...
    'CrossoverFcn','crossoversinglepoint',...
    'CrossoverFraction', 0.8);
    %'Display', 'iter'); 

% Wywołanie algorytmu genetycznego
for i=1:20
[x_best, fval] = ga(funkcja, n, A, B, [], [], lb, [], [], 1:n, options);


disp('Najlepszy zestaw: ')
disp(x_best)
disp(['Maksymalna wartość pojazdów: ', num2str(-fval)])

if -fval == najlepszy
    ponowneWystapienie = ponowneWystapienie +1;
end

if -fval > najlepszy
    najlepszy = -fval;
    ponowneWystapienie = 0;
end


end