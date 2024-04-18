function [breakedcell]=breaksamples(samples,sc)
    lS=size(samples,1);
    j=1;
    while (lS-sc)>=0 % take every x sec as an observation
       breakedcell{j,1}=samples(1:sc,:)';
       
        samples(1:sc,:)=[]; % remove the taken sec from the original vector 
        lS=lS-sc;
        j=j+1;
    end
end 