function [cluster_labels evd_time kmeans_time total_time] = sc(A, sigma, num_clusters)

disp('Converting distance matrix to similarity matrix...');
tic;
n = size(A, 1);

if (sigma == 0) 
  disp('Selftuning spectral clustering...');
  col_count = sum(A~=0, 1)';
  col_sum = sum(A, 1)';
  col_mean = col_sum ./ col_count;
  [x y val] = find(A);
  A = sparse(x, y, -val.*val./col_mean(x)./col_mean(y)./2);
  clear col_count col_sum col_mean x y val;
else 
  disp('Fixed-sigma spectral clustering...');
  A = A.*A;
  A = -A/(2*sigma*sigma);
end


num = 2000;
num_iter = ceil(n/num);
S = sparse([]);
for i = 1:num_iter
  start_index = 1 + (i-1)*num;
  end_index = min(i*num, n);
  S1 = spfun(@exp, A(:,start_index:end_index)); 
  S = [S S1];
  clear S1;
end
clear A;
toc;


disp('Doing Laplacian...');
D = sum(S, 2) + (1e-10);
D = sqrt(1./D); 
D = spdiags(D, 0, n, n);
L = D * S * D;
clear D S;
time1 = toc;


disp('Performing eigendecomposition...');
OPTS.disp = 0;
[V, val] = eigs(L, num_clusters, 'LM', OPTS);
time2 = toc;


disp('Performing kmeans...');
sq_sum = sqrt(sum(V.*V, 2)) + 1e-20;
U = V ./ repmat(sq_sum, 1, num_clusters);
clear sq_sum V;
cluster_labels = k_means(U, [], num_clusters);
total_time = toc;


evd_time = time2 - time1
kmeans_time = total_time - time2
total_time
disp('Finished!');
