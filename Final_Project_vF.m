%% PY538 Term Paper - John Gillig

%% 1.0 Hypothesis
% Global travel has been severly reduced due to the inability of many to 
% travel thanks to a combination of governmental restrictions and voluntary
% consumer abstinence alike.  Airlines have a history of being
% significantly overlevered, in part thanks to a motivation to maximize
% razor-thin operating margins.  Desipite being a relatively sound strategy
% during times of high and minimally volatile demand, during times of
% economic turmoil, especially where demand for travel is disproportionately 
% impacted, airlines can quickly run afoul of loan covenants as their cash
% flow dries up and firm assets approach a level where they are not
% sufficient to repay outstanding firm debt.  Here, we hypothesize that the
% application of lessons learned from past airline bankruptcies ("Risk-Averse
% Airline Financial Stragegies", a.k.a. RAAFS) would be sufficient to protect 
% today's airlines from bankrupty during current unprecedented drops in demand.

%% 2.0 Methodology
% Firstly, we establish the past airline bankrupcies which will serve
% as benchmarks on which to base the establishment of Risk-Averse Airline Financial
% Strategies.  Filtering for airlines whose stock was traded on a U.S.-based 
% public exchange for at least one year prior to their bankruptcy for reasons 
% of financial metric availability, we find that the following airlines have
% gone through Chapter 11 reorganizations or Chapter 7 liquidations since
% 1978, the date of the Airline Degregulation Act in the United States, an
% act which removed the imposition of government pricing and market-entry
% limitations(1).  Furthermore, to account for the fact that this anlysis 
% focuses on the *ideal* capital structure for airlines, only the nine largest
% airline bankrupcies have been selected for the historical analyis on which 
% the RAAFS will be based, because of the well-documented correlation between 
% company scale and ability to achieve a target capital structure.  Those 
% bankruptcies, as well as their corresponding asset values, are as follows:

%% 
warning('off','MATLAB:table:ModifiedAndSavedVarnames');
top9 = readtable('top9.csv'); %(2)
top9 = removevars(top9,{'Source'});
disp(top9(:,1:4))
disp(top9(:,[1,5:7]))
disp(top9(:,[1,7:9]))
disp(top9(:,[1,10:11]))
%%
% To examine the progression of these nine airlies toward bankruptcy, and the potential 
% role that each airline's capital struture played in its eventual bankruptcy,
% we examine the most risk-averse capital structure reported by each
% airline during the five calendar years preceding the date of its bankruptcy filing 
% (3), with the rationale that a company's most conversative capital structure
% is reflective of sound financial management a management's ability to prioritize
% financial safety over unrealistic returns to equity driven by a highly levered
% capital structure.  Of the nine all-time largest airline bankrupcies, the top six
% involved then-publicly traded airlines.  To examine the probability that
% each airline would default given its current debt load [(with an average
% maturity of fifteen years assumed (4))], the sum of each airline's long term
% debt and current portion of long term debt is compared to the firm's
% total value.  To ensure compatibility with the model used, each firm's
% value is rebased to 100 and each firm's debt is rebased to a percentage
% of 100.  In the time domain, each firm's value is then assumed to
% progress from that baseline value in the pattern of an independent random walker following a Geometric Brownian
% Motion.  With this assumption, the average date can be calculated on which 
% each airline is expected to default, based on an assumed standard
% deviation of 10%.  With the act of defaulting taken synonymously with 
% a negative leverage--or the scenario in which firm equity value is negative--those 
% findings are as follows:

beta = 0.5:0.5:1.5;
beta_relation = zeros(3,3);
beta_relation(:,1) = beta;

out_table = array2table(zeros(4,4),'VariableNames',{'Part','Beta_OneHalf','Beta_One','Beta_ThreeHalfs'});
out_table.Part = {'i','ii','iii','iv'}';

%%
% Here, we can view the percentage of firms out of the 5000 runs that (i) neither violate the
% threhshold nor default by the end, (ii) do not violate the threshold but
% default by the the end, (iii) violate the threshold but do not default at
% the end, and (iv) violate the threshold and default at the end for each
% of the leverage scenarios presented for the six airlines.  We can also
% examine the relation between beta and average time until default (in days) among
% all firms (presented in the "TTD_All" row) as well as conditioned on firmst that 
% did in fact default (presented in the "TTD_Def" row), compared to
% the **acutal** time to default for each of the six major airline
% bankrupcies.

%% 2.0 Historical Data Analysis
%% 2.1 American's 2011 Bankruptcy
identifier = 1;
K = top9.Rebased_Debt(identifier);

for i = 1:length(beta)
    figure()
    [part_count, ttd_def, ttd_all] = default_runs(beta(i),K);
    beta_relation(i,2) = ttd_all;
    beta_relation(i,3) = ttd_def;
    out_table.(i+1) = part_count(:);    
end
ttd_table = array2table(beta_relation','RowNames',{'Beta','TTD_All','TTD_Def'},'VariableNames',{'Beta_1','Beta_2','Beta_3'});
%%
% The top table details the percentage of companies experiencing each
% type of default for each beta value, while the bottom table shows the
% average time until default for all companies and conditioned on companies
% that actually default, respectively.

disp(out_table)
disp(ttd_table)
top9(identifier,12:14) = ttd_table(2,:);

%% 2.2 United's 2002 Bankruptcy
identifier = 2;
K = top9.Rebased_Debt(identifier);

for i = 1:length(beta)
    figure()
    [part_count, ttd_def, ttd_all] = default_runs(beta(i),K);
    beta_relation(i,2) = ttd_all;
    beta_relation(i,3) = ttd_def;
    out_table.(i+1) = part_count(:);    
end
ttd_table = array2table(beta_relation','RowNames',{'Beta','TTD_All','TTD_Def'},'VariableNames',{'Beta_1','Beta_2','Beta_3'});
%%
% The top table details the percentage of companies experiencing each
% type of default for each beta value, while the bottom table shows the
% average time until default for all companies and conditioned on companies
% that actually default, respectively.

disp(out_table)
disp(ttd_table)
top9(identifier,12:14) = ttd_table(2,:);

%% 2.3 Delta's 2005 Bankruptcy
identifier = 3;
K = top9.Rebased_Debt(identifier);

for i = 1:length(beta)
    figure()
    [part_count, ttd_def, ttd_all] = default_runs(beta(i),K);
    beta_relation(i,2) = ttd_all;
    beta_relation(i,3) = ttd_def;
    out_table.(i+1) = part_count(:);    
end
ttd_table = array2table(beta_relation','RowNames',{'Beta','TTD_All','TTD_Def'},'VariableNames',{'Beta_1','Beta_2','Beta_3'});
%%
% The top table details the percentage of companies experiencing each
% type of default for each beta value, while the bottom table shows the
% average time until default for all companies and conditioned on companies
% that actually default, respectively.

disp(out_table)
disp(ttd_table)
top9(identifier,12:14) = ttd_table(2,:);

%% 2.4 Northwest's 2005 Bankruptcy
identifier = 4;
K = top9.Rebased_Debt(identifier);

for i = 1:length(beta)
    figure()
    [part_count, ttd_def, ttd_all] = default_runs(beta(i),K);
    beta_relation(i,2) = ttd_all;
    beta_relation(i,3) = ttd_def;
    out_table.(i+1) = part_count(:);    
end
ttd_table = array2table(beta_relation','RowNames',{'Beta','TTD_All','TTD_Def'},'VariableNames',{'Beta_1','Beta_2','Beta_3'});
%%
% The top table details the percentage of companies experiencing each
% type of default for each beta value, while the bottom table shows the
% average time until default for all companies and conditioned on companies
% that actually default, respectively.

disp(out_table)
disp(ttd_table)
top9(identifier,12:14) = ttd_table(2,:);

%% 2.5 US Airways's 2005 Bankruptcy
identifier = 5;
K = top9.Rebased_Debt(identifier);

for i = 1:length(beta)
    figure()
    [part_count, ttd_def, ttd_all] = default_runs(beta(i),K);
    beta_relation(i,2) = ttd_all;
    beta_relation(i,3) = ttd_def;
    out_table.(i+1) = part_count(:);    
end
ttd_table = array2table(beta_relation','RowNames',{'Beta','TTD_All','TTD_Def'},'VariableNames',{'Beta_1','Beta_2','Beta_3'});
%%
% The top table details the percentage of companies experiencing each
% type of default for each beta value, while the bottom table shows the
% average time until default for all companies and conditioned on companies
% that actually default, respectively.

disp(out_table)
disp(ttd_table)
top9(identifier,12:14) = ttd_table(2,:);

%% 2.6 US Airways's 2002 Bankruptcy
identifier = 6;
K = top9.Rebased_Debt(identifier);

for i = 1:length(beta)
    figure()
    [part_count, ttd_def, ttd_all] = default_runs(beta(i),K);
    beta_relation(i,2) = ttd_all;
    beta_relation(i,3) = ttd_def;
    out_table.(i+1) = part_count(:);    
end
ttd_table = array2table(beta_relation','RowNames',{'Beta','TTD_All','TTD_Def'},'VariableNames',{'Beta_1','Beta_2','Beta_3'});
%%
% The top table details the percentage of companies experiencing each
% type of default for each beta value, while the bottom table shows the
% average time until default for all companies and conditioned on companies
% that actually default, respectively.

disp(out_table)
disp(ttd_table)
top9(identifier,12:14) = ttd_table(2,:);

%% 2.7 Summary of Historical Data Analysis
% We now compare the average days until default calculated using each beta
% value to the actual time to default in order to ascertain which beta
% value is the most accurate predictor of airline time to default.

top9.Accuracy_Beta1 = abs((top9.Time_Predicted_Beta1 - top9.Time_Actual) ./ top9.Time_Predicted_Beta1);
top9.Accuracy_Beta2 = abs((top9.Time_Predicted_Beta2 - top9.Time_Actual) ./ top9.Time_Predicted_Beta2);
top9.Accuracy_Beta3 = abs((top9.Time_Predicted_Beta3 - top9.Time_Actual) ./ top9.Time_Predicted_Beta3);
disp(top9(:,[1:3,15:17]))
%%
% To determine which beta value best predicts the time until airline
% default, we now average the accuracy of each beta value over the six
% firms of interest, finding the following results:

for i = 1:3
    beta_accuracy(1,i) = nanmean(table2array(top9(:,i+14)));
end

beta_accuracy_table = array2table(beta_accuracy,'VariableNames',{'Beta_1','Beta_2','Beta_3'});
disp(beta_accuracy_table)
%%
% Here we can see that beta = 1.5 produces times to default that are, on
% average, within 70% accurate of the actual default time.  Therefore, a
% beta of 1.5 will be applied to current data in order to predict the
% estimated times to default for airlines in 2020.

%% 3.0 Current Application of Historical Findings
% Having established the beta value that most accurately predicts an
% airline's time to default, we can now apply the model to the following airlines
% and their capital structures as of CYE 2019.  
airlines_2019 = readtable('Airline_Data_CYE2019.csv'); %(5)
airlines_2019 = airlines_2019(~any(ismissing(airlines_2019),2),:);
%%
% We can now run the default_runs code, this time without the graphing
% capability to avoid duplicativeness, in order to find the predicted time
% to default for the six major US airlines as of 2019.

beta_new = 1.5;
Kmat = airlines_2019.Rebased_Debt';

for i = 1:length(Kmat)
    [part_count, ttd_def, ttd_all] = default_runs_ng(beta_new,Kmat(i));
    new_default_track(i) = ttd_all;
end

airlines_2019.Days_to_Default = new_default_track';

disp(airlines_2019(:,1:4))
disp(airlines_2019(:,[1,5:7]))
disp(airlines_2019(:,[1,8:10]))

%% 3.1 Conclusion
% Based on financial metrics, speficially the projected time to default using a 
% random walk in a Geometric Brownian Motion, airlines in 2020 are far
% better prepared to weather financial distress than their predecessors, as evidenced by a far
% larger Days to Default for CYE2019 airlines than the all-time six largest airline
% defaults by asset size.  Altogether, this is an ecouraging trend in an
% industry with an extensive history of fiscal irresponsibility.

%% 4.0 Works Cited
% (1) https://www.econlib.org/library/Enc/AirlineDeregulation.html 
%%
% (2) https://www.mcgill.ca/iasl/files/iasl/aspl613_paul_dempsey_airlinebankruptcies2012.pdf
%%
% (3) FactSet, BamSEC
%%
% (4) IBISWorld
%%
% (5) FactSet
%% 5.0 Appendix A
% Display default_runs function code
type default_runs