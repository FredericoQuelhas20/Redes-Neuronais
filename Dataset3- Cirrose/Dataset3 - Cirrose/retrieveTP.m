function modified_case_library = retrieveTP(case_library)
    % Substituir NA pela média dos valores até o momento que foi encontrado
    for col = 1:size(case_library, 2) % Loop pelas colunas
        col_data = case_library{:, col}; % Dados da coluna atual
        for i = 1:numel(col_data) % Loop pelos elementos da coluna
            if ismissing(col_data(i)) % Se o valor é NA
                % Calcular a média dos valores até o momento
                avg_so_far = mean(col_data(1:i-1), 'omitnan');
                % Substituir NA pela média
                case_library{i, col} = avg_so_far;
            end
        end
    end
    
    % Substituir 'D' por 2, 'CL' por 1 e 'C' por 0 apenas na coluna 3
    col_data = case_library{:, 3}; % Dados da coluna 3
    for i = 1:numel(col_data) % Loop pelos elementos da coluna 3
        if ischar(col_data{i}) % Se o valor é uma string
            if strcmp(col_data{i}, 'D')
                % Substituir 'D' por 2
                case_library{i, 3} = 2;
            elseif strcmp(col_data{i}, 'CL')
                % Substituir 'CL' por 1
                case_library{i, 3} = 1;
            elseif strcmp(col_data{i}, 'C')
                % Substituir 'C' por 0
                case_library{i, 3} = 0;
            end
        end
    end

    % Substituir 'D-penicillamine' por 1 e 'Placebo' por 0
    col_data = case_library{:, 4}; % Dados da coluna 4
    for i = 1:numel(col_data) % Loop pelos elementos da coluna 4
        if ischar(col_data{i}) % Se o valor é uma string
            if strcmp(col_data{i}, 'D-penicillamine')
                % Substituir 'D-penicillamine' por 1
                case_library{i, 4} = 1;
            elseif strcmp(col_data{i}, 'Placebo')
                % Substituir 'Placebo' por 0
                case_library{i, 4} = 0;
            end
        end
    end
    
    % Substituir 'F' por 1 e 'M' por 0
    col_data = case_library{:, 6}; % Dados da coluna 6
    for i = 1:numel(col_data) % Loop pelos elementos da coluna 6
        if ischar(col_data{i}) % Se o valor é uma string
            if strcmp(col_data{i}, 'F')
                % Substituir 'F' por 1
                case_library{i, 6} = 1;
            elseif strcmp(col_data{i}, 'M')
                % Substituir 'M' por 0
                case_library{i, 6} = 0;
            end
        end
    end

    % Substituir 'Y' por 1 e 'N' por 0
    col_data = case_library{:, 7}; % Dados da coluna 7
    for i = 1:numel(col_data) % Loop pelos elementos da coluna 7
        if ischar(col_data{i}) % Se o valor é uma string
            if strcmp(col_data{i}, 'Y')
                % Substituir 'Y' por 1
                case_library{i, 7} = 1;
            elseif strcmp(col_data{i}, 'N')
                % Substituir 'N' por 0
                case_library{i, 7} = 0;
            end
        end
    end
    
    % Substituir 'Y' por 1 e 'N' por 0 e 'S' por 2
    col_data = case_library{:, 8}; % Dados da coluna 8
    for i = 1:numel(col_data) % Loop pelos elementos da coluna 8
        if ischar(col_data{i}) % Se o valor é uma string
            if strcmp(col_data{i}, 'Y')
                % Substituir 'Y' por 1
                case_library{i, 8} = 1;
            elseif strcmp(col_data{i}, 'N')
                % Substituir 'N' por 0
                case_library{i, 8} = 0;
            elseif strcmp(col_data{i}, 'S')
                % Substituir 'S' por 2 
                case_library{i, 8} = 2;
            end
        end
    end

    % Retorna a tabela modificada
    modified_case_library = case_library;
end