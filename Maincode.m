# BollingerBanksBackTesting
[Data,~,Raw]=xlsread('BA_Bollinger.xlsx',7,'A1:E1281');
Date=datetime(Raw(2:end,1),'Convertfrom','excel','Format','MM/dd/yyyy');
Datee=Raw(2:end,1);
Dateee=datenum(Datee);
Price=Data(:,4);
% MV=20, Upper and Lower Std Factor=2
[record,Summary]=AllinReversingfunction(Price,Dateee,20,2,2);
% organize table
Name={'EntryDate','EntryPrice','ExitDate','ExitPrice','Position','Size',...
    'TradePL','CumulativePL','TotalReturn','MaxReturn','MinReturn','MaxDD',...
    'MaxDDlength','RecoveryfromDD','MaxDDRecoverylength','MaxIncrease','MaxIncreaseLength'};
Table=table(datestr(record(:,2)),record(:,3),datestr(record(:,4)),record(:,5),...
    record(:,6),record(:,7),record(:,8),record(:,9),record(:,10),record(:,11),...
    record(:,12),record(:,13),record(:,14),record(:,15),record(:,16),...
    record(:,17),record(:,18),'VariableName',Name);

%% Changing MA and UpperFactor& LowerFactor
% All in Reversing
Table_Allin={};
Summary_Allin=[];
for i=19:21
    for ii=1.9:0.1:2.1
        for iii=1.9:0.1:2.1
            [record,Summary]=AllinReversingfunction(Price,Dateee,i,ii,iii);
            Table_Allin=[Table_Allin;record];
            Summary_Allin=[Summary_Allin;Summary];
        end
    end
end
Namee={'BollPeriod','BollUp','BollDown','LastTrade','Long','Short',...
    'Total','TotalPL','TotalReturn','LongPL','ShortPL',...
    'ProfitFactor','Sharpe','Sortino','TotalR','MaxReturn','MinReturn',...
    'Winning','Losing','MaxDD','MaxDDlength','RecoveryfromDD',...
    'MaxDDRecoveryPeriod','MaxIncrease','MaxIncreaseLength'};
Allin_Table=table(Summary_Allin(:,1),Summary_Allin(:,2),Summary_Allin(:,3),...
    Summary_Allin(:,4),Summary_Allin(:,5),Summary_Allin(:,6),Summary_Allin(:,7),...
    Summary_Allin(:,8),Summary_Allin(:,9),Summary_Allin(:,10),Summary_Allin(:,11),...
    Summary_Allin(:,12),Summary_Allin(:,13),Summary_Allin(:,14),Summary_Allin(:,15),...
    Summary_Allin(:,16),Summary_Allin(:,17),Summary_Allin(:,18),Summary_Allin(:,19),...
    Summary_Allin(:,20),Summary_Allin(:,21),Summary_Allin(:,22),Summary_Allin(:,23),...
    Summary_Allin(:,24),Summary_Allin(:,25),'VariableName',Namee);
% Break Out
Table_Breakout={};
Summary_Breakout=[];
for i=19:21
    for ii=1.9:0.1:2.1
        for iii=1.9:0.1:2.1
            [record,Summary]=Breakoutfunction(Price,Dateee,i,ii,iii);
            Table_Breakout=[Table_Breakout;record];
            Summary_Breakout=[Summary_Breakout;Summary];
        end
    end
end
Breakout_Table=table(Summary_Breakout(:,1),Summary_Breakout(:,2),Summary_Breakout(:,3),...
    Summary_Breakout(:,4),Summary_Breakout(:,5),Summary_Breakout(:,6),Summary_Breakout(:,7),...
    Summary_Breakout(:,8),Summary_Breakout(:,9),Summary_Breakout(:,10),Summary_Breakout(:,11),...
    Summary_Breakout(:,12),Summary_Breakout(:,13),Summary_Breakout(:,14),Summary_Breakout(:,15),...
    Summary_Breakout(:,16),Summary_Breakout(:,17),Summary_Breakout(:,18),Summary_Breakout(:,19),...
    Summary_Breakout(:,20),Summary_Breakout(:,21),Summary_Breakout(:,22),Summary_Breakout(:,23),...
    Summary_Breakout (:,24),Summary_Breakout(:,25),'VariableName',Namee);
%%
% Optimal parameter
% Here I choose Total Return, Profit Factor, Sharpe Ratio,Sortino Ratio,
% MaxDD, MaxIncrease as the weighted parameter.
Optimal_Allin=zeros(length(Summary_Allin),1);
Optimal_Allin(:,1)=Summary_Allin(:,9)+Summary_Allin(:,13)*10+Summary_Allin(:,14)*100+Summary_Allin(:,15)*100-Summary_Allin(:,21)*10+Summary_Allin(:,24)*10;
Opti_Allin=max(Optimal_Allin);
Optimal_Breakout=zeros(length(Summary_Breakout),1);
Optimal_Breakout(:,1)=Summary_Breakout(:,9)+Summary_Breakout(:,13)*10+Summary_Breakout(:,14)*100+Summary_Breakout(:,15)*100-Summary_Breakout(:,21)*10+Summary_Breakout(:,24)*10;
Opti_Breakout=max(Optimal_Breakout);
%%
% 3D plot
z=cell(1,3);
x=[19 20 21];
y=[1.9 2.0 2.1];
for i=1:3
Tem=[];
    for j=1+i-1:3:25+i-1
    Tem=[Tem,Summary_Allin(j,8)];
    end
z{i}=[Tem(1:3);Tem(4:6);Tem(7:9)];
figure(i)% figure 1,2,3 corresponding to Upper=1.9,2.0,2.1
surf(x,y,z{i})
end
zz=cell(1,3);
for i=1:3
Tem=[];
    for j=1+i-1:3:25+i-1
    Tem=[Tem,Summary_Breakout(j,8)];
    end
zz{i}=[Tem(1:3);Tem(4:6);Tem(7:9)];
figure(i+3)
surf(x,y,zz{i})% figure 1,2,3 corresponding to Upper=1.9 2.0 2.1
end
