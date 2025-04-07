
% Ustawienia poczatkowe
clear all;
clc;

czas_symulacji = 50;

global MODEL;
MODEL = 'Model_silnika_PID_klasyk';  % Nazwa pliku .slx w Simulinku

% Poczatkowe wartosci PID
pid_wartosci_poczatkowe = [1 0.1 0.1];  % Kp, Ki, Kd

% Ograniczenia dla optymalizacji
ograniczenie_dolne = [0.001 0.001 0.001];  % Minimalne wartosci PID
ograniczenie_gorne = [100 50 20];  % Maksymalne wartosci PID

% Ustawienia opcji dla fmincon
options = optimoptions('fmincon', ...
    'Display', 'iter', ... % Wyswietlaj iteracje
    'MaxIterations', 5, ... % Maksymalna liczba iteracji
    'StepTolerance', 1e-6, ... % Tolerancja kroku
    'FunctionTolerance', 1e-6, ... % Tolerancja zmiany funkcji kosztu
    'OptimalityTolerance', 1e-6); % Tolerancja optymalnosci

% Uruchomienie optymalizacji
[wartosci_optymalne, fval, exitflag, output] = fmincon(@optymalizacja_sim_klasyk, pid_wartosci_poczatkowe, [], [], [], [], ograniczenie_dolne, ograniczenie_gorne, [], options);

% Wyswietl optymalne wartosci PID
Wzmocnienia_Optymalne_X = wartosci_optymalne;
disp('Optymalne wartosci PID:');
disp(Wzmocnienia_Optymalne_X);

% Wyswietl informacje o wyniku optymalizacji
disp('Wartosc funkcji kosztu na koncu:');
disp(fval);
disp('Exit flag:');
disp(exitflag);
disp('Informacje o optymalizacji:');
disp(output);
