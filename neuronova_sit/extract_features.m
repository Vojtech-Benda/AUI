function [GSR_area_1 GSR_average_2 GSR_std_3 GSR_number_peaks_4 GSR_average_peak_amplitude_5 GSR_amplitude_sum_6 GSR_Entropy_7 GSR_second_moment_8 GSR_length]=extract_features(GSR_test)

% 1. vypocet plochy pod krivkou fazicke aktivity meditacni faze
GSR_area_1=trapz(1:length(GSR_test), GSR_test);

% 2. prumer fazicke slozky meditaceni faze
GSR_average_2 = mean(GSR_test);

% 3. smerodatna odchylka fazicke slozky meditaceni faze
GSR_std_3 = std(GSR_test);

% 4. pocet peaku v GSR
filt_data=medfilt1(GSR_test,5);
if numel(GSR_test)>3
[pks,locs] = findpeaks(GSR_test);
else
    locs=0;pks=0;
end
if numel(locs)>=1
GSR_number_peaks_4=numel(locs);
else
    GSR_number_peaks_4=0;
end

% 5. prumerna hodnota amplitudy peaku 
if numel(locs)>=1
    GSR_average_peak_amplitude_5=mean(pks);
else

    GSR_average_peak_amplitude_5=0;
end

% 6. suma amplitud peaku 
if numel(locs)>=1
GSR_amplitude_sum_6= sum(pks);
else
    GSR_amplitude_sum_6= 0;
end

% 7. entropie fazicke aktivity meditaceni faze

p = hist(GSR_test);
% remove zero entries in p
p(p==0) = [];
% normalize p so that sum(p) is one.
p = p ./ numel(GSR_test);
GSR_Entropy_7=-sum(p.*log(p));

% 8. druhý moment fazicke aktivity
GSR_second_moment_8=moment(GSR_test,2);

GSR_length=numel(GSR_test);

end