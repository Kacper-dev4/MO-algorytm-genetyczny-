clc; clear; close all;

najlepszy = inf;
wieze = 8;

lb = ones(1, wieze);
ub = 8*ones(1, wieze);
intCon = 1:wieze;

% Parametr algorytmu genetycznego
l_populacji = 20;

% Przechowywanie wyników
najlepsze_wartosci = zeros(1, 20);
generacje = zeros(1, 20);

% Włączenie parowania danych do zbioru
for i = 1:20
    options = optimoptions('ga', ...
        'PopulationSize', l_populacji, ...
        'MaxGenerations', 100, ...
        'CrossoverFraction', 0.8, ...
        'MutationFcn', {@mutationuniform, 0.1}, ...
        'Display', 'off', ...
        'PlotFcn', []); % Wyłącz wykresy

    % Uruchomienie algorytmu genetycznego
    [x, fval, ~, output] = ga(@fun2, wieze, [], [], [], [], lb, ub, [], intCon, options);

    najlepsze_wartosci(i) = fval;  % Zamiana na dodatnią wartość
    generacje(i) = output.generations;


if fval < najlepszy
    najlepszy = fval;
    x_best = x;
    
end

end

% Analiza wyników
najlepsza = min(najlepsze_wartosci);
ile_razy = sum(najlepsze_wartosci == najlepsza);
srednia_gen = mean(generacje);

% Tworzenie tabeli wyników
T = table(l_populacji, najlepsza, ile_razy, srednia_gen, ...
    'VariableNames', {'RozmiarPopulacji', 'NajlepszaWartosc', 'IloscNajlepszych', 'SredniaGeneracji'});

% Wyświetlenie tabeli i informacji
disp(T);

disp('Najlepszy zestaw końcowy: ')
disp(x_best)
disp(['Wartość funkcji celu: ', num2str(najlepszy)])