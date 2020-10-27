# Author name: Wenjian Yang
# Email: yangelec@gmail.com

lambda = (1525:0.0001:1580)*1e-9;

[Ethru Edrop Qi Qc]=RingResonator(lambda, 'add-drop', 10.081e-6, 0);
figure(1)
hold on
yyaxis left
plot (lambda*1e9, [db(abs(Ethru)/2); db(abs(Edrop)/2)])



set(gca,'FontSize', 16)
set(gca,'FontName', 'Times New Roman')
box on;
ylabel('Relative power (dB)'), xlabel('Wavelength (nm)')

yyaxis right
plot((lambda)*1e9, angle(Ethru))
ylabel('Phase (Degree)')


function [Ethru, Edrop, Qi, Qc]=RingResonator(lambda, Filter_type, r, Lc)
% lambda: wavelength (can be a 1D array) in meters
% type: "all-pass" or "add-drop"
% r: radius
% Lc: coupler length
k=0.1; 

t=sqrt(1-k^2);         %coupling coefficients

neff = neff_lambda(lambda);
if lambda(1)==lambda(end)
	ng=neff - lambda(1) * (neff-neff_lambda(lambda(1)+0.1e-9)/0.1e-9);
else
   ng = neff(2:end) - (diff(neff)./diff(lambda)).* mean(lambda);  % for Q calculations
	ng = [ng(1) ng];
end

alpha_wg_dB=30;    % optical loss of optical waveguide, in dB/cm
alpha_wg=-log(10^(-alpha_wg_dB/10));% converted to /cm
L_rt=Lc*2+2*pi*r;
phi_rt=(2*pi./lambda).*neff*L_rt;
A=exp(-alpha_wg*100*L_rt);    % round-trip optical power attenuation
alpha_av=-log(A)/L_rt;        % average loss of the cavity
Qi=2*pi*ng./lambda/alpha_av;  % intrinsic quality factor

if (Filter_type=='all-pass')
	Ethru=(-sqrt(A)+t*exp(-1i*phi_rt)) ./ (-sqrt(A)*conj(t)+exp(-1i*phi_rt));
	Edrop=zeros(1,length(lambda));
	Qc=-(pi*L_rt*ng)./(lambda*log(abs(t)));
elseif (Filter_type=='add-drop')  % symmetrically coupled
	Ethru=(t-conj(t)*sqrt(A)*exp(1i*phi_rt)) ./ (1-sqrt(A)*conj(t)^2*exp(1i*phi_rt));
	Edrop=-conj(k)*k*sqrt(sqrt(A)*exp(1i*phi_rt)) ./ (1-sqrt(A)*conj(t)^2*exp(1i*phi_rt));
	Qc=-(pi*L_rt*ng)./(lambda*log(abs(t)))/2;
else
	error(1, 'The''Filter_type'' has to be ''all-pass'' or ''add-drop''.\n');
end
end

function [neff]=neff_lambda(lambda)
neff = 2.57 - 0.85*(lambda*1e6-1.55);
end