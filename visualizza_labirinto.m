function visualizza_labirinto(maze)

imshow(maze, 'InitialMagnification', 'fit');  % Mostra la matrice maze senza colormap

%% MURA
% Imposta il colore delle celle con valore 1 (blu)
blue_color = [0 0 0.8];
hold on
[row, col] = find(maze == 1);
for i = 1:numel(row)
    rectangle('Position', [col(i)-0.5, row(i)-0.5, 1, 1], 'FaceColor', blue_color, 'EdgeColor', blue_color);
end
%% GHOST'S HOUSE
% Imposta il colore delle celle con valore 1 (cancello casa fantasma)
light_brown=[128, 64, 0]/255;
hold on
[row, col] = find(maze == 7);
for i = 1:numel(row)
    rectangle('Position', [col(i)-0.5, row(i)-0.5, 1, 1], 'FaceColor', 'k', 'EdgeColor', 'k');
    rectangle('Position', [col(i)-0.5, row(i)-0.25, 1, 0.25], 'FaceColor', light_brown, 'EdgeColor', light_brown);
end

%% REWARDS
% Imposta il colore delle celle con valore 2 (sfondo nero e puntino giallo)
yellow_color = [1 1 0];
[row, col] = find(maze == 2);
for i = 1:numel(row)
    rectangle('Position', [col(i)-0.5, row(i)-0.5, 1, 1], 'FaceColor', 'k', 'EdgeColor', 'k');
    rectangle('Position', [col(i)-0.1, row(i)-0.1, 0.20, 0.20], 'FaceColor', yellow_color, 'EdgeColor', yellow_color);
end

%% PACMAN
% Trova la posizione di Pacman (valore 3 nella matrice maze)
[row, col] = find(maze == 3);

pacman_radius = 0.4; % Raggio di Pacman
pacman_eye_radius = 0.13; % Raggio degli occhi
pacman_eye_offset = 0.13; % Offset degli occhi rispetto al centro
vertical_eye_offset = -0.2; % Offset verticale degli occhi

for i = 1:numel(row)
    rectangle('Position', [col(i)-0.5, row(i)-0.5, 1, 1], 'FaceColor', 'k', 'EdgeColor', 'k');

    % Disegna il corpo di Pacman come un cerchio
    rectangle('Position', [col(i)-pacman_radius, row(i)-pacman_radius, pacman_radius*2, pacman_radius*2], 'Curvature', [1 1], 'FaceColor', yellow_color, 'EdgeColor', 'none');

    % Calcola gli angoli per il disegno della bocca di Pacman
    start_angle = -pi/9;
    end_angle = pi/7;
    theta = linspace(start_angle, end_angle, 100);

    % Calcola le coordinate per disegnare la bocca di Pacman
    mouth_x = [col(i), col(i) + pacman_radius * cos(theta), col(i)];
    mouth_y = [row(i), row(i) + pacman_radius * sin(theta), row(i)];

    % Disegna la bocca di Pacman
    patch(mouth_x, mouth_y, 'k', 'EdgeColor', 'none');

    % Disegna gli occhi come due cerchi bianchi con pupille nere
    pacman_right_eye_pos = [col(i)+pacman_eye_offset, row(i)+vertical_eye_offset];
    patch(pacman_right_eye_pos(1) + pacman_eye_radius * cos(0:pi/20:2*pi), pacman_right_eye_pos(2) + pacman_eye_radius * sin(0:pi/20:2*pi), 'w', 'EdgeColor', 'none');
    patch(pacman_right_eye_pos(1) + (pacman_eye_radius/2) * cos(0:pi/20:2*pi), pacman_right_eye_pos(2) + (pacman_eye_radius/2) * sin(0:pi/20:2*pi), 'k', 'EdgeColor', 'none');
end

%% GHOST
% Imposta il colore e il simbolo per la posizione di fantasmi
ghost_symbol = 'o';
ghost_color = [0.7 0 0.5]; % Colore rosso per il fantasma

% Trova la posizione del fantasma (valore 4 nella matrice maze)
[row, col] = find(maze == 4);

