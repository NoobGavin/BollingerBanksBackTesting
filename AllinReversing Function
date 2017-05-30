function [record,Summary]=AllinReversingfunction(Price,Dateee,n,UpperFactor,LowerFactor)
% All in reversing trading strategy & calculate trading table
N=length(Price);
mu=zeros(N-n+1,1);
volatility=zeros(N-n+1,1);
Upperband=zeros(N-n+1,1);
Lowerband=zeros(N-n+1,1);
for i=n:N
    mu(i-n+1)=sum(Price(i-n+1:i))/n;
    volatility(i-n+1)=sqrt(sum((Price(i-n+1:i)-mu(i-n+1)).^2)/n);
    Upperband(i-n+1)=mu(i-n+1)+UpperFactor*volatility(i-n+1);
    Lowerband(i-n+1)=mu(i-n+1)-LowerFactor*volatility(i-n+1);
end
% plot(Date(N-n+1:-1:1),Price(N-n+1:-1:1),Date(N-n+1:-1:1),Upperband(end:-1:1),Date(N-n+1:-1:1),Lowerband(end:-1:1))
%%
% Set initial status
record=[];
tm=0;
tmm=zeros(1,11);
Capital=100000000;
if Price(N-n+1)>Upperband(N-n+1)
    Status=-1;
    size=Capital/Price(N-n+1);
    tmp=[N-n+1,Dateee(N-n+1),Price(N-n+1),tm,tm,Status,size];
    record=[record;tmp];
elseif Price(N-n+1)<Lowerband(N-n+1)
    Status=1;
    size=Capital/Price(N-n+1);
    tmp=[N-n+1,Dateee(N-n+1),Price(N-n+1),tm,tm,Status,size];
    record=[record;tmp];
elseif Price(N-n+1)<Upperband(N-n+1) && Price(N-n+1)>Lowerband(N-n+1)
    Status=0;
