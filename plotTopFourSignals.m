ReadPilotData([17,14,16,2])
figure
subplot(2,2,1)
hold on
plot([30:0.1:50],ans{5}(300:500,1),'-')
plot([30:0.1:50],ans{4}(300:500,1),'--')
plot([30:0.1:50],ans{3}(300:500,1),'k-.')
% plot([30:0.1:50],ans{2}(300:500,1))
xlabel('Time (sec)')
ylabel('Thrust (ppm)');
subplot(2,2,2)
hold on
plot([30:0.1:50],ans{5}(300:500,2),'-')
plot([30:0.1:50],ans{4}(300:500,2),'--')
plot([30:0.1:50],ans{3}(300:500,2),'k-.')
% plot(ans{2}(300:500,2))
xlabel('Time (sec)')
ylabel('Height (mm)');

subplot(2,2,3)
hold on
plot([30:0.1:50],ans{5}(300:500,3),'-')
plot([30:0.1:50],ans{4}(300:500,3),'--')
plot([30:0.1:50],ans{3}(300:500,3),'k-.')
% plot(ans{2}(300:500,3))
xlabel('Time (sec)')
ylabel('Pitch (ppm)');

subplot(2,2,4)
hold on
plot([30:0.1:50],ans{5}(300:500,4),'-')
plot([30:0.1:50],ans{4}(300:500,4),'--')
plot([30:0.1:50],ans{3}(300:500,4),'k-.')
% plot(ans{2}(300:500,4))
xlabel('Time (sec)')
ylabel('Angle Roll (deg)');
