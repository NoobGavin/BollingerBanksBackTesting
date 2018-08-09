function [MaxDD,DDlength,RecoveryfromDD,RecoveryPeriod,MaxIncs,MIlength]=Maxfunction(Data,Status)
% Calculate MaxDD, DDlength,Recovery period from the low point, and the
% total Recovery Period.
% Also calculate Max Increase and Max Increase Length.
n=length(Data);
switch Status
    case 1
        % long position
        % MaxDD
        MaxData = Data(1);
        MaxDD=0;
        MaxIndex=[];
        MaxDDIndex =zeros(2,1);
        for i = 1:n
            MaxData = max(MaxData, Data(i));
            if MaxData == Data(i);
                MaxIndex =[MaxIndex;i];
            elseif MaxData ~=Data(i) 
                DD = (MaxData - Data(i))/MaxData;
                if DD > MaxDD
                    MaxDD = DD;
		            MaxDDIndex(1,1) = MaxIndex(end);
		            MaxDDIndex(2,1) = i;
                end
            end
        end
        DDlength=MaxDDIndex(2)-MaxDDIndex(1);
        location=find(MaxIndex==MaxDDIndex(1,1));
        if MaxDD==0
            RecoveryPeriod=0;
            RecoveryfromDD=0;
        elseif location==length(MaxIndex)
            RecoveryPeriod=-1;
            RecoveryfromDD=-1;
        else
            RecoveryPeriod=MaxIndex(find(MaxIndex==MaxDDIndex(1,1))+1)-MaxDDIndex(1,1);
            RecoveryfromDD=RecoveryPeriod-DDlength;
        end
        % Calculate Max Increase
        MinDataa=Data(1);
        MaxIncs=0;
        MaxIndexx=1;
        MaxIncsIndex=zeros(2,1);
        for i = 1:n
            MinDataa = min(MinDataa, Data(i));
            if MinDataa == Data(i);
                MaxIndexx =i;
            elseif MinDataa ~=Data(i) 
                Incs = (Data(i) - MinDataa)/MinDataa;
                if Incs > MaxIncs
                    MaxIncs = Incs;
		            MaxIncsIndex(1,1) = MaxIndexx;
		            MaxIncsIndex(2,1) = i;
                end
            end
        end
        MIlength=MaxIncsIndex(2,1)-MaxIncsIndex(1,1);
        
        
    case -1
        % short position
        % MaxDD
        MinData = Data(1);
        MaxDD=0;
        MaxIndex=[];
        MaxDDIndex =zeros(2,1);
        for i = 1:n
            MinData = min(MinData, Data(i));
            if MinData == Data(i);
                MaxIndex =[MaxIndex;i];
            elseif MinData ~=Data(i) 
                DD = (Data(i) - MinData)/((Data(1)-MinData)+Data(1));
                if DD > MaxDD
                    MaxDD = DD;
		            MaxDDIndex(1,1) = MaxIndex(end);
		            MaxDDIndex(2,1) = i;
                end
            end
        end
        DDlength=MaxDDIndex(2)-MaxDDIndex(1);
        location=find(MaxIndex==MaxDDIndex(1,1));
        if MaxDD==0
            RecoveryPeriod=0;
            RecoveryfromDD=0;
        elseif location==length(MaxIndex)
            RecoveryPeriod=-1;
            RecoveryfromDD=-1;
        else
            RecoveryPeriod=MaxIndex(location+1)-MaxDDIndex(1,1);
            RecoveryfromDD=RecoveryPeriod-DDlength;
        end
        % Calculate Max Increase
        MaxDataa=Data(1);
        MaxIncs=0;
        MaxIndexx=1;
        MaxIncsIndex=zeros(2,1);
        for i = 1:n
            MaxDataa = max(MaxDataa, Data(i));
            if MaxDataa == Data(i);
                MaxIndexx =i;
            elseif MaxDataa ~=Data(i) 
                Incs = (MaxDataa-Data(i))/(Data(1)-(MaxDataa-Data(1)));
                if Incs > MaxIncs
                    MaxIncs = Incs;
		            MaxIncsIndex(1,1) = MaxIndexx;
		            MaxIncsIndex(2,1) = i;
                end
            end
        end
        MIlength=MaxIncsIndex(2,1)-MaxIncsIndex(1,1);
end       
end
