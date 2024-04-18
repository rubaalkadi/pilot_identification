function [PilotsAllSessions]=ReadPilotData(Col)
% Col is the column number to be read 

InputDir='C:\Users\ruba.alkadi\Dropbox\C2PS Project\Data_shifted here on March 1-2021\Data December 2017\all';
pilotdir=dir(InputDir); 
pilots={pilotdir(3:end).name}; % three folders of data  
numberOfPilots= length(pilots);

for n=1:numberOfPilots
    % access pilot foldr 
    pilotFolder=[InputDir '\' pilots{n}];
    cd(pilotFolder);
    % find sessions 
    sessions=dir(pilotFolder);
    sessionsNames={sessions(3:end).name};
    sessionsCount=length(sessionsNames);
    % Read each excel sheet session into a cell array
    for s=1:sessionsCount
        session{s}=xlsread(sessionsNames{s});
        
        % remove date and time 
        if size(session{s},2)==22
            session{s}(:,1:3)=[];
        elseif size(session{s},2)==21
            session{s}(:,1:2)=[];
        end
        session{s}=session{s}(:,Col);
    end
       
            
    PilotsAllSessions{n}=cell2mat(session');
    clear session
    cd .. 
end 

end 