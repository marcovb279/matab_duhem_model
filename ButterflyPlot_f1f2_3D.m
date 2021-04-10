close all
clc

% Parameters
xMin = xyCenter(1)-xWidth/2;
xMax = xyCenter(1)+xWidth/2;
yMin = xyCenter(2)-yWidth/2;
yMax = xyCenter(2)+yWidth/2;
xRange = xWidth; 
yRange = yWidth;
xGridSize = 500;
yGridSize = 500;
xPad = 0.1; 
yPad = 0.1;
xlim([xMin-xRange*xPad xMax+xRange*xPad]);
ylim([yMin-yRange*yPad yMax+yRange*yPad]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Compute f1 f2 mesh
[f1,f2,U,Y,uIsoline,yIsoline] = ...
    DuhemModel.computef1f2InMesh(duhemModel,[xMin,xMax],xGridSize,[yMin,yMax],yGridSize);

% Plots f1 and level set f1=0
% surf(U,Y,f1,'edgecolor','none'); hold on;
% plot3(curve1(:,1),curve1(:,2),zeros(size(curve1,1),1),'r');

% Plots f2 and levelset f2=0
% surf(U,Y,f2,'edgecolor','none'); hold on;
% plot3(curve2(:,1),curve2(:,2),zeros(size(curve2,1),1),'b');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Compute anhysteresis curves
[anHystCurves, avgHystCurves] = ...
    DuhemModel.findAnhysteresisCurve(duhemModel,[xMin,xMax],xGridSize,[yMin,yMax],yGridSize);

% Plots level set f1-f2=0
for i=1:size(anHystCurves,2)
    plot3(anHystCurves{i}(:,1),anHystCurves{i}(:,2),...
        zeros(size(anHystCurves{i},1)),'k');
end
surf(U,Y,f1-f2,'edgecolor','none'); hold on;

% Plots level set f1+f2=0
for i=1:size(avgHystCurve,2)
    plot3(avgHystCurve{i}(:,1),avgHystCurve{i}(:,2),...
        zeros(size(avgHystCurve{i},1)),'m');
end
surf(U,Y,f1+f2,'edgecolor','none'); hold on;

% Plot simulink data
if exist('input') && exist('output')
    plot3(input.data,output.data,zeros(size(input.data,1),1),...
        'k','handleVisibility','off','lineWidth',simLineWidth);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Set color config
colorbar
colormap jet
shading interp
% view([0 90])
xlim([xMin-xRange*xPad xMax+xRange*xPad]);
ylim([yMin-yRange*yPad yMax+yRange*yPad]);
xlabel('u','fontsize',11);
ylabel('y','fontsize',11);