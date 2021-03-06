function data = demeshnek(mesh,lr1)
%
% Demesh a meshgrid to data
%
%   [data] = reshapenek(mesh,lr1)
%
%   INPUT
%   - mesh:   meshgrid (fields along third index)
%   - lr1:    element-size vector (lx1,ly1,lz1)
%
%   OUTPUT
%   - data:   nek5000 data ordered as (iel,inode,[x|y|(z)|u|v|(w)|p|T|s_i])
%
% Last edit: 20151028 Nicolo Fabbiane (nicolo@mech.kth.se)
%

if length(lr1) == 1
    lr1 = [lr1 lr1 1];
end

% get dimension and check number of elements
[nely,nelx,nfld] = size(mesh); nelx = (nelx-1)/(lr1(1)-1); nely = (nely-1)/(lr1(2)-1);

if (mod(nelx,1)~=0)|(mod(nely,1)~=0)
    disp('Error: N not compatible with the mesh.');
    return
end

nel = nelx*nely;

% reshape data
data = zeros(nel,prod(lr1),nfld);

for ifld = 1:nfld
    
    for ielx = 1:nelx
        for iely = 1:nely
            
            iel = iely + nely*(ielx-1);
            
            ii = (0:lr1(1)-1) + (lr1(1)-1)*(ielx-1) + 1;
            jj = (0:lr1(2)-1) + (lr1(2)-1)*(iely-1) + 1;
        
            data(iel,:,ifld) = reshape(mesh(jj,ii,ifld)',prod(lr1),1);
            
        end
    end
    
end
