clear all; close all; clc;
fid = fopen('napoli.y','r');
x = fread(fid,[512 512],'uchar');
x = x';
fclose(fid);

% Quantizzazone uniforme
for b=1:5
    y1(:,:,b) = QU1(x,b);                  % Quantizzazione sulla dinamica
    VAR1 = std2(y1(:,:,b)).^2;             % Varianza
    MSE1 = mean2((x-y1(:,:,b)).^2);        % MSE
    SNR1(b) = 10*log10(VAR1/MSE1);         % SNR
    
    y2(:,:,b) = QU2(x,b);                  % Quantizzazione sui BitPlane
    VAR2 = std2(y2(:,:,b)).^2;
    MSE2 = mean2((x-y2(:,:,b)).^2);    
    SNR2(b) = 10*log10(VAR2/MSE2);
end 

% Plot SNR
bit = 1:5;
figure; plot(bit, SNR1, '-r*', bit, SNR2,'-b*'); xlabel('bit'); ylabel('SNR');	legend('Q. sulla dinamica','Q. sui Bit Plane')

% Visualizzazione

figure('Name','Quantizzazione tramite Rimozione Bit-Plane','NumberTitle','off');
for i=1:5
    subplot(1,5,i); imshow(y2(:,:,i),[0 255]); title(sprintf('Quantizzazione su %d Bit-Plane',i));
end

figure('Name','Quantizzazione sulla dinamica'); 
for i=1:5
    subplot(1,5,i); imshow(y1(:,:,i),[0 255]); title(sprintf('Quantizzazione su %d bit',i));
end
