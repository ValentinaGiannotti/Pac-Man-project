
function movimento=scappare(maze)
yalmip('clear')

% MODELLO PACMAN
 A=[1,0;0,1];
 B=[1,-1,0,0;0,0,1,-1];
 nx = 2; % Number of states
 nu = 4; % Number of inputs
 N = 3;
% % Initial state
 [startRowP,startColP]=(find(maze==3));
 [startRowG,startColG]=(find(maze==4));
 x0 = [startRowP;startColP];
xf(1,:)= [startRowG,startColG];
for i = 1:3
possibleDirectionsG = [];
 if maze(xf(i,1)-1, xf(i,2)) ~= 1 % Nord
        possibleDirectionsG = [possibleDirectionsG, "N"];
    end
    if maze(xf(i,1)+1, xf(i,2)) ~= 1 && maze(xf(i,1)+1, xf(i,2)) ~= 7 % Sud
        possibleDirectionsG = [possibleDirectionsG, "S"];
    end
    if maze(xf(i,1), xf(i,2)-1) ~= 1 % Ovest
        possibleDirectionsG = [possibleDirectionsG, "W"];
    end
    if maze(xf(i,1), xf(i,2)+1) ~= 1 % Est
        possibleDirectionsG = [possibleDirectionsG, "E"];
    end
    numPossibleDirectionsG = numel(possibleDirectionsG);
    
    if numPossibleDirectionsG > 0
        selectedDirectionGIndex = randi([1, numPossibleDirectionsG]);
        selectedDirectionG = possibleDirectionsG(selectedDirectionGIndex);
  
        switch selectedDirectionG
            case "N"
                xf(i+1,:)=[xf(i,1)-1,xf(i,2)];
            case "S"
                xf(i+1,:)=[xf(i,1)+1,xf(i,2)];
            case "W"
                xf(i+1,:)=[xf(i,1),xf(i,2)-1];
            case "E"
                xf(i+1,:)=[xf(i,1),xf(i,2)+1];
        end

    end

[rowR,colR]=find(maze==2); %Calcolo la posizione dei rewards %Calcolo la posizione dei rewards
%ricaviamo il reward a minor distanza da [StartRowP,startColP] per poi minimizzarla
min_dist=45;
for k=1:numel(rowR)
    partial_dist=norm(([startRowP,startColP]-[rowR(k),colR(k)]),1);
    if partial_dist<min_dist
        min_dist=partial_dist;
        nearR=rowR(k);
        nearC=colR(k);
    end
end
u = binvar(repmat(nu,1,N),repmat(1,1,N));
x = intvar(repmat(nx,1,N+1),repmat(1,1,N+1));
constraints=[];
objective = 0;
    if maze(startRowP-1, startColP) == 1 % non può andare a Nord
       constraints=[constraints, x{2}(1)>=startRowP ];
    end
    if maze(startRowP+1, startColP) == 1 || maze(startRowP+1,startColP) == 7 % non può andare a Sud
         constraints=[constraints, x{2}(1)<=startRowP ];
    end
    if maze(startRowP, startColP-1) == 1 % non può andare a ovest 
         constraints=[constraints, x{2}(2)>=startColP];
    end
    if maze(startRowP, startColP+1) == 1 % non può andare a Est
        constraints=[constraints, x{2}(2)<=startColP];
    end

for k = 1:N
 objective = objective+10*norm((x{k}-[startRowG;startColG]),1)-5*norm((x{k}-[nearR;nearC]),1);
 constraints = [constraints, x{k+1} == A*x{k} + B*u{k}];
 constraints = [constraints, u{k}(1)+u{k}(2)+u{k}(3)+u{k}(4)==1, 2<=x{k+1}(1), x{k+1}(1)<=6,2<=x{k+1}(2), x{k+1}(2)<=16 ];
end

controller = optimizer(constraints, -objective,[],x{1},[u{:}]);
x = x0;
implementedU = [];
for i = 1:N
  U = controller{x};
  x = A*x + B*U(:,1);
implementedU = [implementedU,U(:,1)];
end


implementedU
uottimo=round(implementedU(:,1))
if(uottimo(1)==1)
    movimento="S";
end
if(uottimo(2)==1)
    movimento="N";
end
if(uottimo(3)==1)
    movimento="E";
end
if(uottimo(4)==1)
    movimento="W";
end

end