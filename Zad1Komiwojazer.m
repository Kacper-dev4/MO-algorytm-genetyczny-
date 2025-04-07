clear all
clc


nMiast = 8;
popSize = 10; 

% Generowanie losowej macierzy odległości między miastami
odleglosci = randi([10 100], nMiast);
d = triu(odleglosci,1);
odleglosci = triu(odleglosci,1) + triu(odleglosci,1)'; % symetryczna
% Funkcja celu – suma odległości po trasie + powrót do punktu startowego
funkcja = @(x) sum(sum(x*d));

najlepszy = inf;
ponowneWystapienie = 0;

 % Rozwiązanie jako permutacja miast (liczby od 1 do nMiast)
    intcon = 1:nMiast;
    lb = zeros(1,nMiast);
    ub = ones(1,nMiast);

 % Ograniczenia liniowe problemu komiwijażera każde miasto ma 2 połączenia
 % z pozostałymi miastami
    Aeq = [ones(8,8)];
    beq = [ones(8,1)];

% Ustawienia algorytmu genetycznego
options = optimoptions('ga', ...
    'MaxGenerations', 10, ...
    'PopulationSize', popSize, ...
    'MutationFcn', {@mutationuniform, 0.2}, ...
    'CrossoverFcn', @crossoversinglepoint, ...
    'SelectionFcn','selectiontournament',...
    'CrossoverFraction', 0.8, ...
    'Display', 'iter');

for i = 1:20
   

    [x_best, fval] = ga(funkcja, f, [], [], Aeq, beq, lb, ub, [], 1:nMiast , options);

    disp(['Najlepsza trasa nr ', num2str(i), ': ', mat2str(round(x_best))])
    disp(['Całkowity dystans: ', num2str(fval)])

    if fval == najlepszy
        ponowneWystapienie = ponowneWystapienie + 1;
    end

    if fval < najlepszy
        najlepszy = fval;
        ponowneWystapienie = 0;
    end
end
