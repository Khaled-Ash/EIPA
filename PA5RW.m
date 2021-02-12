%
% PA5
% Khaled AbouShaban   101042658
%

clear all
close all

set(0,'DefaultFigureWindowStyle','docked')
nx = 50;
ny = 50;
V = zeros(nx, ny);
G = sparse(nx * ny,nx * ny);

% G matrix

for i = 1:nx
    for j = 1:ny
        n = j + (i - 1) * ny;
        if i == 1 || j == 1 || i == nx || j == ny
            G(n,:) = 0;
            G(n,n) = 1;
        else
            G(n,n) = -4;
            G(n,n + 1) = 1;
            G(n,n - 1) = 1;
            G(n,n + ny) = 1;
            G(n,n - ny) = 1;
        end
    end
end

figure('name', 'Matrix');
spy(G)

% Plot
nmodes = 9;
[E,D] = eigs(G,nmodes,'SM');
figure('name','Eigen Values');
plot(diag(D),'*');

figure('name','Modes');
for K = 1:nmodes
    M = E(:,K);
    for i = 1:nx
        for j = 1:ny
            n = i + (j - 1) * nx;
            V(i,j) = M(n);
        end
        subplot(3,3,K);
        surf(V);
        title(['EV = ' num2str(D(K,K))])
    end
end

