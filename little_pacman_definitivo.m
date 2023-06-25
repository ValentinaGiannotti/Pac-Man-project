%% AREA DEFINIZIONI 
% Definisci la dimensione del labirinto
num_rows = 7;
num_cols = 17;
% matrice game over
matrix_game_over=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 9 9 9 9 0 0 9 9 9 9 0 0 9 0 0 0 9 0 0 9 9 9 9 0 0 0 0 9 9 9 9 0 0 9 0 0 0 9 0 0 9 9 9 9 0 0 9 9 9 9 0 0 0 0;
    0 0 0 0 9 0 0 0 0 0 9 0 0 9 0 0 9 9 0 9 9 0 0 9 0 0 0 0 0 0 0 9 0 0 9 0 0 9 0 0 0 9 0 0 9 0 0 0 0 0 9 0 0 9 0 0 0 0;
    0 0 0 0 9 0 0 0 0 0 9 0 0 9 0 0 9 9 0 9 9 0 0 9 0 0 0 0 0 0 0 9 0 0 9 0 0 9 0 0 0 9 0 0 9 0 0 0 0 0 9 0 0 9 0 0 0 0;
    0 0 0 0 9 0 9 9 0 0 9 9 9 9 0 0 9 0 9 0 9 0 0 9 9 9 9 0 0 0 0 9 0 0 9 0 0 0 9 0 9 0 0 0 9 9 9 9 0 0 9 9 9 9 0 0 0 0;
    0 0 0 0 9 0 0 9 0 0 9 0 0 9 0 0 9 0 0 0 9 0 0 9 0 0 0 0 0 0 0 9 0 0 9 0 0 0 9 0 9 0 0 0 9 0 0 0 0 0 9 0 9 0 0 0 0 0;
    0 0 0 0 9 0 0 9 0 0 9 0 0 9 0 0 9 0 0 0 9 0 0 9 0 0 0 0 0 0 0 9 0 0 9 0 0 0 0 9 0 0 0 0 9 0 0 0 0 0 9 0 0 9 0 0 0 0;
    0 0 0 0 9 9 9 9 0 0 9 0 0 9 0 0 9 0 0 0 9 0 0 9 9 9 9 0 0 0 0 9 9 9 9 0 0 0 0 9 0 0 0 0 9 9 9 9 0 0 9 0 0 9 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;];

matrix_win=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
            0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
            0 0 8 0 0 0 8 0 8 0 0 0 8 0 0 0 8 0 0 0 8 0 0 0 0 8 0 0 0 0 0 8 0 0 0 8 0 0 0 8 0 0;
            0 0 8 0 0 0 8 0 8 0 0 0 8 0 0 0 8 0 0 0 8 8 0 0 0 8 0 0 0 0 0 8 0 0 0 8 0 0 0 8 0 0;
            0 0 0 8 0 0 0 8 0 0 0 8 0 0 0 0 8 0 0 0 8 0 8 0 0 8 0 0 0 0 0 8 0 0 0 8 0 0 0 8 0 0;
            0 0 0 8 0 0 0 8 0 0 0 8 0 0 0 0 8 0 0 0 8 0 0 8 0 8 0 0 0 0 0 8 0 0 0 8 0 0 0 8 0 0;
            0 0 0 0 8 0 8 0 8 0 8 0 0 0 0 0 8 0 0 0 8 0 0 0 8 8 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
            0 0 0 0 0 8 0 0 0 8 0 0 0 0 0 0 8 0 0 0 8 0 0 0 0 8 0 0 0 0 0 8 0 0 0 8 0 0 0 8 0 0;
            0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;];
% Definizione variabili
before_ghost=0;
conteggio=0;
k=1;
scappato=0;
critical_distance=2;

% Inizializza la matrice del labirinto
maze = zeros(num_rows, num_cols);

