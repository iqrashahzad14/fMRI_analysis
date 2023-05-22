%% plot the coordinates of spherical rois

r=readtable('coordinates3.xlsx');
rt = table2cell(r(:,2:8));

% figure()
% hold on
% plot3(r1(:,1)'or');
% a=rt(:,1);
% c=str2num(char(a(:,:)))

roi1 = rt(:,1); roi2 = rt(:,2); roi3 = rt(:,3); roi4 = rt(:,4); roi5 = rt(:,5); roi6 = rt(:,6); roi7 = rt(:,7);

roi1=str2num(char(roi1)); %#ok<*ST2NM>
roi2=str2num(char(roi2));
roi3=str2num(char(roi3));
roi4=str2num(char(roi4));
roi5=str2num(char(roi5));
roi6=str2num(char(roi6));
roi7=str2num(char(roi7));


blue = [0 0.4470 0.7410];
orange = [0.8500 0.3250 0.0980];
yellow = [0.9290 0.6940 0.1250];
purple= [0.4940 0.1840 0.5560];
green = [0.4660 0.6740 0.1880];
lightblue = [0.3010 0.7450 0.9330];
red = [0.6350 0.0780 0.1840];

for iSub= 1:size(rt,1)
    plot3(roi1(iSub,1),roi1(iSub,2), roi1(iSub,3),'o', 'color',red);%,'MarkerEdgeColor',red, 'MarkerFaceColor',red)
    hold on
    
    plot3(roi2(iSub,1),roi2(iSub,2), roi2(iSub,3),'o', 'color',red)
    hold on
    
    plot3(roi3(iSub,1),roi3(iSub,2), roi3(iSub,3),'o', 'color',orange)
    hold on
    
    plot3(roi4(iSub,1),roi4(iSub,2), roi4(iSub,3),'o', 'color',lightblue)
    hold on
    
    plot3(roi5(iSub,1),roi5(iSub,2), roi5(iSub,3),'o', 'color',yellow)
    hold on
    
    plot3(roi6(iSub,1),roi6(iSub,2), roi6(iSub,3),'o', 'color',green)
    hold on
    
    plot3(roi7(iSub,1),roi7(iSub,2), roi7(iSub,3),'o', 'color',green)
    hold on
end

roiLabels = {'lhMT', 'rhMT', 'lS1' , 'lPC', 'rPC' , 'lMTt', 'rMTt' };
legend(roiLabels)
