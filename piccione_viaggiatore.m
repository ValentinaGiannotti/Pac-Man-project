function viaggi=piccione_viaggiatore(maze)

%% PICCIONE VIAGGIATORE 
[palliniy,pallinix]=find(maze==2 | maze==3); % trova tutte le coordinate dei pallini
nStops=numel(palliniy); %calcola il numero di pallini
if nStops==2
[startRowP,startColP]=find(maze==3);
viaggi=[startRowP,startColP,pallinix(1),palliniy(1)];
else 
idxs = nchoosek(1:nStops,2);
dist = hypot(pallinix(idxs(:,1)) - pallinix(idxs(:,2)), ...
             palliniy(idxs(:,1)) - palliniy(idxs(:,2)));
lendist = length(dist);
G = graph(idxs(:,1),idxs(:,2));
% figure
hGraph = plot(G,'XData',pallinix,'YData',palliniy,'LineStyle','none','NodeLabel',{});
hold on
Aeq = spalloc(nStops,length(idxs),nStops*(nStops-1)); % Allocate a sparse matrix
for ii = 1:nStops
    whichIdxs = (idxs == ii); % Find the trips that include stop ii
    whichIdxs = sparse(sum(whichIdxs,2)); % Include trips where ii is at either end
    Aeq(ii,:) = whichIdxs'; % Include in the constraint matrix
end
beq = 2*ones(nStops,1);
intcon = 1:lendist;
lb = zeros(lendist,1);
ub = ones(lendist,1);
opts = optimoptions('intlinprog','Display','off');
[x_tsp,costopt,exitflag,output] = intlinprog(dist,intcon,[],[],Aeq,beq,lb,ub,opts);
x_tsp = logical(round(x_tsp));
 Gsol = graph(idxs(x_tsp,1),idxs(x_tsp,2),[],numnodes(G));
% Gsol = graph(idxs(x_tsp,1),idxs(x_tsp,2)); % Also works in most cases
hold on
highlight(hGraph,Gsol,'LineStyle','-')
title('Solution with Subtours')
tourIdxs = conncomp(Gsol);
numtours = max(tourIdxs); % number of subtours
fprintf('# of subtours: %d\n',numtours);
A = spalloc(0,lendist,0); % Allocate a sparse linear inequality constraint matrix
b = [];
while numtours > 1 % Repeat until there is just one subtour
    % Add the subtour constraints
    b = [b;zeros(numtours,1)]; % allocate b
    A = [A;spalloc(numtours,lendist,nStops)]; % A guess at how many nonzeros to allocate
    for ii = 1:numtours
        rowIdx = size(A,1) + 1; % Counter for indexing
        subTourIdx = find(tourIdxs == ii); % Extract the current subtour
%         The next lines find all of the variables associated with the
%         particular subtour, then add an inequality constraint to prohibit
%         that subtour and all subtours that use those stops.
        variations = nchoosek(1:length(subTourIdx),2);
        for jj = 1:length(variations)
            whichVar = (sum(idxs==subTourIdx(variations(jj,1)),2)) & ...
                       (sum(idxs==subTourIdx(variations(jj,2)),2));
            A(rowIdx,whichVar) = 1;
        end
        b(rowIdx) = length(subTourIdx) - 1; % One less trip than subtour stops
    end

    % Try to optimize again
    [x_tsp,costopt,exitflag,output] = intlinprog(dist,intcon,A,b,Aeq,beq,lb,ub,opts);
    x_tsp = logical(round(x_tsp));
    Gsol = graph(idxs(x_tsp,1),idxs(x_tsp,2),[],numnodes(G));
    % Gsol = graph(idxs(x_tsp,1),idxs(x_tsp,2)); % Also works in most cases
    
    % Visualize result
    hGraph.LineStyle = 'none'; % Remove the previous highlighted path
    highlight(hGraph,Gsol,'LineStyle','-')
    drawnow
%     
    % How many subtours this time?
    tourIdxs = conncomp(Gsol);
    numtours = max(tourIdxs); % number of subtours
    fprintf('# of subtours: %d\n',numtours)
end
title('Solution with Subtours Eliminated');
hold off
disp(output.absolutegap);
end
%% CALCOLO PERCORSO
if nStops~=2
[pacy,pacx]=find(maze==3);
iniz=find(pallinix==pacx & palliniy==pacy);
vettore=idxs.*x_tsp;
start=find(vettore(:,1)==iniz)
if(numel(start)==0)
    start=find(vettore(:,2)==iniz);
    percorso=[vettore(start,2),vettore(start,1)];
else
    percorso=vettore(start,:);
end
i=1;
for i=1:numel(tourIdxs)+1
    oldstart=start;
    start=find(vettore(:,1)==percorso(i,2));
    start=setdiff(start,oldstart);
    if numel(start)==0
        start=find(vettore(:,2)==percorso(i,2));
        start=setdiff(start,oldstart);
        percorso(i+1,:)=[vettore(start,2),vettore(start,1)];
    else
        percorso(i+1,:)=[vettore(start,:)];
    end

    viaggi(i,:)=[pallinix(percorso(i,1)),palliniy(percorso(i,1)),pallinix(percorso(i,2)),palliniy(percorso(i,2))];

end
end