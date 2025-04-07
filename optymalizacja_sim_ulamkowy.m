
function SIM = optymalizacja_sim_ulamkowy(PID)
    % Parametry symulacji
    czas_symulacji = 50;
    global MODEL;

    % Przypisz wartości PID do przestrzeni roboczej Simulinka
    assignin('base', 'Kp', PID(1));  % Ustawienie Kp
    assignin('base', 'Ki', PID(2));  % Ustawienie Ki
    assignin('base', 'Kd', PID(3));  % Ustawienie Kd
    assignin('base', 'Alfa', PID(4));  % Ustawienie Alfa
    assignin('base', 'Beta', PID(5));  % Ustawienie Beta


    % Załaduj model Simulinka, jeśli nie jest załadowany
    if isempty(find_system('Name', MODEL))  % Sprawdza, czy model jest załadowany
        load_system(MODEL);  % Załaduj model, jeśli nie jest załadowany
    end

    % Uruchom symulację modelu Simulinka
    simOut = sim(MODEL, 'SimulationMode', 'normal', 'TimeOut', czas_symulacji);
    
    % Pobierz wynik z bloku Out1, który zawiera kwadrat uchybu
    % Załóżmy, że 'Out1' jest nazwą zmiennej wyjściowej w Simulinku
    kwadrat_uchybu =  simOut.yout.get('Out1111').Values.Data; % Zmienna 'Out1' w Simulinku zawiera kwadrat uchybu
    
    % Zwróć wynik - kwadrat uchybu
    SIM = sum(kwadrat_uchybu);  % Zwróć ostatnią wartość z wyjścia (kwadrat uchybu)
end

