clc; close all; clear all;
set(0, 'DefaultFigureWindowStyle', 'docked')

nx = 50;
ny = 50;
V = zeros(nx,ny);
G = sparse(nx*ny,ny*nx);

for i = 1:nx
    for j = 1:ny
        
        n = j + (i-1) * ny;     % middle
        nxm = j + (i-2) * ny;	% right
        nxp = j + i * ny;       % left
        nym = j-1 + (i-1) * ny; % top
        nyp = j+1 + (i-1) * ny; % down
        
        if i == 1 || i == nx || j == 1 || j == ny
            G(n,n) = 1;
        else
            G(n,n) = -4;
            G(n,nxm) = 1;
            G(n,nxp) = 1;
            G(n,nym) = 1;
            G(n,nyp) = 1;
        end
        
%         if i > 10 && i < 20 && j > 10 && j < 20
%             G(n,n) = -2;
%         end
        
    end
end

% Plotting the sparsity of the G Matrix
figure('name', 'Matrix');
spy(G);


% Solution to the G Matrix
nmodes = 9;
[E,D] = eigs(G, nmodes, 'SM');

% Plotting the Eigen Values
figure('name', 'Eigen Values');
plot(diag(D), '*');

% Plotting the solution to each mode on a surface
for k = 1:nmodes
    M = reshape(E(:,k), [nx ny]);
    figure(k+1);
    surf(M), title(['Eigen Value = ' num2str(D(k,k))]);
    
end