% Assegna le informazioni delle celle
pacman_effect=2;
square=2;
offset_square_v=3;
offset_square_o=4;
offset_square_o2=12;
offset_square_o3=8;
game_over=0;
win=0;

%% MURA PERIMETRALI VERTICALI
for i=1:num_rows
    maze(i,1)=1;
    maze(i,num_cols)=1;
end
%% MURA PERIMETRALI ORIZZONTALI
for k=1:num_cols
    maze(1,k)=1;
    maze(num_rows,k)=1;
end

%% OSTACOLI
for i=offset_square_v:(offset_square_v+square)
    maze(i,offset_square_o)=1;
    maze(i,offset_square_o+square)=1;
    maze(offset_square_v,offset_square_o+1)=1;
    maze(offset_square_v+square,offset_square_o+1)=1;
end

for i=offset_square_v:(offset_square_v+square)
    maze(i,offset_square_o2)=1;
    maze(i,offset_square_o2+square)=1;
    maze(offset_square_v,offset_square_o2+1)=1;
    maze(offset_square_v+square,offset_square_o2+1)=1;
end
%% CASA FANTASMA
for i=offset_square_v:(offset_square_v+square)
    maze(i,offset_square_o3)=1;
    maze(i,offset_square_o3+square)=1;
    maze(offset_square_v,offset_square_o3+1)=1;
    maze(offset_square_v+square,offset_square_o3+1)=1;
end
maze(3,9)=7;

for i=1:num_rows
    for k=1:num_cols
        if(maze(i,k)==0 )
            maze(i,k)=2;
        end
    end
end
maze(4,2)=3; % posizione pacman
maze(4,5)=0;
maze(4,9)=0;
maze(4,9)=4; % posizione iniziale fantasmino
maze(4,13)=0;

animationFrames = {};
animationFrames{end+1} = maze;
visualizza_labirinto(maze);  

%% PICCIONE VIAGGIATORE INIZIALE 
viaggi=piccione_viaggiatore(maze);

%% PATTERN FANTASMA
orizzontal_base=[0 0];
vertical_base=[-1 -1];
orizzontal_patterns=cell(4,1);
vertical_patterns=cell(4,1);
orizzontal_patterns{1}=[-1 -1 0 0 0 0];
vertical_patterns{1}=[0 0 1 1 1 1];
orizzontal_patterns{2}=[-1 -1 -1 -1 -1 -1 0 -1 0 0 0 1 1 1 1 1];
vertical_patterns{2}=[0 0 0 0 0 0 1 0 1 1 1 0 0 0 0 0];
orizzontal_patterns{3}=[1 1 0 0 0 0 -1 -1 -1 -1];
vertical_patterns{3}=[0 0 1 1 1 1 0 0 0 0];
orizzontal_patterns{4}=[1 1 1 1 1 1 0 0 0 0 -1 -1 -1 -1 -1 -1 -1 -1];
vertical_patterns{4}=[0 0 0 0 0 0 1 1 1 1 0 0 0 0 0 0 0 0];
orizzontal_patternsB=cell(4,1);
vertical_patternsB=cell(4,1);
orizzontal_patternsB{1}=[1 1 1 1 1 1 1 1 1 0 -1 0 0 1 0 -1 -1 -1 -1 -1 -1 -1 ];
vertical_patternsB{1}=[0 0 0 0 0 0 0 0 0 -1 0 -1 -1 0 -1 0 0 0 0 0 0 0];
orizzontal_patternsB{2}=[1 1 1 1 0 0 0 0 -1 -1];
vertical_patternsB{2}=[0 0 0 0 -1 -1 -1 -1 0 0];
orizzontal_patternsB{3}=[-1 -1 -1 -1 0 0 0 0 1 1 1 1 1 1];
vertical_patternsB{3}=[0 0 0 0 -1 -1 -1 -1 0 0 0 0 0 0 ];
orizzontal_patternsB{4}=[0 0 0 0 1 1];
vertical_patternsB{4}=[-1 -1 -1 -1 0 0];

