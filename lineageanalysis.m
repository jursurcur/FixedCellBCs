clear all
load('xfplineage.mat');    
%% Colony Finding
colony=struct('colonyx',0,'colonyy',0);
colony=repmat(colony,[size(xfpdata,2),1]);
for i=1:size(xfpdata,2)
    index=1;
    debug=1;
    tmpdist=[];
    for j=1:size(xfpdata(i).centroid,1)
        bcode=xfpdata(i).fid(j);
        ct=0;
        centroid={};
        for k=1:size(xfpdata(i).centroid,1)
            if isequal(bcode,xfpdata(i).fid(k)) &&...
                    cdist(xfpdata(i).centroid(j),xfpdata(i).centroid(k))<55 
                %Threshold 125 is based on a multiple of diameter
                %(currently 5*diameter of 25)
                tmpdist=[tmpdist cdist(xfpdata(i).centroid(j),xfpdata(i).centroid(k))];
                ct=ct+1;
                centroid(ct,1) = [struct2cell(xfpdata(i).centroid(k))]; 
            end
        end
        maxdist=max(tmpdist);
        tmp=cell2mat(centroid);
        tmpx=mean(tmp(:,1));
        tmpy=mean(tmp(:,2));
        debug=debug+1;
        if any(colony(i).colonyx==tmpx) &&...
                any(colony(i).colonyy==tmpy)
            continue
        else
        colony(i).barcode(index,1)=bcode;
        colony(i).cells(index,1)=ct;
        colony(i).centroids(index).value=tmp;        
        colony(i).colonyx(index,1) = tmpx;
        colony(i).colonyy(index,1) = tmpy;
        colony(i).maxdist(index,1) = maxdist;
        index=index+1;
        end    
    end
    t(i)=debug;
end
save('colonydata.mat','colony')   
%% Plotting of colonies
for i=1:1%size(colony,1)
    figure
    scatter(colony(i).colonyx,colony(i).colonyy,'*r')
    hold on
    viscircles([colony(i).colonyx colony(i).colonyy], colony(i).maxdist)
    hold off
end
for i=1:1%size(colony,1)
    figure
    for j=1:1%size(
    for j=1:size(colony(i).centroids(j))
        scatter(colony(i).centroids(j).value,'*r')
        hold on
    end
    viscircles([colony(i).colonyx colony(i).colonyy], colony(i).maxdist)
    hold off
end
   
                
                
        