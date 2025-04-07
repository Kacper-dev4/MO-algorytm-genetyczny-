clear all
clc

najlepszy = 0;
ponowneWystapienie = 0;
sumaGeneracji = 0;

n = input("Podaj ile przedmiotów do wylosowania: ");
B = input("Podaj pojemność plecaka: ");
c_ll = input("Podaj dolny limit cen przedmiotów: ");
c_ul = input("Podaj górny limit cen przedmiotów: ");
w_ll = input("Podaj dolny limit wagi przedmiotów: ");
w_ul = input("Podaj górny limit wagi przedmiotów: ");
popSize = input("Jaka ma być wielkość populacji: ");

c = randi([c_ll,c_ul],1,n);
w = randi([w_ll,w_ul],1,n);

funkcja = @(x) -sum(c .* x);

lb = zeros(1, n); 
ub = ones(1, n);   

% Do przechowywania liczby generacji
global ostatniaGeneracja
ostatniaGeneracja = 0;

% Output function do zliczania generacji
outputFcn = @(options,state,flag) zapiszGeneracje(options,state,flag);

% Opcje algorytmu genetycznego
options = optimoptions('ga', ...
    'MaxGenerations', 25, ...
    'PopulationSize', popSize, ...
    'MutationFcn',{@mutationuniform, 0.1},...
    'SelectionFcn','selectionroulette',...
    'CrossoverFcn','crossoversinglepoint',...
    'CrossoverFraction', 0.8, ...
    'Display', 'iter', ...
    'OutputFcn', outputFcn); 

for i=1:20
    [x, fval] = ga(funkcja, n, w, B, [], [], lb, ub, [], 1:n, options);

    wagaPlecaka = sum(w .* x);

    disp(['Najlepszy zestaw przedmiotów dla rozmiaru populacji ', num2str(popSize), ':' ])
    disp(x)
    disp(['Maksymalna wartość plecaka: ', num2str(-fval)])
    disp(['Waga przedmiotów w plecaku: ', num2str(wagaPlecaka)])
    disp(['Liczba generacji: ', num2str(ostatniaGeneracja)])

    sumaGeneracji = sumaGeneracji + ostatniaGeneracja;

    if -fval == najlepszy
        ponowneWystapienie = ponowneWystapienie +1;
    end

    if -fval > najlepszy
        najlepszy = -fval;
        x_best = x;
        ponowneWystapienie = 0;
    end
end

disp('Najlepszy zestaw końcowy: ')
disp(x_best)
disp(['Maksymalna wartość plecaka: ', num2str(najlepszy)])

sredniaGeneracji = sumaGeneracji / 20;
disp(['Średnia liczba generacji: ', num2str(sredniaGeneracji)])


% Output function
function [state, options, optchanged] = zapiszGeneracje(options,state,flag)
    global ostatniaGeneracja
    optchanged = false;

    if strcmp(flag, 'done') % tylko na końcu
        ostatniaGeneracja = state.Generation;
    end
end
