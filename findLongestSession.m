function [longestsession,longestsessionIdx]=findLongestSession(session)
    l=numel(session);
    for k=1:l
        lengthofsession(k)=size(session{k},1);
    end 
    [longestsessionlength,longestsessionIdx]=max(lengthofsession);
    longestsession=session{longestsessionIdx};
end 