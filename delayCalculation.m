%function [P_1, P234, P_5, P_6, P_7, P_8, P_9, P_10, P_11, P_12, bn] = Delay_Calculation(T_AUTH_CUAS, T_AUTH_USS, T_ID_valid, T_ID_Read, T_timeout_inerdict, T_Area, T_resp_delay, T_AUTH_DB, T_time, T_timeout, T_ID_DB, T_verifyID)
%function [delay, P_1,P234,P_5,P_6,P_7,P_8,P_9,P_10,P_11,P_12,bn]= Delay_Calculation(T_AUTH_CUAS,T_AUTH_USS,T_ID_valid,T_ID_Read,T_timeout_inerdict,T_Area,T_resp_delay,T_AUTH_DB,T_time,T_timeout,T_ID_DB,T_verifyID)
% P_1,P_2,P_3,P_4,P_5,P_6,P_7,P_8,P_9,P_10,P_11,P_12
clear all

T_AUTH_CUAS =1;
T_AUTH_USS =1;
T_ID_valid=0.1;
T_ID_Read= 0.1;
T_timeout_inerdict=0;
T_Area=0.1;
T_resp_delay=2;
T_AUTH_DB=1.2;
T_time=0.1;
T_timeout=3;
T_ID_DB=1.2;
T_verifyID=0.5;

% protocol 1 outcomes 
T_P1_C1= T_AUTH_CUAS +2* T_resp_delay + T_AUTH_USS + T_timeout ;
T_P1_C2= T_AUTH_CUAS +3* T_resp_delay + T_AUTH_USS ;
T_P1_C3_4= T_AUTH_CUAS +2* T_AUTH_USS + T_AUTH_CUAS +3* T_resp_delay ;
T_P1_C5=3* T_AUTH_CUAS +2* T_AUTH_USS + T_AUTH_CUAS + T_AUTH_CUAS +5* T_resp_delay ;
% protocol 2 outcomes 
T_P2_C1= T_AUTH_CUAS + T_resp_delay ;
T_P2_C2= T_AUTH_CUAS + T_resp_delay + T_AUTH_USS  + T_timeout_inerdict ;
T_P2_C3= T_AUTH_CUAS + T_resp_delay + T_AUTH_USS ;
% protocol 3 outcomes 

T_P3_C1= T_AUTH_CUAS + T_resp_delay ;
T_P3_C2= T_AUTH_CUAS + T_resp_delay + T_AUTH_USS  + T_timeout_inerdict ;
T_P3_C3= T_AUTH_CUAS + T_resp_delay + T_AUTH_USS ;
% protocol 4 outcomes 
T_P4_C1= 2*T_AUTH_CUAS  + T_resp_delay;
T_P4_C2= T_AUTH_CUAS +T_resp_delay + T_AUTH_USS +T_AUTH_CUAS;
% protocol 5 outcomes 
T_P5_C1= 2*T_AUTH_CUAS  + T_resp_delay;
T_P5_C2= T_AUTH_CUAS +T_resp_delay + T_AUTH_USS +T_AUTH_CUAS;
% protocol 6 outcomes 
T_P6_C1=2* T_AUTH_CUAS + T_resp_delay ;
T_P6_C2= T_AUTH_CUAS + T_resp_delay + T_AUTH_USS  + T_timeout_inerdict ;
T_P6_C3= T_resp_delay +2* T_AUTH_CUAS ;

% protocol 7 outcomes 
T_P7_C1= T_AUTH_CUAS + T_resp_delay +2* T_AUTH_USS + T_timeout + T_timeout_inerdict ;
T_P7_C2_3= T_AUTH_CUAS +3* T_resp_delay +3* T_AUTH_USS + T_timeout_inerdict ;
T_P7_C3=2* T_AUTH_USS +3* T_resp_delay +2* T_AUTH_CUAS ;

% protocol 8 
T_P8_C1= T_AUTH_CUAS + T_resp_delay +2* T_AUTH_USS + T_timeout + T_timeout_inerdict ;
T_P8_C2_3= T_AUTH_CUAS +3* T_resp_delay +3* T_AUTH_USS + T_timeout_inerdict ;
T_P8_C3=2* T_AUTH_USS +3* T_resp_delay +2* T_AUTH_CUAS ;

%path length

