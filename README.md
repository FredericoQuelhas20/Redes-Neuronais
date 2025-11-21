# Redes Neuronais

## Descrição do Projeto
Este projeto tem como objetivo desenvolver e implementar redes neuronais artificiais utilizando MATLAB, realizado no âmbito da unidade curricular de Conhecimento e Raciocínio. O sistema foca-se na aplicação de técnicas de aprendizagem automática para análise e classificação de dados médicos, especificamente relacionados com o diagnóstico de cirrose hepática.

## Equipa de Desenvolvimento
- **Frederico Quelhas** - [@FredericoQuelhas20](https://github.com/FredericoQuelhas20)
- **Afonso Silva** - [@Afonsod706](https://github.com/Afonsod706)

## Tecnologias Utilizadas
- **MATLAB** (R2020a ou superior)
- **Neural Network Toolbox** do MATLAB
- **Statistics and Machine Learning Toolbox**
- **MATLAB Deep Learning Toolbox** (opcional)

## Funcionalidades
- Implementação de redes neuronais artificiais (Artificial Neural Networks - ANN)
- Pré-processamento e normalização de datasets médicos
- Treino e validação de modelos de classificação
- Avaliação de desempenho com métricas (accuracy, precision, recall, F1-score)
- Análise de dados de cirrose hepática (Dataset3)
- Visualização de resultados e curvas de aprendizagem
- Otimização de hiperparâmetros da rede neural
- Validação cruzada (cross-validation)
- Análise de importância de features

## Instalação

### Requisitos
- MATLAB R2020a ou versão superior
- Neural Network Toolbox instalado
- Statistics and Machine Learning Toolbox
- Mínimo 4GB RAM (8GB recomendado)

### Passos de Instalação

1. Clone o repositório do GitHub:
```bash
git clone https://github.com/FredericoQuelhas20/Redes-Neuronais.git
cd Redes-Neuronais
```

2. Certifique-se de que o MATLAB está instalado:
```bash
matlab -version
```

3. Abra o MATLAB e navegue até a pasta do projeto

4. Verifique se as toolboxes necessárias estão instaladas:
```matlab
ver
```

## Estrutura do Projeto
```
/Dataset3- Cirrose/        - Dados de cirrose hepática
  ├── Dataset3 - Cirrose/  - Ficheiros de dados (.csv, .mat)
  └── __MACOSX/            - Metadados do sistema
/RelatorioTrabalhoPratico.pdf - Relatório completo do trabalho
README.md                  - Documentação do projeto
```

## Como Utilizar

### Carregar o Dataset
```matlab
% Abrir MATLAB e navegar até a pasta do projeto
cd('Dataset3- Cirrose/Dataset3 - Cirrose')

% Carregar os dados (ajustar o nome do ficheiro conforme necessário)
data = readtable('cirrose_data.csv');

% Visualizar primeiras linhas
head(data)
```

### Pré-processamento dos Dados
```matlab
% Separar features (X) e labels (y)
X = data(:, 1:end-1);  % Features
y = data(:, end);       % Target (diagnóstico)

% Normalizar dados
X_normalized = normalize(X);

% Dividir em treino e teste (70/30)
cv = cvpartition(size(X, 1), 'HoldOut', 0.3);
idx = cv.test;

X_train = X_normalized(~idx, :);
y_train = y(~idx, :);
X_test = X_normalized(idx, :);
y_test = y(idx, :);
```

### Criar e Treinar a Rede Neural
```matlab
% Configurar a rede neural
hiddenLayerSize = [10, 5];  % Duas camadas ocultas
net = patternnet(hiddenLayerSize);

% Configurar parâmetros de treino
net.trainParam.epochs = 1000;
net.trainParam.goal = 1e-5;
net.divideParam.trainRatio = 0.7;
net.divideParam.valRatio = 0.15;
net.divideParam.testRatio = 0.15;

% Treinar a rede
[net, tr] = train(net, X_train', y_train');

% Fazer previsões
y_pred = net(X_test');

% Avaliar desempenho
performance = perform(net, y_test', y_pred);
```

### Visualizar Resultados
```matlab
% Plotar curva de performance
plotperform(tr)

% Matriz de confusão
plotconfusion(y_test', y_pred)

% Curva ROC
plotroc(y_test', y_pred)
```

## Metodologia

### Arquitetura da Rede Neural
- **Camada de Entrada**: Variável (depende das features do dataset)
- **Camadas Ocultas**: Configuráveis (default: 2 camadas com 10 e 5 neurónios)
- **Camada de Saída**: Classificação binária ou multi-classe
- **Função de Ativação**: Sigmoid/ReLU/Tanh
- **Algoritmo de Treino**: Levenberg-Marquardt ou Scaled Conjugate Gradient

### Dataset - Cirrose Hepática
O dataset contém informações médicas de pacientes com possível diagnóstico de cirrose, incluindo:
- Parâmetros laboratoriais
- Dados demográficos
- Histórico clínico
- Variável target: presença/ausência de cirrose

## Métricas de Avaliação

O projeto avalia o desempenho utilizando:
- **Accuracy**: Precisão geral do modelo
- **Precision**: Precisão das previsões positivas
- **Recall (Sensitivity)**: Taxa de verdadeiros positivos
- **F1-Score**: Média harmónica entre precision e recall
- **Confusion Matrix**: Matriz de confusão
- **ROC Curve**: Curva ROC e área sob a curva (AUC)

## Resultados

Consulte o relatório `RelatorioTrabalhoPratico.pdf` para:
- Análise detalhada dos resultados
- Comparação de diferentes arquiteturas
- Discussão sobre overfitting/underfitting
- Conclusões e trabalho futuro

## Otimização de Hiperparâmetros

```matlab
% Exemplo de grid search para otimização
hiddenSizes = {[5], [10], [10, 5], [15, 10], [20, 10, 5]};
results = zeros(length(hiddenSizes), 1);

for i = 1:length(hiddenSizes)
    net = patternnet(hiddenSizes{i});
    [net, tr] = train(net, X_train', y_train');
    y_pred = net(X_test');
    results(i) = perform(net, y_test', y_pred);
end

% Selecionar melhor configuração
[~, bestIdx] = min(results);
bestConfig = hiddenSizes{bestIdx};
```

## Troubleshooting

**Problema: Overfitting**
- Reduzir número de neurónios nas camadas ocultas
- Adicionar regularização
- Aumentar dados de treino

**Problema: Underfitting**
- Aumentar número de neurónios
- Adicionar mais camadas ocultas
- Treinar por mais épocas

**Problema: Convergência lenta**
- Ajustar learning rate
- Experimentar diferentes algoritmos de treino
- Normalizar melhor os dados

## Documentação Adicional

- **Relatório Completo**: `RelatorioTrabalhoPratico.pdf`
- **MATLAB Neural Network Toolbox**: [Documentação Oficial](https://www.mathworks.com/help/deeplearning/)

## Licença
Este projeto está licenciado sob a Licença MIT - veja o ficheiro LICENSE para mais detalhes.

## Contacto
Para questões:
- **Frederico Quelhas** - [@FredericoQuelhas20](https://github.com/FredericoQuelhas20)


---

**Nota:** Projeto académico desenvolvido para a unidade curricular de Conhecimento e Raciocínio.
