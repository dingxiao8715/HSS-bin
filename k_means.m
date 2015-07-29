function cluster_labels = k_means(data, centers, num_clusters)
iter = 0;
qold = inf;
threshold = 0.001;


if strcmp(centers, 'random')
  disp('Random initialization...');
  centers = random_init(data, num_clusters);
elseif isempty(centers)
  disp('Orthogonal initialization...');
  centers = orth_init(data, num_clusters);
end


data = double(data);
centers = double(centers);


n = size(data, 1);
x = sum(data.*data, 2)';
X = x(ones(num_clusters, 1), :);
y = sum(centers.*centers, 2);
Y = y(:, ones(n, 1));
P = X + Y - 2*centers*data';


while 1
  iter = iter + 1;

  [val, ind] = min(P, [], 1);
  P = sparse(ind, 1:n, 1, num_clusters, n);
  centers = P*data;
  cluster_size = P*ones(n, 1);
  zero_cluster = find(cluster_size==0);
  if length(zero_cluster) > 0
    disp('Zero centroid. Initialize again...');
    centers(zero_cluster, :)= random_init(data, length(zero_cluster));
    cluster_size(zero_cluster) = 1;
  end
  centers = spdiags(1./cluster_size, 0, num_clusters, num_clusters)*centers;


  y = sum(centers.*centers, 2);
  Y = y(:, ones(n, 1));
  P = X + Y - 2*centers*data';


  qnew = sum(sum(sparse(ind, 1:n, 1, size(P, 1), size(P, 2)).*P));
  mesg = sprintf('Iteration %d:\n\tQold=%g\t\tQnew=%g', iter, full(qold), full(qnew));
  disp(mesg);


  if threshold >= abs((qnew-qold)/qold)
    mesg = sprintf('\nkmeans converged!');
    disp(mesg);
    break;
  end
  qold = qnew;
end

cluster_labels = ind';


%-----------------------------------------------------------------------------
function init_centers = random_init(data, num_clusters)

rand('twister', sum(100*clock));
init_centers = data(ceil(size(data, 1)*rand(1, num_clusters)), :);

function init_centers = orth_init(data, num_clusters)


Uniq = unique(data, 'rows'); 
num = size(Uniq, 1);
first = ceil(rand(1)*num); 
init_centers = zeros(num_clusters, size(data, 2)); 
init_centers(1, :) = Uniq(first, :);
Uniq(first, :) = [];
c = zeros(num-1, 1);

for j = 2:num_clusters
  c = c + abs(Uniq*init_centers(j-1, :)');
  [minimum, i] = min(c);
  init_centers(j, :) = Uniq(i, :);
  Uniq(i, :) = [];
  c(i) = [];
end
clear c Uniq;
