function testFeedForward()

% Carrega o dataset de teste
data = readtable('Test.csv');
TestInputs = table2array(data(:, 1:end-1))'; % Entradas
TestTargets = table2array(data(:, end))'; % Saídas desejadas
oneHotTargets = onehotencode(TestTargets,1,'ClassNames',1:4);

% Carrega as redes treinadas
load('best_network_1.mat', 'net_to_save'); % Carrega a primeira melhor rede
net1 = net_to_save;
%whos
load('best_network_2.mat', 'net_to_save'); % Carrega a segunda melhor rede
net2 = net_to_save;
%whos
load('best_network_3.mat', 'net_to_save'); % Carrega a terceira melhor rede
net3 = net_to_save;
%whos

% Simula as redes nos dados de teste
out1 = sim(net1, TestInputs);
out2 = sim(net2, TestInputs);
out3 = sim(net3, TestInputs);

% Calcula as métricas de acerto para cada rede
accuracy1 = calculateAccuracy(out1, oneHotTargets);
accuracy2 = calculateAccuracy(out2, oneHotTargets);
accuracy3 = calculateAccuracy(out3, oneHotTargets);

% Mostra os resultados
fprintf('Precisão da rede 1 no conjunto de teste: %f\n', accuracy1);
fprintf('Precisão da rede 2 no conjunto de teste: %f\n', accuracy2);
fprintf('Precisão da rede 3 no conjunto de teste: %f\n', accuracy3);
 
end

function accuracy = calculateAccuracy(outputs, targets)
% Calcula a precisão da rede
r = 0;
for i = 1:size(outputs, 2)               % Para cada classificação  
  [a, b] = max(outputs(:, i));          % b guarda a linha onde encontrou valor mais alto da saída obtida
  [c, d] = max(targets(:, i));  % d guarda a linha onde encontrou valor mais alto da saída desejada
  if b == d                       % se estão na mesma linha, a classificação foi correta (incrementa 1)
      r = r + 1;
  end
end
accuracy = r / size(outputs, 2) * 100;
end