% Imposta i dettagli per il disegno del fantasma
ghost_radius = 0.4; % Raggio del fantasma
eye_radius = 0.1; % Raggio degli occhi
eye_offset = 0.15; % Offset degli occhi rispetto al centro
vertical_eye_offset=-0.15; % Offset verticale degli occhi
tun_offset=0.25;
tun_radius=0.12;
for i = 1:numel(row)
    rectangle('Position', [col(i)-0.5, row(i)-0.5, 1, 1], 'FaceColor', 'k', 'EdgeColor', 'k');

    % Disegna il corpo del fantasma come un cerchio
    rectangle('Position', [col(i)-ghost_radius, row(i)-ghost_radius, ghost_radius*2, ghost_radius*2], 'Curvature', [1 1], 'FaceColor', ghost_color, 'EdgeColor', 'none');
    % Calcola le dimensioni del rettangolo per la tunica del fantasma
    tunic_width = 1; % Larghezza della tunica (100% rispetto alla casella)
    tunic_height = 0.4; % Altezza della tunica (20% rispetto alla casella)
    tunic_x = [col(i)-0.5, col(i)-0.5, col(i)+0.5, col(i)+0.5];
    tunic_y = [row(i)-0.2+(tunic_height), row(i)+0.5, row(i)+0.5, row(i)-0.2+(tunic_height)];

    % Disegna il rettangolo nero per la tunica del fantasma
    patch(tunic_x, tunic_y, 'k', 'EdgeColor', 'none');
    tun1 = [col(i)-eye_offset*1.5, row(i)+tun_offset];
    tun2 = [col(i), row(i)+tun_offset];
    tun3 = [col(i)+eye_offset*1.5, row(i)+tun_offset];
    patch(tun1(1) + tun_radius * cos(0:pi/20:2*pi), tun1(2) + tun_radius * sin(0:pi/20:2*pi), 'k', 'EdgeColor', 'none');
    patch(tun2(1) + tun_radius * cos(0:pi/20:2*pi), tun3(2) + tun_radius * sin(0:pi/20:2*pi), 'k', 'EdgeColor', 'none');
    patch(tun3(1) + tun_radius * cos(0:pi/20:2*pi), tun3(2) + tun_radius * sin(0:pi/20:2*pi), 'k', 'EdgeColor', 'none');

    % Disegna gli occhi come due cerchi bianchi con pupille nere
    left_eye_pos = [col(i)-eye_offset, row(i)+vertical_eye_offset];
    right_eye_pos = [col(i)+eye_offset, row(i)+vertical_eye_offset];
    patch(left_eye_pos(1) + eye_radius * cos(0:pi/20:2*pi), left_eye_pos(2) + eye_radius * sin(0:pi/20:2*pi), 'w', 'EdgeColor', 'none');
    patch(right_eye_pos(1) + eye_radius * cos(0:pi/20:2*pi), right_eye_pos(2) + eye_radius * sin(0:pi/20:2*pi), 'w', 'EdgeColor', 'none');
    patch(left_eye_pos(1) + (eye_radius/2) * cos(0:pi/20:2*pi), left_eye_pos(2) + (eye_radius/2) * sin(0:pi/20:2*pi), 'k', 'EdgeColor', 'none');
    patch(right_eye_pos(1) + (eye_radius/2) * cos(0:pi/20:2*pi), right_eye_pos(2) + (eye_radius/2) * sin(0:pi/20:2*pi), 'k', 'EdgeColor', 'none');

end



%% PACMAN POWER
% Trova la posizione del pacman power
[row, col] = find(maze == 5);
for i = 1:numel(row)
    rectangle('Position', [col(i)-0.5, row(i)-0.5, 1, 1], 'FaceColor', 'k', 'EdgeColor', 'k');
    rectangle('Position', [col(i)-0.25, row(i)-0.25, 0.5, 0.5], 'FaceColor', yellow_color, 'EdgeColor', yellow_color);
end
%% GAME OVER
[row, col] = find(maze == 9);
red_color=[1 0 0];
for i = 1:numel(row)
    rectangle('Position', [col(i)-0.5, row(i)-0.5, 1, 1], 'FaceColor', 'k', 'EdgeColor', 'k');
    rectangle('Position', [col(i)-0.5, row(i)-0.5, 1, 1], 'FaceColor', red_color, 'EdgeColor', red_color);
end

%% WIN
[row, col] = find(maze == 8);

for i = 1:numel(row)

    rectangle('Position', [col(i)-0.5, row(i)-0.5, 1, 1], 'FaceColor', 'k', 'EdgeColor', 'k');

    rectangle('Position', [col(i)-0.5, row(i)-0.5, 1, 1], 'FaceColor', [1 1 0], 'EdgeColor', [1 1 0]);

end
end
