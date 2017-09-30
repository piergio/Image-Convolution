clear;
clc;

image_name = 'test_23x10.jpg';
load mask_7x7;

h = waitbar(0,'Please wait...');
image = imread(image_name);
[l, x] = size(MASK);
[s, z] = size(image);
SIZE = s*z;

End_Time = s*z + l*z + l*x + 10;

Progetto_1_0

set_param('Progetto_1_0/IMAGE_SOURCE', 'FileName',  strcat('./', image_name));

switch l
    case 3
        
        set_param('Progetto_1_0', 'FixedStep', '1/20');
        set_param('Progetto_1_0/CONVOLVER/IMAGE_PROCESSOR/ADDRESSER/PLL/FAST_PULSE', 'Period', '1/10');
    case 5
        
        set_param('Progetto_1_0', 'FixedStep', '1/52');
        set_param('Progetto_1_0/CONVOLVER/IMAGE_PROCESSOR/ADDRESSER/PLL/FAST_PULSE', 'Period', '1/26');
    case 7
        
        set_param('Progetto_1_0', 'FixedStep', '1/100');
        set_param('Progetto_1_0/CONVOLVER/IMAGE_PROCESSOR/ADDRESSER/PLL/FAST_PULSE', 'Period', '1/50');
end

simulazione = sim('Progetto_1_0', 'StopTime', int2str(End_Time));
simout = simulazione.get('simout');

[m, n] = size(simout);
new_image = zeros(s, z);

k = 1;
j = 1;

for i = 1:m
    
    new_image(j, k) = simout(i);
    k = k + 1;
    if(k > z)
        
       j = j + 1;
       k = 1;
    end
end

imwrite(new_image, 'new_foto.jpg');
valutate = not(double(image) - new_image);
close(h);
clearvars -except valutate new_image image ;
