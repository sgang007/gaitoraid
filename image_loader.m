function img_array = image_loader(model,m)
%where model is model number to be used and m is the number of images
%required
%Script for loading Mobo image files.
%files must be kept in the following directory structure:
%./
% -MoboBgImages
% -moboBgSub
%  -04002
%  -04006
%   -ball
%   -fastWalk
%    -vr03_7
%     -sil10001.pbm
%     -sil10002.pbm
%       .
%       .
%     -sil10340.pbm
%    -vr05_7
%    -vr07_7
%    -vr13_7
%    -vr16_7
%    -vr17_7
%   -incline
%   -slowWalk
%  -04011

%m=100;
database = 'moboBgSub'
%model = '04006'
action = 'fastWalk'
camera = 'vr03_7'
sprintf('Loading images...');
img_array = zeros(640, 486, m);

for k=1:m,
    if k<10
        pbmfileName=sprintf('sil1000%d.pbm',k);
    else if k<100
        pbmfileName = sprintf('sil100%d.pbm',k);
    else
        pbmfileName = sprintf('sil10%d.pbm',k);
        end
    end
    fullFileName=fullfile('Mobo',database,model,action,camera, pbmfileName);
    if exist(fullFileName,'file')
        img_array(:,:,k)=imread(fullFileName);
    else
        warningMessage = sprintf('Warning: Image File does not exist:\n%s',fullFileName);
        uiwait(warndlg(warningMessage));
    end
end
    
            
end