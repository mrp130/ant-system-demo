cities = [1 3; 1 7; 3 9; 5 3; 7 1; 9 5; 9 9; 11 1; 15 7; 19 3]; 

%euclidean distance antar kota (kota i,j)
distances = squareform(pdist(cities));

eta = 1 ./ distances;

%inisialisasi konstanta
alpha = 1;
beta = 2;
rho = 0.99;
Q = 100;

max_cycle = 200;
init_tao = 0;
ant_quantity = 20;

%inisialisasi tao kota i,j
tao = eye(length(cities));
tao(tao~=1) = init_tao;
tao(tao==1) = 0;


ants(ant_quantity,1) = Ant(cities);
for i = 1 : length(ants)
    ants(i) = Ant(cities);
    ants(i).randomStartPosition();
end

cycle = 1;
while cycle < max_cycle
    cycle
    for i = 1 : length(ants)
       ants(i).travel(tao, alpha, eta, beta);
    end

    for i = 1 : length(ants)
       tao = ants(i).updatePheromones(tao, rho, Q, distances);
    end
        
    [steps, distance] = currentShortest(ants, distances);
    
    if isSameRoute(ants)
        disp('same route');
        break
    end
    
    for i = 1 : length(ants)
       ants(i).backToStartPosition();
    end
    
    cycle = cycle + 1;
end