end
%% Trading
for i=N-n+1:-1:1
    if Price(i)>Upperband(i)&& Status==0
        Status=-1;
        size=Capital/Price(i);
        tmp=[i,Dateee(i),Price(i),tm,tm,Status,size];
        record=[record;tmp];
    elseif Price(i)<Lowerband(i)&& Status==0
        Status=1;
        size=Capital/Price(i);
        tmp=[i,Dateee(i),Price(i),tm,tm,Status,size];
        record=[record;tmp];
    elseif Price(i)<Lowerband(i)&& Status==-1
        record(end,4:5)=[Dateee(i),Price(i)];
        change=(record(end,3)-record(end,5))*record(end,7);
        record(end,8)=change;
        cumulative=sum(record(:,8));
        record(end,9)=cumulative;
        record(end,10)=change/Capital*100;
        maxreturn=(record(end,3)-min(Price(i:record(end,1))))*record(end,7)/Capital*100;
        minreturn=(record(end,3)-max(Price(i:record(end,1))))*record(end,7)/Capital*100;
        record(end,11)=maxreturn;
        record(end,12)=minreturn;
        [MaxDD,DDlength,RecoveryfromDD,RecoveryPeriod,MaxIncs,MIlength]=Maxfunction(Price(record(end,1):-1:i),Status);
        record(end,13:18)=[MaxDD*100,DDlength,RecoveryfromDD,RecoveryPeriod,MaxIncs*100,MIlength];
        % open a new position
        Status=1;
        Capital=Capital+record(end,8);
        size=Capital/Price(i);
        tmp=[i,Dateee(i),Price(i),tm,tm,Status,size,tmm];
        record=[record;tmp];
    elseif Price(i)>Upperband(i)&& Status==1
        record(end,4:5)=[Dateee(i),Price(i)];
        change=(record(end,5)-record(end,3))*record(end,7);
        record(end,8)=change;
        cumulative=sum(record(:,8));
        record(end,9)=cumulative;
        record(end,10)=change/Capital*100;
        maxreturn=(max(Price(i:record(end,1)))-record(end,3))*record(end,7)/Capital*100;
        minreturn=(min(Price(i:record(end,1)))-record(end,3))*record(end,7)/Capital*100;
        record(end,11)=maxreturn;
        record(end,12)=minreturn;
        [MaxDD,DDlength,RecoveryfromDD,RecoveryPeriod,MaxIncs,MIlength]=Maxfunction(Price(record(end,1):-1:i),Status);
        record(end,13:18)=[MaxDD*100,DDlength,RecoveryfromDD,RecoveryPeriod,MaxIncs*100,MIlength];
        % open a new position
        Status=-1;
        Capital=Capital+record(end,8);
        size=Capital/Price(i);
        tmp=[i,Dateee(i),Price(i),tm,tm,Status,size,tmm];
        record=[record;tmp];
    end
    if i==1
        % close trading postion
        record(end,4:5)=[Dateee(i),Price(i)];
        change=record(end,6)*(record(end,5)-record(end,3))*record(end,7);
        record(end,8)=change;
        cumulative=sum(record(:,8));
        record(end,9)=cumulative;
        record(end,10)=change/Capital*100;
        if Status==-1
           maxreturn=(record(end,3)-min(Price(i:record(end,1))))*record(end,7)/Capital*100;
           minreturn=(record(end,3)-max(Price(i:record(end,1))))*record(end,7)/Capital*100;
           record(end,11)=maxreturn;
           record(end,12)=minreturn;
           [MaxDD,DDlength,RecoveryfromDD,RecoveryPeriod,MaxIncs,MIlength]=Maxfunction(Price(record(end,1):-1:i),Status);
           record(end,13:18)=[MaxDD*100,DDlength,RecoveryfromDD,RecoveryPeriod,MaxIncs*100,MIlength];
        elseif Status==1
           maxreturn=(max(Price(i:record(end,1)))-record(end,3))*record(end,7)/Capital*100;
           minreturn=(min(Price(i:record(end,1)))-record(end,3))*record(end,7)/Capital*100;
           record(end,11)=maxreturn;
           record(end,12)=minreturn;
           [MaxDD,DDlength,RecoveryfromDD,RecoveryPeriod,MaxIncs,MIlength]=Maxfunction(Price(record(end,1):-1:i),Status);
           record(end,13:18)=[MaxDD*100,DDlength,RecoveryfromDD,RecoveryPeriod,MaxIncs*100,MIlength];
        end
    end
end
% Summary Table
longindex=find(record(:,6)==1);
shortindex=find(record(:,6)==-1);
long=length(longindex);
short=length(shortindex);
total=long+short;
longP_L=sum(record(longindex,8));
shortP_L=sum(record(shortindex,8));
duration=[];

for i=1:total-1
    sub=record(i,1)-record(i+1,1);
    duration=duration+sub;
end
Ave_duration=duration/total;
profitindex= record(:,8)>0;
lossindex= record(:,8)<0;
ProfitFactor=sum(record(profitindex,8))/sum(record(lossindex,8));
Return=record(:,8)./(record(:,3).*record(:,7));
r=0.01;
sigma=std(Return);
Sharpe=(mean(Return)-r)/sigma;
returnindex=Return<0;
sigmaa=std(Return(returnindex));
Sortino=(mean(Return)-r)/sigmaa;
Winning=length(profitindex)/length(record(:,1))*100;
Lossing=length(lossindex)/length(record(:,1))*100;
Dindex=find(max(record(:,13))==record(:,13));
Uindex=find(max(record(:,17))==record(:,17));
Summary=[n,UpperFactor,LowerFactor,record(end,8),long,short,total,record(end,9),...
    record(end,9)/100000000*100,longP_L,shortP_L,ProfitFactor,Sharpe,...
    Sortino,record(end,9)/100000000*100,max(record(:,11)),min(record(:,12)),Winning,...
    Lossing,record(Dindex,13),record(Dindex,14),record(Dindex,15),record(Dindex,16),...
    record(Uindex,17),record(Uindex,18)];
end        
