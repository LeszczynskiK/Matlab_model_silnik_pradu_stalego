

% Ustawienia poczatkowe
clear all;
clc;

% Czas symulacji w sekundach
czas_symulacji = 50;

% Globalna zmienna przechowujaca model silnika
global MODEL;
MODEL = 'Model_silnika_PID_ulamkowy'; 

% Ograniczenia dla optymalizacji (dolne i gorne)
ograniczenie_dolne = [0 0 0 0.0001 0.0001];  % Minimalne wartosci dla PID
ograniczenie_gorne = [100 100 0.5 0.999 0.999];   % Maksymalne wartosci dla PID

% Poczatkowe wartosci dla PID (wzmocnienia)
pid_wartosci_poczatkowe = [5 0.5 0.5 0.1 0.5]; % wzmocnienia dla FOPIDa X

% Ustawienia opcji dla funkcji optymalizacji fmincon
options = optimoptions('fmincon', ...
    'Display', 'iter', ... % Wyswietlaj iteracje
    'MaxIterations', 2, ... % Maksymalna liczba iteracji
    'StepTolerance', 1e-3, ... % Tolerancja kroku
    'FunctionTolerance', 1e-3, ... % Tolerancja zmiany funkcji kosztu
    'OptimalityTolerance', 1e-3); % Tolerancja optymalnosci

% Uruchomienie optymalizacji z początkowymi wartościami PID
[wartosci_optymalne, fval, exitflag, output] = fmincon(@optymalizacja_sim_ulamkowy, pid_wartosci_poczatkowe, [], [], [], [], ograniczenie_dolne, ograniczenie_gorne, [], options);

% Przypisanie wynikow optymalizacji do zmiennej
Wzmocnienia_Optymalne_X = wartosci_optymalne;

% Wyswietl optymalne wartosci PID
disp('Optymalne wartosci PID:');
disp(Wzmocnienia_Optymalne_X);

% Wyswietl informacje o wyniku optymalizacji
disp('Wartosc funkcji kosztu na koncu:');
disp(fval);
disp('Exit flag:');
disp(exitflag);
disp('Informacje o optymalizacji:');
disp(output);
