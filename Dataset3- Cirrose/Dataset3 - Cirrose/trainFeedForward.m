function trainFeedForward()
%Utilizar este gravar as 3 melhores redes que pode ser com diferentes
%valores
clear all;
close all;

% Carrega o dataset
data = readtable('trainModifiedNew.csv');
StartInputs = table2array(data(:, 1:end-1))'; % Entradas
StartTargets = table2array(data(:, end))'; % Saídas
oneHotTargets = onehotencode(StartTargets,1,'ClassNames',1:4);

% Definição das configurações a serem testadas
hidden_layers = {1, 2, 3}; % Número de camadas ocultas
neurons = {10, 20, 30};  % Número de neurônios em cada camada oculta
train_functions = {'trainlm', 'trainbr', 'traingdx'}; % Funções de treino
activation_functions = {'tansig', 'logsig', 'purelin'}; % Funções de ativação

% Definição das proporções de divisão para cada conjunto
train_ratios = [0.6, 0.7, 0.5]; % Proporções de divisão de treinamento para cada função de treinamento
val_ratios = [0.15, 0.15, 0.2]; % Proporções de divisão de validação para cada função de treinamento
test_ratios = [0.25, 0.15, 0.3]; % Proporções de divisão de teste para cada função de treinamento

% Inicializa as variáveis para armazenar os resultados
best_networks = cell(3, 1);
best_performances = zeros(3, 1);
best_configs = cell(3, 1);

% Loop sobre todas as combinações de configurações
for i = 1:length(hidden_layers)
    for j = 1:length(neurons)
        for k = 1:length(train_functions)
            for l = 1:length(activation_functions)
                % Cria a rede neural
                net = feedforwardnet(repmat(neurons{j}, 1, hidden_layers{i}));
                net.trainFcn = train_functions{k};
                disp(['Função de Treino: ', train_functions{k}]);
                net.divideFcn = 'dividerand';
                % Define as proporções de divisão
                net.divideParam.trainRatio = train_ratios(k);
                disp(['Train Ratio: ', num2str(train_ratios(k))]);
                net.divideParam.valRatio = val_ratios(k);
                disp(['Val Ratio: ', num2str(val_ratios(k))]);
                net.divideParam.testRatio = test_ratios(k);
                disp(['Test Ratio: ', num2str(test_ratios(k))]);
                for m = 1: hidden_layers{i}
                   % Define função de ativação para cada camada
                   activation_function_index = mod(m-1, length(activation_functions)) + 1;
                   net.layers{m}.transferFcn = activation_functions{activation_function_index};
                   % Exibe a função de ativação sendo utilizada para a camada atual
                   disp(['Camada ' num2str(m) ', Função de Ativação: ' activation_functions{activation_function_index}]);
                end

                % Treina a rede neural
                [net,tr] = train(net, StartInputs, oneHotTargets);
                
                % Avalia o desempenho da rede neural
                out = sim(net, StartInputs);
                accuracy = calculate_accuracy(out, oneHotTargets);
                
                % Verifica se essa rede é uma das três melhores
                [worst_performance, worst_index] = min(best_performances);
                if accuracy > worst_performance
                    % Substitui a pior das três melhores redes
                    best_networks{worst_index} = net;
                    best_performances(worst_index) = accuracy;
                    % Armazena as configurações correspondentes
                    best_configs{worst_index} = struct('HiddenLayers', hidden_layers{i}, ...
                                                        'Neurons', neurons{j}, ...
                                                        'TrainFunction', train_functions{k}, ...
                                                        'ActivationFunction', activation_functions{l}, ...
                                                        'TrainRatio', train_ratios(k), ...
                                                        'ValRatio', val_ratios(k), ...
                                                        'TestRatio', test_ratios(k));
                end
            end
        end
    end
end

% Salva os modelos das três melhores redes
for i = 1:3
    net_to_save = best_networks{i}; % Seleciona a rede atual a ser salva
    save(['best_network_' num2str(i) '.mat'], 'net_to_save');
end

% Função para calcular a precisão
function accuracy = calculate_accuracy(output, targets)
    [~, predicted_classes] = max(output);
    [~, true_classes] = max(targets);
    correct_predictions = sum(predicted_classes == true_classes);
    accuracy = correct_predictions / size(output, 2) * 100;
end

% Exibe as configurações das melhores redes neurais
disp('Melhores configurações das redes neurais:');
for i = 1:3
    disp(['Melhor rede ' num2str(i) ':']);
    disp(best_configs{i});
end

% Exibe as acurácias das melhores redes neurais
disp('Acurácias das melhores redes neurais:');
disp(best_performances);

end
