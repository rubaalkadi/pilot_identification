function [squeezedcell]=squeezecell(c)
    l=length(c);
    m=1;
    for i=1:l
        if ~isempty(c{i})
            squeezedcell(m)=c(i);
            m=m+1;
        end 
    end 
    squeezedcell=squeezedcell';
end 