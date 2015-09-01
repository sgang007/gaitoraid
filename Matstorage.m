 
addpath(genpath(pwd));
myFolder ='C:\Users\Antariksha\Desktop\mobo\moboBgSub\04002\ball\vr03_7';
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end
filePattern = fullfile(myFolder, '*.pbm');
jpegFiles = dir(filePattern);
 result = cell(1,400);
for k = 1:length(jpegFiles)
  baseFileName = jpegFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  imageArray= imread(fullFileName);
  result{k} = imageArray;
end
save gait2go.mat result;