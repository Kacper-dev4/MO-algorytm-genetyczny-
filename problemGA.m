clc; clear; close all;

% Definicja problemu plecakowego
numItems = 20;                    % Liczba przedmiotów

% Stałe wartości przedmiotów
values = [85, 42, 77, 99, 36, 58, 91, 45, 78, 62, ...
          88, 30, 55, 72, 48, 94, 66, 81, 50, 39];

% Stałe wagi przedmiotów
weights = [12, 7, 15, 18, 6, 10, 14, 9, 11, 13, ...
           16, 5, 8, 17, 7, 19, 10, 14, 9, 6];

capacity = 50;                     % Maksymalna pojemność plecaka

% Funkcja celu (negatywna suma wartości, bo ga minimalizuje)
fitnessFunction = @(x) -sum(x .* values);

% Ograniczenie wagowe: sum(x .* weights) ≤ capacity
A = weights;  
b = capacity;

% Zakres zmiennych (0 lub 1)
lb = zeros(1, numItems);
ub = ones(1, numItems);
intCon = 1:numItems; % Zmienne muszą być całkowite (0 lub 1)

% Opcje algorytmu genetycznego
options = optimoptions('ga', ...
    'PopulationSize', 10, ...  % Liczba osobników w populacji
    'MaxGenerations', 100, ... % Maksymalna liczba pokoleń
    'CrossoverFraction', 0.8, ... % Procent krzyżowania
    'MutationFcn', {@mutationuniform, 0.1}, ... % Mutacja 10%
    'Display', 'iter'); % Wyświetlanie wyników co iterację

% Uruchomienie algorytmu genetycznego
[x_opt, fval] = ga(fitnessFunction, numItems, A, b, [], [], lb, ub, [], intCon, options);

% Wyświetlenie wyników
disp('Wybrane przedmioty (1 = w plecaku, 0 = poza plecakiem):');
disp(x_opt);
disp(['Maksymalna wartość w plecaku: ', num2str(-fval)]);
disp(['Całkowita waga plecaka: ', num2str(sum(x_opt .* weights))]);