u1_ghost = orizzontal_base;
u2_ghost = vertical_base;

num_passi = 6;
for passo = 1:num_passi
    i = randi(4);  % Genera un numero casuale tra 1 e 4  
    u1_ghost = [u1_ghost, orizzontal_patterns{i}, orizzontal_patternsB{i}];
    u2_ghost = [u2_ghost, vertical_patterns{i}, vertical_patternsB{i}];
end

%% GIOCO
for i=1:1000

    % MOVIMENTO FANTASMA
    [G_row,G_col]=find(maze==4);
    if u1_ghost(i)==0 %se il movimento è verticale
        maze(G_row,G_col)=before_ghost;
        before_ghost=maze(G_row+u2_ghost(i),G_col); %salviamo il contenuto della casella prima che ci vada il fantasma
        maze(G_row+u2_ghost(i),G_col)=4; %y(i+1)=y(i)+u_2(i)
    else %se il movimento è orizzontale
        maze(G_row,G_col)=before_ghost;
        before_ghost=maze(G_row,G_col+u1_ghost(i)); %salviamo il contenuto della casella prima che ci vada il fantasma
        maze(G_row,G_col+u1_ghost(i))=4;%x(i+1)=x(i)+u_1(i)
    end

    if before_ghost == 3
        before_ghost = 0;
        game_over=1;
        break; % Termina il ciclo for
    end
    
   % MOVIMENTO PACMAN
    [startRowP,startColP]=find(maze==3);
    [startRowG,startColG]=find(maze==4);
    if(norm([startRowP,startColP]-[startRowG,startColG],2)<=critical_distance)
        direz=scappare(maze);
        scappato=1;
    else
        if(scappato==1)
            viaggi=piccione_viaggiatore(maze);
            k=1;
            scappato=0;
        end    
        if(startColP==viaggi(k,3) && startRowP==viaggi(k,4))
            k=k+1;
        end
        if(k>=48)
           direz=scappare(maze);
        scappato=1; 
        end
        
        if(viaggi(k,4)<startRowP && maze(startRowP-1,startColP)~=1)
            direz="N";
        end
        if(viaggi(k,4)>startRowP && maze(startRowP+1,startColP)~=1)
            direz="S";
        end
        if(viaggi(k,3)>startColP && maze(startRowP,startColP+1)~=1)
            direz="E";
        end
        if(viaggi(k,3)<startColP && maze(startRowP,startColP-1)~=1)
            direz="W";
        end
    end 

    % Esegui l'azione corrispondente alla direzione selezionata
    switch direz
        case "N"
            maze(startRowP,startColP)=0;
            before_pac=maze(startRowP-1,startColP); %salviamo il contenuto della casella prima che ci vada il fantasma
            maze(startRowP-1,startColP)=3;
        case "S"
            maze(startRowP,startColP)=0;
            before_pac=maze(startRowP+1,startColP); %salviamo il contenuto della casella prima che ci vada il fantasma
            maze(startRowP+1,startColP)=3;
        case "W"
            maze(startRowP,startColP)=0;
            before_pac=maze(startRowP,startColP-1); %salviamo il contenuto della casella prima che ci vada il fantasma
            maze(startRowP,startColP-1)=3;
        case "E"
            maze(startRowP,startColP)=0;
            before_pac=maze(startRowP,startColP+1); %salviamo il contenuto della casella prima che ci vada il fantasma
            maze(startRowP,startColP+1)=3;
    end
    if(before_pac==2)
        conteggio=conteggio+20;
        before_pac=0;
    end



    animationFrames{end+1} = maze;
    visualizza_labirinto(maze);
    pause(0.1);
  
    if conteggio == 940
        win=1;
        break; % Termina il ciclo for
    end
end
implay(animationFrames);
if game_over==1
    figure
    visualizza_labirinto(matrix_game_over);
end
if win==1
    figure
    visualizza_labirinto(matrix_win);
end


