function movimento=scappare(maze)
yalmip('clear')

% MODELLO PACMAN
 A=[1,0;0,1];
 B=[1,-1,0,0;0,0,1,-1];
 nx = 2; % Number of states
 nu = 4; % Number of inputs
 N = 4;
% % Initial state
 [startRowP,startColP]=(find(maze==3));
 [startRowG,startColG]=(find(maze==4));
 x0 = [startRowP;startColP];

 
% u = binvar(repmat(nu,1,N),repmat(1,1,N));
% 
% %u=binvar(nu,N);
% objective = 0;
%  x = x0;
% constraints = [];
% for k = 1:N
%    x = A*x + B*u{k};
%    objective = objective+norm((x-[startRowG;startColG]),1) +norm((x-[4;5]),1) +norm((x-[4;9]),1) +norm((x-[4;13]),1) ;
%    constraints = [constraints, 2<=x(1), x(1)<=6,2<=x(2), x(2)<=16, u{k}(1)+u{k}(2)+u{k}(3)+u{k}(4)==1];
% end
% x = A*x + B*u;
% constraints = [2<=x(1)<=6,2<=x(2)<=16,sum(u)==1];
% objective = objective+10*norm((x-[startRowG;startColG]),1) +norm((x-[4;5]),1) +norm((x-[4;9]),1) +norm((x-[4;13]),1) ;


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

constraints = [];
objective = 0;
for k = 1:N
 objective = objective+2*norm((x{k}-[startRowG;startColG]),1);
 constraints = [constraints, x{k+1} == A*x{k} + B*u{k}];
 constraints = [constraints, u{k}(1)+u{k}(2)+u{k}(3)+u{k}(4)==1,2<=x{k+1}(1), x{k+1}(1)<=6,2<=x{k+1}(2), x{k+1}(2)<=16];
constraints = [constraints, (~x{k+1}(1)==3 & ~x{k+1}(2)==4)];
constraints = [constraints, (~x{k+1}(1)==3 & ~x{k+1}(2)==5)];
constraints = [constraints, (~x{k+1}(1)==3 & ~x{k+1}(2)==6)];
constraints = [constraints, (~x{k+1}(1)==3 & ~x{k+1}(2)==8)];
constraints = [constraints, (~x{k+1}(1)==3 & ~x{k+1}(2)==9)];
constraints = [constraints, (~x{k+1}(1)==3 & ~x{k+1}(2)==10)];
constraints = [constraints, (~x{k+1}(1)==3 & ~x{k+1}(2)==12)];
constraints = [constraints, (~x{k+1}(1)==3 & ~x{k+1}(2)==13)];
constraints = [constraints, (~x{k+1}(1)==3 & ~x{k+1}(2)==14)];
constraints = [constraints, (~x{k+1}(1)==5 & ~x{k+1}(2)==4)];
constraints = [constraints, (~x{k+1}(1)==5 & ~x{k+1}(2)==5)];
constraints = [constraints, (~x{k+1}(1)==5 & ~x{k+1}(2)==6)];
constraints = [constraints, (~x{k+1}(1)==5 & ~x{k+1}(2)==8)];
constraints = [constraints, (~x{k+1}(1)==5 & ~x{k+1}(2)==9)];
constraints = [constraints, (~x{k+1}(1)==5 & ~x{k+1}(2)==10)];
constraints = [constraints, (~x{k+1}(1)==5 & ~x{k+1}(2)==12)];
constraints = [constraints, (~x{k+1}(1)==5 & ~x{k+1}(2)==13)];
constraints = [constraints, (~x{k+1}(1)==5 & ~x{k+1}(2)==14)];

end

controller = optimizer(constraints, -objective,[],x{1},[u{:}]);
x = x0;
implementedU = [];
for i = 1:N
  U = controller{x};
  x = A*x + B*U(:,1);
implementedU = [implementedU,U(:,1)];
end


%optimize(constraints,-objective);
% value(u{1})
% value(u{2})
% value(u{3})
% value(u{4})
% uottimo=round(value(u{1}));
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