%% cluster based rois

% this script reads the .mat file and the base space image that you select
% manually to create rois
% this script uses som and marsbar

% step 0:
% follow the methods here to manually find and save your clusters
% marsbar and som save a .mat file
% https://marsbar-toolbox.github.io/tutorial/define.html

% step 1:
% we can open marsbar and choose the base space manually if the following two lines dont work
% open marsbar 
% marsbar('on');
% % image used for used for referencing 
% baseImage = fullfile(fileparts(mfilename('fullpath')),'..', '..','..','derivatives','cpp_spm-stats','sub-001','stats','task-visualLocalizer2_FWHM-6','beta_0001.nii'); 
% MARS.OPTIONS.spacebase = baseImage;

% step2:
subjectList={'sub-001','sub-002','sub-003','sub-004','sub-005','sub-006','sub-007','sub-008',...
             'sub-009','sub-010','sub-011','sub-013','sub-014','sub-015','sub-016','sub-017',...
             'sub-pil004','sub-pil005'}; % sub-pil001 and sub-pil002 have no cluster/localizer

opt.roi = {'lMT','lMst','lhMT','rMT','rMst','rhMT' };%{'lhMT','rhMT','lS1','lPC', 'rPC', 'lMTt', 'rMTt'};

for iSub = 1:length(subjectList)
    subID= subjectList(iSub);

    % where to read the rois
    opt.inputDir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','cluster-roi','subjectCluster',char(subID));
    inputMaskDir = opt.inputDir;
    
    % where to save the new masks with new reference image
    opt.outputDir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives','cluster-roi','subjectCluster',char(subID));
    if ~exist(opt.outputDir)
           mkdir(opt.outputDir)
    end
    outputMaskDir=opt.outputDir;
    
    cd (inputMaskDir)
    
    % Get all .mat files in the current folder = inputMaskDir 
    % doing this so that the code doesnt break when there are no rois in a
    % subject. Otherwise the following loop woth iROI is good.
   
    roifiles = dir('*.mat');
    for iFile=1:length(roifiles)
        
       roiFileName=roifiles(iFile).name; %input roi
       f=roiFileName(1:end-8); % taking the name for the output roi from input roi
       roiOutputName = strcat(f,'.nii'); %name for output roi
       
       cd (outputMaskDir)
       mars_rois2img(char(fullfile(inputMaskDir,roiFileName)),char(fullfile(outputMaskDir,roiOutputName)))  
    end
    
%     for iRoi = 1:length(opt.roi)
%         roiLabel= opt.roi(iRoi);
%         
%         if strcmp(roiLabel,'lMT')==1||strcmp(roiLabel,'lMst')==1||strcmp(roiLabel,'lhMT')==1
%             hemiLabel = 'L';
%         elseif strcmp(roiLabel,'rMT')==1||strcmp(roiLabel,'rMst')==1||strcmp(roiLabel,'rhMT')==1
%             hemiLabel = 'R';
%         end
%         
%         roiFileName = strcat(subID,'_hemi-',hemiLabel,'_space-MNI_label-',roiLabel,'_roi.mat');
%         roiOutputName = strcat(subID,'_hemi-',hemiLabel,'_space-MNI_label-',roiLabel,'.nii');
% 
%         cd (outputMaskDir)
%         mars_rois2img(char(fullfile(inputMaskDir,roiFileName)),char(fullfile(outputMaskDir,roiOutputName)))
%     end
end
