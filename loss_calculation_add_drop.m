%% initialization 
FSR = 2.708412276848549; % nm
BW = 0.143398255979264; % nm
ER = 1- 0.03981; % unity
perimeter = 215.86; % um


%% Calculation
syms r a power_attenuation_coefficient
T_t = (r+a)^2/(1+r*a)^2;
R_min = (r-a)^2/(1-r*a)^2;
extinction_ratio = T_t/R_min;
finesse = (pi*sqrt(r*a))/(1-r*a);
eqns = [finesse == FSR/BW, extinction_ratio == ER];
S = solve(eqns,[r a])
a_value = double(S.a)

plot(S.a)
%%
alpha = power_attenuation_coefficient./(10*log10(exp(1)))*10^(-4); % loss in 1/um
single_pass_amplitude_transmission = sqrt(exp(-perimeter*alpha)); % single-pass amplitude transmission
s_loss = solve(single_pass_amplitude_transmission == 0.933480248609825, power_attenuation_coefficient);
loss = double(s_loss)
