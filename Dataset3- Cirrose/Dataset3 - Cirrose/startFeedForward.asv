function startFeedForward()

clear all;
close all;

% Carrega o dataset
data = readtable('Start.csv');
StartInputs = table2array(data(:, 1:end-1))'; % Entradas
StartTargets = table2array(data(:, end))'; % Saídas

oneHotTargets = onehotencode(StartTargets,1,'ClassNames',1:4);

net = feedforwardnet([1, 10]);

net.trainFcn = 'trainlm';
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'purelin';
net.divideFcn = 'dividerand';
net.divideParam.trainRatio = 0.70;
net.divideParam.valRatio = 0.15;
net.divideParam.testRatio = 0.15;

% TREINAR
[net,tr] = train(net, StartInputs, oneHotTargets);
%view(net);
%disp(tr);
% SIMULAR
out = sim(net, StartInputs);

%VISUALIZAR DESEMPENHO

plotconfusion(oneHotTargets, out) % Matriz de confusao

plotperf(tr)         % Grafico com o desempenho da rede nos 3 conjuntos           

erro = perform(net, out,oneHotTargets);
fprintf('Erro na classificação dos 10 exemplos %f\n', erro)
%Calcula e mostra a percentagem de classificacoes corretas no total dos exemplos
r=0;
for i=1:size(out,2)               % Para cada classificacao  
  [a, b] = max(out(:,i));          %b guarda a linha onde encontrou valor mais alto da saida obtida
  [c, d] = max(oneHotTargets(:,i));  %d guarda a linha onde encontrou valor mais alto da saida desejada
  if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
      r = r+1;
  end
end

accuracy = r/size(out,2)*100;
fprintf('Precisao total %f\n', accuracy)


% SIMULAR A REDE APENAS NO CONJUNTO DE TESTE
TInput = StartInputs(:, tr.testInd);
TTargets = oneHotTargets(:, tr.testInd);

out = sim(net, TInput);

erro = perform(net, out,TTargets);
fprintf('Erro na classificação do conjunto de teste %f\n', erro)

%Calcula e mostra a percentagem de classificacoes corretas no conjunto de teste
r=0;
for i=1:size(tr.testInd,2)               % Para cada classificacao  
  [a, b] = max(out(:,i));          %b guarda a linha onde encontrou valor mais alto da saida obtida
  [c, d] = max(TTargets(:,i));  %d guarda a linha onde encontrou valor mais alto da saida desejada
  if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
      r = r+1;
  end
end
accuracy = r/size(tr.testInd,2)*100;
fprintf('Precisao teste %f\n', accuracy)


end

