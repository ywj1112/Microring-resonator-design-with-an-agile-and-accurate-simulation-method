# Microring-resonator-design-with-an-agile-and-accurate-simulation-method
In this Project, several simulation methods and example files for silicon photonic applications are provided, including
1. coupling_coefficients_calculation.fsp \
FDTD simulation for whispering-gallery modes resonance calculation, the example file is based on Lumerical FDTD for the microring resonator simulation. 

2. Microring_response_calculation.m \
After calculating the coupling coefficient from the Lumerical FDTD, the coupling can be substitue into the Matlab function to work out the spectrum response.\
This Matlab file returns amplitude response and phase response by substituting coupling coefficient calculated in 1. coupling_coefficients_calculation.fsp

3. loss_calculation_all_pass.m or loss_calculation_add_drop.m \
Due the fabrication error, the design coupling coefficient may be different as the actual fabricated structure. To solve this problem, this Matlab script helps to calculate the coupling coefficient and propagation loss. \
The propagation loss is dependent on mode loss, bending loss and surface scattering. \ 
The inaccuracy of the coupling coefficient may be caused by gap control, length variation and size mismatch in the fabrication. \

The characteristic polynomial will give 4 different roots, first two positive roots are coupling coefficient and propagation loss (1/um) respectively, it is impossible to tell which one is which, it can only be distinguished by using FDTD simulation mentioned in 1. coupling_coefficients_calculation.fsp to work out the estimated coupling coefficient value. 


More details of the background and fundamental knowledge is covered in my thesis. Link will be available when University uploads it in the database. 

The author would like to thank the help from Lumerical Knowledge Exchange (https://kx.lumerical.com/), and I learnt a lot from book 'Silicon photonics design: from devices to systems' by Lukas Chrostowski. 
