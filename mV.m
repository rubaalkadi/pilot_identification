 for  ws=10:10:200
     clear acc_mV
 for overlap=1:ws-1 
 c=1;
 clear mVTest
 clear mVTruth
 for d=1:ws-overlap:size(ypredict,1)-ws
%  tic    
 mVTest(c)=majorityvote(ypredict(d:d+ws-1));
%  toc 
 mVTruth(c)=majorityvote(TestingLabel(d:d+ws-1)');
 c=c+1;
 end 
 
  acc_mV(overlap)=mean(mVTest==mVTruth);
   
 end 
 plot(acc_mV);
 pause
 hold off
acc_ws(ws/10)=max(acc_mV);
end
