# Author name: Wenjian Yang
# Email: yangelec@gmail.com

% %% initialization 
% FSR = 2.687251799783326; % nm
% BW = 0.131331724380061; % nm
% ER = 25.118864; % unity use substraction or divison for absolute value
% perimeter = 2*21+2*27.67*pi; % nm


%% initialization 
FSR = 0.789356325256449; % nm
BW = 0.041135164613479; % nm
ER = 39.81; % unity use substraction or divison for absolute value
perimeter = 2*50+2*102.717*pi; % um


%% Calculation
syms r a power_attenuation_coefficient
T_t = (r+a)^2/(1+r*a)^2;
R_min = (r-a)^2/(1-r*a)^2;
extinction_ratio = T_t/R_min;
finesse = (pi*sqrt(r*a))/(1-r*a);
eqns = [finesse == FSR/BW, extinction_ratio == ER];
S = solve(eqns,[r a]);
% plot(S.a)
a_value = double(S.a)

plot(S.a)
%%
alpha = power_attenuation_coefficient./(10*log10(exp(1)))*10^(-4); % loss in 1/um
single_pass_amplitude_transmission = sqrt(exp(-perimeter*alpha)); % single-pass amplitude transmission
s_loss = solve(single_pass_amplitude_transmission == 0.933480248609825, power_attenuation_coefficient);
loss = double(s_loss)

% 0.912135728577831
%   0.940428697026330
%% 


