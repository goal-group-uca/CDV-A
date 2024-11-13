function M = slope_dif_matrix(logS,logFq,q,method)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%%  SLOPE DIFFERENCES MATRIX ALGORITHM
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%% INPUT:
%%%
%%%   logS - logarithm of the scales
%%%  logFq - matrix with logarithm of fluctuaction functions. 
%%%          Columns represent every moment q.
%%%          Rows should be equal to the length of logS.
%%%      q - set of moments
%%% method - Select the method to use:
%%%            1 - Matrix is the mean across the set q.
%%%            2 - Matrix is the corresponding to q = 2.
%%%
%%% OUTPUT:
%%%
%%% M - Slope difference matrix
%%%
%%%%%%%%%%%%%%%%%%%%%%%%
if method == 2 % q = 2 method
    q_column = input('Select the column in logFq for q = 2: ');
    logFq = logFq(:,q_column);
    q = q(q_column);
end
N_q = length(q);
N_s = length(logS);
w_min = 2; % this is the minimum number to make linear fits
w_max = N_s - 1; % this is the maximum number to make linear fits 
w = w_min:w_max; 
N_w = length(w); 
s_B = logS(w_min:N_s-w_min+1); % central point to compute slopes 
                               % both sides 
N_s_B = length(s_B);
%%% 3D matrix with slope differences
nu = zeros(N_w,N_s_B,N_q);
%%% Initialize the slope matrices for the left and the right fits
m_left = zeros(N_w,N_s_B,N_q);
m_right = zeros(N_w,N_s_B,N_q);
for qq = 1:N_q 
    for ss = 1:N_s_B 
        for ww = 1:N_w 
            index = find(logS==s_B(ss)); % index to center the fits
            % Left linear fits
            if index <= w(ww) % asymmetrical windows
                x_left = logS(1:index); 
                y_left = logFq(1:index,qq);
            else
                x_left = logS(index - (w(ww)-1) :index);
                y_left = logFq(( index - (w(ww)-1) ):index,qq);
            end
            p_left = polyfit(x_left,y_left,1);
            m_left(ww,ss,qq) = p_left(1); % left slope
            % Right linear fits
            if (N_s - index) <= w(ww) % asymmetrical windows
                x_right = logS(index:end);
                y_right = logFq(index:end,qq);
            else
                x_right = logS(index: (index + w(ww)-1) );
                y_right = logFq(index:(index + w(ww)-1),qq);
            end
            p_right = polyfit(x_right,y_right,1);
            m_right(ww,ss,qq) = p_right(1); % right slope
            % Absolute value for the difference of slopes
            nu(ww,ss,qq) = abs(m_left(ww,ss,qq) - m_right(ww,ss,qq));
        end
    end
end

M = mean(nu,3); % Matrix of difference of slopes

end