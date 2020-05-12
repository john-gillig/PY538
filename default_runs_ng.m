function [part_count, ttd_all, ttd_def] = default_runs(beta,K)

years = 8; % Number of years simulated set to eight to account for the fact that the longest Leverage_Date is five years
lambda_F = 0.05/(years*252);
% sigma_F = 0.5/sqrt(3*365);
sigma_F = 0.15/sqrt(years*252);
mu_eps = 0;
% sigma_eps = 0.5/sqrt(3*365);
sigma_eps = 0.25/sqrt(years*252);
runs = 5000;
V0 = 100;
% K = 90.70;
T = years*252;
T_ax = 1:1:T;

end_def = 0;
thresh_def = 0;
thresh = linspace(0.9*K,K,T);

part_count = zeros(1,4);

time_track = zeros(1,runs);

for i = 1:runs
    % Reset individual firm characteristic checks
    thresh_check = 0;
    end_check = 0;
    
    % Generate normally distributed arrays
    F = normrnd(lambda_F, sigma_F, 1, T);
    e = normrnd(mu_eps, sigma_eps, 1, T);
    Vt = V0.*cumprod(1+(beta.*F)+e);
    
    % Test for firm ending in default
    if Vt(end) < thresh
        end_def = end_def + 1; 
        end_check = 1;
    end
    
    % Test for whether a firm violates the threshold
    if sum(Vt < thresh) > 0
        thresh_def = thresh_def + 1;
        thresh_check = 1;
    end
    
    % If a firm violates the threshold, track when it does so
    
    violate = Vt < thresh;
    
    if thresh_check == 1
        violate_time = find(violate,1);
    else
        violate_time = 0;
    end
    
    time_track(i) = violate_time;

    % Sort types of violation
    if (thresh_check < 1) && (end_check < 1)
        part_count(1) = part_count(1) + 1;
    elseif (thresh_check < 1) && (end_check > 0)
        part_count(2) = part_count(2) + 1;
    elseif (thresh_check > 0) && (end_check < 1)
        part_count(3) = part_count(3) + 1;
    elseif (thresh_check > 0) && (end_check > 0)
        part_count(4) = part_count(4) + 1;
    end
    
%     hold on
%     plot(T_ax,Vt)
end

% plot(T_ax,thresh,'LineWidth',3)
% title(sprintf('Firm value for B = %0.1f',beta))
 part_count = 100*(part_count./runs);

% Calculate average time until default for all firms
ttd_all = mean(time_track);

% Calculate average time until default for firms that do default
ttd_def_sum = sum(time_track);
ttd_def_num = sum(part_count(3:4))*runs/100;
ttd_def = ttd_def_sum / ttd_def_num;

end