function [index_s_cross,slope_dif_mean,i_cut,valley] = find_crossover(M)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%% FIND CROSSOVER IN VALLEY OF MATRIX OF SLOPE DIFFERENCES
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%% INPUT:
%%%
%%%                   M - Slope difference matrix 
%%%
%%% OUTPUT:
%%% 
%%%  index_s_cross - Crossover location
%%% slope_dif_mean - Mean of the difference of slopes in the crossover   
%%%          i_cut - Row index for cutting row variances
%%%         valley - Selection of column indexes of near-zero variances 
%%%
[N_row, N_col] = size(M);
%%%
%%% Compute the variances for both rows and columns of M:
var_col = var(M);
var_row = var(M');
%%%
%%% Procedure to delete the initial rows affected by possible noise:
%%%
%%% 1) Delete all the initial rows in which var_row decreases
%%%
dif = diff(var_row);
index_dif = find(dif>0);
i_min = index_dif(1) + 1;
range_row_1 = [i_min:N_row];
%%% Delimitate the row variances in this range
var_row_1 = var_row(range_row_1);
%%% 
%%% 2) Find the maximum of var_row_1 and ensure that var_row_1 values are
%%%    strictly incresing to the maximum
i_max = find(var_row_1 == max(var_row_1)) + i_min - 1;
range_row_2 = 1:i_max;
dif_2 = diff(var_row(range_row_2));
index_dif_2 = find(dif_2<0);
if isempty(index_dif_2)
    i_cut = 1;
else
    i_cut = index_dif_2(end) + 1;
end
%%%
%%% Recalculate the variances from i_cut onwards:
%%%
var_row_cut = var_row(i_cut:end);
var_col_cut = var(M(i_cut:end,:));
%%%
%%% Procedure to select the columns to find the crossover:
%%%
%%% 1) Locate the peaks of var_col_cut
%%%
[pks,locs] = findpeaks(var_col_cut);
%%% 2) Sort peaks in descend order
[sorted,i_sort] = sort(pks,'descend');
% Find the higher peak
i1 = find(var_col_cut == sorted(1));
% Pick a tolerance to find the valley
tol = 10*min(var_col_cut);
for i = 2:length(sorted)
    % Compute the index of the next possible peak
    i_pos = find(var_col_cut == sorted(i));
    a = min(i_pos,i1);
    b = max(i_pos,i1);
    valley = find(var_col_cut(a:b)<=tol);
    if ~isempty(valley) % Stop when the valley is not empty
        break
    end
end
% Recalculate the original indexes
valley = valley + a - 1;
if length(valley) == 1 % A valley with 1 element
   % The crossover is found in that index
   index_s_cross = valley + 1;
   slope_dif_mean = mean(abs(M(:,index_s_cross - 1)));
else
   % Compute the new matrix 
   M_sel = M(i_cut:end,valley);  
   norm_1 = max(sum(abs(M_sel)));
   i_found = find(abs(sum(abs(M_sel)) - norm_1) < 1e-12);
   if length(i_found) == 1
      col_max = M_sel(:,i_found); %%% "maximum column"
      slope_dif_mean = mean(abs(col_max));
      %%%
      %%% The crossover is found in 
      %%%
      index_s_cross = valley(i_found) + 1;
   else
      disp('Warning: There are more than 1 possible crossovers')
      index_s_cross = Inf;
      slope_dif_mean = Inf;
   end
end

end