P_1=T_ID_Read  + T_AUTH_DB  ;
T_1= T_ID_Read  + T_AUTH_DB  +T_P1_C3_4 +T_AUTH_DB  + T_Area  + T_time  ;
P_2= T_ID_Read  + T_AUTH_DB  +T_P1_C1;
P_3= T_ID_Read  + T_AUTH_DB  +T_P1_C2;
P_4=2* T_ID_Read  +2* T_AUTH_DB  +T_P1_C5+max(T_P1_C1,T_P1_C2);
P234=max([P_2 P_3 P_4]);
P_5= T_ID_Read  + T_verifyID  ;
P_6= T_ID_Read  + T_verifyID  + T_ID_DB  + T_AUTH_DB  +T_P2_C1;
T_5= T_ID_Read  + T_verifyID  + T_ID_DB  + T_AUTH_DB  + T_P2_C3;
P_7= T_ID_Read  + T_AUTH_DB  +T_P1_C3_4;
P_8= T_ID_Read  + T_verifyID  + T_ID_DB  + T_AUTH_DB  +T_P2_C2;
T_2 =T_ID_Read  + T_verifyID  + T_ID_DB  + T_AUTH_DB+ T_P3_C1 + T_Area  + T_time;
T_2_2= T_ID_Read  + T_verifyID  + T_ID_DB  + T_AUTH_DB+ T_P3_C2 + T_ID_valid + T_AUTH_DB+T_Area + T_time;
P_9= T_ID_Read  + T_verifyID  + T_ID_DB  + T_ID_valid  + T_AUTH_DB +T_P4_C2 ;
T_6= T_ID_Read  + T_verifyID  + T_ID_DB  + T_ID_valid  + T_AUTH_DB  + T_P4_C1;
T_3 =T_ID_Read  + T_verifyID  + T_ID_DB  + T_AUTH_DB+ T_ID_valid + T_P5_C1 + T_Area  + T_time;
T_4= T_ID_Read  + T_verifyID  + T_ID_DB  + T_ID_valid  + T_AUTH_DB  +T_P6_C1;
T_7= T_ID_Read  + T_verifyID  + T_ID_DB  + T_ID_valid  + T_AUTH_DB  +T_P6_C3+ T_time;
P_10= T_ID_Read  + T_verifyID  + T_ID_DB  + T_ID_valid  + T_AUTH_DB  +T_P6_C2;
T_7_2= T_ID_Read  + T_verifyID  + T_ID_DB  + T_ID_valid  + T_AUTH_DB + T_Area +T_P7_C3+ T_time;
T_8_2= T_ID_Read  + T_verifyID  + T_ID_DB  + T_ID_valid  + T_AUTH_DB + T_Area +T_P8_C3+ T_time;

P_11= T_ID_Read  + T_verifyID  + T_ID_DB  + T_ID_valid  + T_AUTH_DB  + T_Area  + max( T_P7_C1,T_P7_C2_3) ;
P_12= T_ID_Read  + T_verifyID  + T_ID_DB  + T_ID_valid  + T_AUTH_DB  + T_Area  + T_time  + max( T_P8_C1,T_P8_C2_3);
T_7_c1= T_ID_Read  + T_verifyID  + T_ID_DB  + T_ID_valid  + T_AUTH_DB + T_Area +T_P7_C1+ T_time;
T_8_c1= T_ID_Read  + T_verifyID  + T_ID_DB  + T_ID_valid  + T_AUTH_DB + T_Area +T_P8_C1+ T_time;
T_coop=T_ID_Read  + T_verifyID  + T_ID_DB  + T_ID_valid  + T_AUTH_DB + T_Area + T_time;
for NoOfRandomDrones=100:100:1000

RandomDrones=round(rand(NoOfRandomDrones,10));

