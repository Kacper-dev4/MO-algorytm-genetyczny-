clear all
clc

najlepszy = 0;
ponowneWystapienie = 0;

n = input("Podaj ile przedmiotów do wylosowania: ");
B = input("Podaj pojemność plecak: ");
c_ll = input("Podaj dolny limit cen przedmiotów: ");
c_ul = input("Podaj górny limit cen przedmiotów: ");
w_ll = input("Podaj dolny limit wagi przedmiotów: ");
w_ul = input("Podaj górny limit wagi przedmiotów: ");
popSize = input("Jaka ma być wielkość populacji: ");


c = randi([c_ll,c_ul],1,n);
w = randi([w_ll,w_ul],1,n);

%c = [70, 40, 35, 50, 60, 160];   % Ceny przedmiotów 
%w = [40, 30, 20, 35, 35, 50];    % Wagi przedmiotów
%B = 100;                         % Pojemność plecaka
%n = length(c);
funkcja = @(x) -sum(c .* x);

lb = zeros(1, n); 
ub = ones(1, n);   

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
[x_best, fval] = ga(funkcja, n, w, B, [], [], lb, ub, [], 1:n, options);

wagaPlecaka = sum(w .* x_best);

disp(['Najlepszy zestaw przedmiotów dla rozmiaru populacji ', num2str(popSize) ,':' ])
disp(x_best)
disp(['Maksymalna wartość plecaka: ', num2str(-fval)])
disp(['Waga przedmiotów w plecaku: ',num2str(wagaPlecaka)])

if -fval == najlepszy
    ponowneWystapienie = ponowneWystapienie +1;
end

if -fval > najlepszy
    najlepszy = -fval;
    ponowneWystapienie = 0;
end


end