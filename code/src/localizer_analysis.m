% (C) Copyright 2019 bidspm developers

%% analyze localizers

clear;
clc;

bidspmDir=fullfile(fileparts(mfilename('fullpath')),'..', 'lib','bidspm');
addpath(fullfile(fileparts(mfilename('fullpath')),'..', 'lib','bidspm'))
bidspm();

bids_dir = fullfile(fileparts(mfilename('fullpath')),'..', '..','inputs','raw');
output_dir = fullfile(fileparts(mfilename('fullpath')),'..', '..','outputs','derivatives');

% subject_label = {'001','002''003','004','005','006','007','008','009','010','011','013',...
%       '014','015','016','017','pil001','pil002','pil004','pil005'};% , '012',

%% preprocess = STC, spatial normalization and smooth FWHM = 6 (default)
% A single task must be specified for preprocessing
% this will run preprocessing on all subjects. for a  %'participant_label', {subject_label}, ...

taskList = {'visualLocalizer2','tactileLocalizer2','mtmstLocalizer'};
for iTask = 1: length(taskList)
    taskName = taskList(iTask);
    bidspm(bids_dir, output_dir, 'subject', ... 
            'action', 'preprocess', ...
            'space', {'IXI549Space'}, ...
            'fwhm', 6,...
            'task', {'visualLocalizer2'})
end

%% subject - level stats for localizers
% run the stats at subject-level
% action = 'stats' -> runs model specification / estimation, contrast computation, display results
% action = 'contrasts'-> runs contrast computation, display results
% action = 'results'-> displays results

taskList = {'visualLocalizer2','tactileLocalizer2','mtmstLocalizer'};
for iTask = 1: length(taskList)
    taskName = taskList(iTask);
    model_file = fullfile(output_dir, 'models', strcat('model-', char(taskName),'_smdl.json'));
    % define the results to be saved as output
    results = defaultResultsStructure();% do we need this and what does it do?
    results.nodeName = 'subject_level';
    results.name = {'motion_gt_static'};
    results.MC =  'none';
    results.p = 0.01;
    results.k = 0;
    results.png = true();
    results.csv = true();
    results.binary = true; % what is this?
    results.montage.do = true();
    results.montage.slices = -12:4:60;
    results.montage.orientation = 'axial';
    results.montage.background = struct('suffix', 'T1w', ...
                                        'desc', 'preproc', ...
                                        'modality', 'anat');                                                             
    opt.results = results;

    bidspm(bids_dir, output_dir, 'subject', ...
           'action', 'stats', ...
           'preproc_dir', preproc_dir, ...
           'model_file', model_file,...
           'task', {taskName},...
           'space', {'IXI549Space'}, ...
           'fwhm', 6,...
           'ignore', {'qa','concat'},...
           'concatenate', false,...
           'options', opt);
end
   
%% group- level analyses for the localizers

taskList = {'visualLocalizer2','tactileLocalizer2','mtmstLocalizer'};
for iTask = 1: length(taskList)
    taskName = taskList(iTask);
    model_file = fullfile(output_dir, 'models', strcat('model-', char(taskName),'_smdl.json'));
    % define the results to be saved as output
    results = defaultResultsStructure();% do we need this and what does it do?
    results.nodeName = 'subject_level';
    results.name = {'motion_gt_static'};
    results.MC =  'none';
    results.p = 0.01;
    results.k = 0;
    results.png = true();
    results.csv = true();
    results.binary = true; % what is this?
    results.montage.do = true();
    results.montage.slices = -12:4:60;
    results.montage.orientation = 'axial';
    results.montage.background = struct('suffix', 'T1w', ...
                                        'desc', 'preproc', ...
                                        'modality', 'anat');                                                             
    opt.results = results;

    bidspm(bids_dir, output_dir, 'dataset', ...
           'action', 'stats', ...
           'preproc_dir', preproc_dir, ...
           'model_file', model_file,...
           'task', {taskName},...
           'space', {'IXI549Space'}, ...
           'fwhm', 6,...
           'ignore', {'qa','concat'},...
           'concatenate', false,...
           'options', opt);
end