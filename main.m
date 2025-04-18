clear all
clc

c = [70, 40, 35, 50, 60, 160];   % Ceny przedmiotów 
w = [40, 30, 20, 35, 35, 50];    % Wagi przedmiotów
B = 100;                         % Pojemność plecaka
n = length(c);
funkcja = @(x) -sum(c .* x);

lb = zeros(1, n); 
ub = ones(1, n);   

% Opcje algorytmu genetycznego
options = optimoptions('ga', ...
    'MaxGenerations', 100, ...
    'PopulationSize', 10, ...
    'MutationFcn',{@mutationuniform, 0.1},...
    'SelectionFcn','selectionroulette',...
    'CrossoverFcn','crossoversinglepoint',...
    'CrossoverFraction', 0.8, ...
    'Display', 'iter'); 

% Wywołanie algorytmu genetycznego
[x_best, fval] = ga(funkcja, n, w, B, [], [], lb, ub, [], 1:n, options);

wagaPlecaka = sum(w .* x_best);

disp('Najlepszy zestaw przedmiotów:')
disp(x_best)
disp(['Maksymalna wartość plecaka: ', num2str(-fval)])
disp(['Waga przedmiotów w plecaku: ',num2str(wagaPlecaka)])

