clc; clear; close all;

% Definicja problemu plecakowego
przedmioty = 20;

% Losowo wygenerowane wartości cen oraz wag
wartosc = [85, 42, 77, 99, 36, 58, 91, 45, 78, 62, ...
        88, 30, 55, 72, 48, 94, 66, 81, 50, 39];
waga = [12, 7, 15, 18, 6, 10, 14, 9, 11, 13, ...
        16, 5, 8, 17, 7, 19, 10, 14, 9, 6];

plecak_waga = 50;
%funckja celu
funkcja = @(x) -sum(x .* wartosc);
A = waga;  
b = plecak_waga;
lb = zeros(1, przedmioty);
ub = ones(1, przedmioty);
intCon = 1:przedmioty;

% Parametr algorytmu genetycznego
l_populacji = 5;

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
        'EliteCount', 4, ...
        'PlotFcn', []); % Wyłącz wykresy

    % Uruchomienie algorytmu genetycznego
    [~, cena_plecak, ~, output] = ga(funkcja, przedmioty, A, b, [], [], lb, ub, [], intCon, options);

    najlepsze_wartosci(i) = -cena_plecak;  % Zamiana na dodatnią wartość
    generacje(i) = output.generations;
end

% Analiza wyników
najlepsza = max(najlepsze_wartosci);
ile_razy = sum(najlepsze_wartosci == najlepsza);
srednia_gen = mean(generacje);

% Tworzenie tabeli wyników
T = table(l_populacji, najlepsza, ile_razy, srednia_gen, ...
    'VariableNames', {'RozmiarPopulacji', 'NajlepszaWartosc', 'IloscNajlepszych', 'SredniaGeneracji'});

% Wyświetlenie tabeli i informacji
disp(T);