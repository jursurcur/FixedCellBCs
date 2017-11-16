FileTif='merge_f0001.tif';
InfoImage=imfinfo(FileTif);
mImage=InfoImage(1).Width
nImage=InfoImage(1).Height
NumberImages=length(InfoImage)
 
FinalImage=zeros(nImage,mImage,NumberImages,'uint16');
for i=1:NumberImages
   FinalImage(:,:,i)=imread(FileTif,'Index',i);
end