for i=1:NoOfRandomDrones
   if (~RandomDrones(i,1) && ~RandomDrones(i,5))
       delay(i)=P_1;
       proto(i)=0;
   elseif (~RandomDrones(i,1) && RandomDrones(i,5) && ~RandomDrones(i,9))
       delay(i)=P234;
       proto(i)= 1;
   elseif (RandomDrones(i,1) && ~RandomDrones(i,2))
       delay(i)=P_5;
       proto(i)= 0;
   elseif (RandomDrones(i,1) && RandomDrones(i,2) && ~RandomDrones(i,3)&& ~RandomDrones(i,5) && ~RandomDrones(i,10))
       delay(i)=P_6;
       proto(i)=2;
   elseif (~RandomDrones(i,1) && RandomDrones(i,5) && RandomDrones(i,9) && RandomDrones(i,8))
       delay(i)=P_7;
       proto(i)=1;
   elseif (RandomDrones(i,1) && RandomDrones(i,2) && ~RandomDrones(i,3) && ~RandomDrones(i,5) && RandomDrones(i,10))
       delay(i)= P_8;
       proto(i)=2;
   elseif (RandomDrones(i,1) && RandomDrones(i,2) && RandomDrones(i,3) && ~RandomDrones(i,4) && ~RandomDrones(i,5) && ~RandomDrones(i,10))
       delay(i)=P_9;
       proto(i)= 4;
   elseif (RandomDrones(i,1) && RandomDrones(i,2) && RandomDrones(i,3) && RandomDrones(i,4) && ~RandomDrones(i,5) && ~RandomDrones(i,10))
       delay(i)= P_10;
       proto(i)= 6;
   elseif (RandomDrones(i,1) && RandomDrones(i,2) && RandomDrones(i,3) && RandomDrones(i,4) && RandomDrones(i,5) && ~RandomDrones(i,6) && RandomDrones(i,8) && RandomDrones(i,9))
       delay(i)=P_11;
       proto(i)=7;
   elseif (RandomDrones(i,1) && RandomDrones(i,2) && RandomDrones(i,3) && RandomDrones(i,4) && RandomDrones(i,5) && RandomDrones(i,6) && ~RandomDrones(i,7) && RandomDrones(i,8) && RandomDrones(i,9))
       delay(i)=P_12;
       proto(i)= 8;
       elseif (RandomDrones(i,1) && RandomDrones(i,2) && ~RandomDrones(i,3) && RandomDrones(i,5) )
       delay(i)=T_2;
       proto(i)= 3;
       elseif (~RandomDrones(i,1) && RandomDrones(i,5) && RandomDrones(i,9) && ~RandomDrones(i,8) )
       delay(i)=T_1;
       proto(i)= 1;
       elseif (RandomDrones(i,1) && RandomDrones(i,2) && RandomDrones(i,3) && ~RandomDrones(i,4) && ~RandomDrones(i,5) && RandomDrones(i,10))
       delay(i)=T_6;
       proto(i)= 4;
       elseif (RandomDrones(i,1) && RandomDrones(i,2) && RandomDrones(i,3) && ~RandomDrones(i,4) && RandomDrones(i,5))
       delay(i)=T_3;
       proto(i)= 5;
       elseif (RandomDrones(i,1) && RandomDrones(i,2) && RandomDrones(i,3) && RandomDrones(i,4) && ~RandomDrones(i,5) && ~RandomDrones(i,8) && ~RandomDrones(i,10))
       delay(i)=T_4;
       proto(i)= 6;
   elseif (RandomDrones(i,1) && RandomDrones(i,2) && RandomDrones(i,3) && RandomDrones(i,4) && RandomDrones(i,5) && ~RandomDrones(i,6) &&  ~RandomDrones(i,8) && RandomDrones(i,9))
       delay(i)=T_7_2;
       proto(i)= 7;
       elseif (RandomDrones(i,1) && RandomDrones(i,2) && RandomDrones(i,3) && RandomDrones(i,4) && RandomDrones(i,5) && RandomDrones(i,6) && ~RandomDrones(i,7) && ~RandomDrones(i,8) && RandomDrones(i,9))
       delay(i)=T_8_2;
       proto(i)= 8;
       elseif (RandomDrones(i,1) && RandomDrones(i,2) && RandomDrones(i,3) && RandomDrones(i,4) && RandomDrones(i,5) && RandomDrones(i,6) && ~RandomDrones(i,7) &&  ~RandomDrones(i,9))
       delay(i)=T_8_c1;
       proto(i)= 8;
       elseif (RandomDrones(i,1) && RandomDrones(i,2) && RandomDrones(i,3) && RandomDrones(i,4) && RandomDrones(i,5) && ~RandomDrones(i,6) && RandomDrones(i,9))
       delay(i)=T_7_c1;
       proto(i)= 7;
   elseif (RandomDrones(i,1) && RandomDrones(i,2) && RandomDrones(i,3) && RandomDrones(i,4) && RandomDrones(i,5) && RandomDrones(i,6) && RandomDrones(i,7) && RandomDrones(i,8) && RandomDrones(i,9) && RandomDrones(i,10))
        delay(i)=T_coop;
        proto(i)=0;
   else 
       delay (i) = NaN;
       proto(i)= 0;
   end
       

end    
hist(delay);
figure
% n=histcounts(proto,9);
% bar([0:8],n);
% i0=1;
% i1=1;
% i2=1;i3=1;i4=1;i5=1;i6=1;i7=1;i8=1;
% for drone=1:1000
%     if proto(drone)==0
%         prt0(i0)=delay(drone);
%         i0=i0+1;
%     elseif proto(drone)==1
%         prt1(i1)=delay(drone);
%         i1=i1+1;
%           elseif proto(drone)==2
%         prt2(i2)=delay(drone);
%         i2=i2+1;
%           elseif proto(drone)==3
%         prt3(i3)=delay(drone);
%         i3=i3+1;
%           elseif proto(drone)==4
%         prt4(i4)=delay(drone);
%         i4=i4+1;
%           elseif proto(drone)==5
%         prt5(i5)=delay(drone);
%         i5=i5+1;  
%     elseif proto(drone)==6
%         prt6(i6)=delay(drone);
%         i6=i6+1;
%           elseif proto(drone)==7
%         prt7(i7)=delay(drone);
%         i7=i7+1;
%           elseif proto(drone)==8
%         prt8(i8)=delay(drone);
%         i8=i8+1;
%     end   
% end 
% m0=nanmean(prt0);
% m1=mean(prt1);
% m2=mean(prt2);
% m3=mean(prt3);
% m4=mean(prt4);
% m5=mean(prt5);
% m6=mean(prt6);
% m7=mean(prt7);
% m8=mean(prt8);
% bar([0:8], [m0 m1 m2 m3 m4 m5 m6 m7 m8])
% 
% Delay{NoOfRandomDrones/100}=delay;
AvgDelay(NoOfRandomDrones/100)=nanmean(delay);
clear delay;
Proto{NoOfRandomDrones/100}=proto;
clear proto; 
end
bar([100:100:1000],AvgDelay);
m=nanmean(delay);
bn=max([P_1,P234,P_5,P_6,P_7,P_8,P_9,P_10,P_11,P_12]);