% Princeton COS323
% Final Project
% Author: Solomon (sabiola), Daniel (dyeboah), Brandon (brhodes)
% Graphs the results of the system in real time
function [] = grapher(M,H,T,N,Sm,Im,Length,S,t)
% This function graphs in real time the dynamics of the system
subplot(2,2,1);
gscatter(M(:,1),M(:,2),M(:,7),'bgrcmyk','.',5,'on','x (arbitrary length units)','y (arbitrary length units)');
hold on
 
% Only draw the legend once so as to not waste time redrawing it
if t == 1
    xlim([0 Length]);
    ylim([0 Length]);
    title('Dynamic Model of Population in Environment')
end
 
% Plot the number of survivors
subplot(2,2,2);
plot(S(:,1),'g');
hold on
plot(S(:,2),'r');
plot(Sm,'b--')
plot(Im,'m--')
 
% Only draw the legend once so as to not waste time redrawing it
if t == 1
    legend('Survivors (reality)', 'Zombies (reality)','Survivors (predicted)','Zombies (predicted)')
    axis([0 T 0 N]);
    xlabel('Time (arbitrary t units)');
    ylabel('Population');
    title('Dynamic Model of Population');
end
 
% Plot the total ammo of everyone who is living
subplot(2,2,4);
gscatter(M(:,1),M(:,2),M(:,3),'bgrcmyk','o',5,'on');
% Only draw the legend once so as to not waste time redrawing it
hold on;
xlabel('x (arbitrary length units)');
ylabel('y (arbitrary length units)');
title('Dynamic Model of Ammo');
 
% Generate a heatmap showing where deaths occur
subplot(2,2,3);
colormap('jet');
% Only draw the legend once so as to not waste time redrawing it
if t == 1
    hold on;
    xlabel('x (arbitrary length units)');
    ylabel('y (arbitrary length units)');
    title('Heatmap of Deaths');
    xlim([0 Length]);
    ylim([0 Length]);
end
imagesc((H));
colorbar;
drawnow;
 
end