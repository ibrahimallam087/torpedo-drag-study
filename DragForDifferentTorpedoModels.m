% This script plots the Drag Vs Time for different cases of an underwater
% Torpedo 
%Normal Case : the Torpedo moves in water without activating energy i.e no
%effects of heat on drag is not taking into consideration
%Vapor Case : The heat transfer from torpedo surface to water is included
%Ventilated Cavitation : air comes out of an openniing from the torpedo
%surface to act as vapor and energy is deactivated

% Define the folders
folder_normal = 'Normal case';
folder_ventilated = 'Ventilated cavitation case';
folder_vapor = 'Vapor Case';

% Define the file names to be processed
file_names = {'drag-rfile.out'};

% Plot Drag Value wiht Time step and Flow Time
for i = 1:length(file_names)
    
    % Construct file paths
    file_normal = fullfile(folder_normal, file_names{i});
    file_ventilated = fullfile(folder_ventilated, file_names{i});
    file_vapor = fullfile(folder_vapor,file_names{i});
    
    % Read data for the normal case
    normal_data = read_data(file_normal);
    iteration_normal = normal_data(:, 1); % First column is Iteration
    drag_normal = normal_data(:, 2); % Second column is the drag
    
    % Plot the Normal case data
    figure;
    plot(iteration_normal, drag_normal, 'b-', 'LineWidth', 1.5);
    title(['Normal Case: ', strrep(file_names{i}, '-', ' ')], 'Interpreter', 'latex');
    xlabel('Iteration', 'Interpreter', 'latex');
    ylabel('Drag', 'Interpreter', 'latex');
    grid on;
    set(gca, 'FontName', 'Times New Roman', 'FontSize', 12);
    ylim([-50 250])
    xlim([60 140])
   
    
   
    % Read data for the ventilated cavitation case
    ventilated_data = read_data(file_ventilated);
    timestep_ventilated = ventilated_data(:, 1); % First column is Time Step
    drag_ventilated = ventilated_data(:, 2); % Second column is drag
    flowtime_ventilated = ventilated_data(:,3);
    
    % Plot the Ventilated Cavitation case data
    %Plot time step Vs Drag
    
    figure;
    plot(timestep_ventilated, drag_ventilated, 'r--', 'LineWidth', 1.5);
    title(['Ventilated Cavitation Case: ', strrep(file_names{i}, '-', ' ')], 'Interpreter', 'latex');
    xlabel('Time Step', 'Interpreter', 'latex');
    ylabel('Drag', 'Interpreter', 'latex');
    grid on;
    set(gca, 'FontName', 'Times New Roman', 'FontSize', 12);
    
    %Plot Flow Time Vs Drag
    
    figure;
    plot(flowtime_ventilated, drag_ventilated, 'k--', 'LineWidth', 1.5);
    title(['Ventilated Cavitation Case: ', strrep(file_names{i}, '-', ' ')], 'Interpreter', 'latex');
    xlabel('Flow Time', 'Interpreter', 'latex');
    ylabel('Drag', 'Interpreter', 'latex');
    grid on;
    set(gca, 'FontName', 'Times New Roman', 'FontSize', 12);
    ylim([-50 250])
    
    % Read data for the Vapor Case
    vapor_data = read_data(file_vapor);
    timestep_vapor = vapor_data(:,1);
    drag_vapor = vapor_data(:,2);
    flowtime_vapor = vapor_data(:,3);
    % Plot the Ventilated Cavitation case data
    %Plot Time step Vs Drag
    
    figure;
    plot(timestep_vapor, drag_vapor, 'r--', 'LineWidth', 1.5);
    title(['Vapor Case: ', strrep(file_names{i}, '-', ' ')], 'Interpreter', 'latex');
    xlabel('Time Step', 'Interpreter', 'latex');
    ylabel('Drag', 'Interpreter', 'latex');
    grid on;
    set(gca, 'FontName', 'Times New Roman', 'FontSize', 12);
    %Plot Flow time Vs Drag
    
    figure;
    plot(flowtime_vapor, drag_vapor, 'r--', 'LineWidth', 1.5);
    title(['Vapor Case: ', strrep(file_names{i}, '-', ' ')], 'Interpreter', 'latex');
    xlabel('Flow Time', 'Interpreter', 'latex');
    ylabel('Drag', 'Interpreter', 'latex');
    grid on;
    set(gca, 'FontName', 'Times New Roman', 'FontSize', 12);
    ylim([-50 250])
end

% Helper function to read data from the file
function data = read_data(filename)
    fid = fopen(filename, 'r');
    if fid == -1
        error('Cannot open file: %s', filename);
    end
    
    % Skip the first two header lines
    fgetl(fid); % Skip first header line
    fgetl(fid); % Skip second header line
    
    % Read numerical data
    data = [];
    while ~feof(fid)
        line = fgetl(fid);
        if ischar(line)
            line_data = sscanf(line, '%f');
            data = [data; line_data'];
        end
    end
    
    fclose(fid);
end
