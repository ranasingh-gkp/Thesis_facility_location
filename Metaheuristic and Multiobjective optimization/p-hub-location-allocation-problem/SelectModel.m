%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPAP110
% Project Title: Hub Location Allocation using PSO in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function model=SelectModel()

    Filter={'*.mat','MAT Files (*.mat)'
            '*.*','All Files (*.*)'};

    [FileName, FilePath]=uigetfile(Filter,'Select Model ...');
    
    if FileName==0
        model=[];
        return;
    end
    
    FullFileName=[FilePath FileName];

    data=load(FullFileName);
    
    model=data.model;

end