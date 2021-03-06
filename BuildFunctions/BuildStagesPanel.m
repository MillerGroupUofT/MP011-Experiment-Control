
% Build panel for stage control
function BuildStagesPanel()

    % Get shared data
    %handles = getappdata(hFigData, 'handles');

    % Load handles from base workspace
    handles = evalin('base','handles');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Build GUI objects
    for(i = 1:5)

        j = 10 + (i-1)*199;

        % Panel
        handles.figGUI_panStages(i) = uipanel(...
            'Title', sprintf('%s Stage', handles.stages_name{i}), ...         
            'FontSize',12, ...
            'FontName', handles.gui_textFontName, ...        
            'BackgroundColor', handles.gui_panelBackgroundColor, ...
            'BorderType', 'line', ...
            'BorderWidth', 1, ...
            'HighlightColor', [0.5 0.5 0.5], ...
            'Units', 'pixels', ...
            'Position',[j 245 200 230]...
            );

        % Text (Operation Mode)
        handles.figGUI_panStage_opMode_txt(i) = uicontrol(...
            'Parent', handles.figGUI_panStages(i), ...
            'Style', 'text', ...
            'FontName', handles.gui_textFontName, ...        
            'BackgroundColor', handles.gui_panelBackgroundColor, ...
            'String', 'Operation Mode:', ...
            'Units', 'pixels', ...
            'Position', [15 190 120 15], ...
            'HorizontalAlignment', 'left'...
            );

        % Pop-up menu for operation mode
        handles.figGUI_panStages_opMode(i) = uicontrol(...
            'Parent', handles.figGUI_panStages(i), ...
            'Style', 'popup', ...
            'FontName', handles.gui_textFontName, ...        
            'BackgroundColor', handles.gui_panelBackgroundColor, ...
            'String', {'Destination', 'Displacement'}, ...
            'Position', [20 175 95 15], ...
            'HorizontalAlignment', 'center', ...
            'Callback', {@CallbackFunc_Pressbutton, {'Stages', sprintf('set operation %d', i)}, []}...
            );

        % Pop-up menu for direction of motion
        handles.figGUI_panStages_dir(i) = uicontrol(...
            'Parent', handles.figGUI_panStages(i), ...
            'Style', 'popup', ...
            'FontName', handles.gui_textFontName, ...            
            'BackgroundColor', handles.gui_panelBackgroundColor, ...
            'String', {'Forward', 'Reverse'}, ...
            'Position', [120 175 70 15], ...
            'HorizontalAlignment', 'center', ...
            'Callback', {@CallbackFunc_Pressbutton, {'Stages', sprintf('set direction %d', i)}, []}...
            );

        % Text (Value)
        handles.figGUI_panStages_value_txt1(i) = uicontrol(...
            'Parent', handles.figGUI_panStages(i), ...
            'Style', 'text', ...
            'BackgroundColor', handles.gui_panelBackgroundColor, ...            
            'FontName', handles.gui_textFontName, ...    
            'String', 'Value:', ...
            'Units', 'pixels', ...
            'Position', [10 145 35 15], ...
            'HorizontalAlignment', 'left'...
            );
        
        handles.figGUI_panStages_value(i) = uicontrol(...
            'Parent', handles.figGUI_panStages(i), ...
            'Style', 'edit', ...
            'FontName', handles.gui_editFontName, ...            
            'BackgroundColor', handles.gui_panelBackgroundColor, ...        
            'String', handles.stages_value{i}, ...
            'Units', 'pixels', ...
            'Position', [50 145 40 15], ...
            'HorizontalAlignment', 'center', ...
            'Callback', {@CallbackFunc_Pressbutton, {'Stages', sprintf('set distance %d', i)}, []}...
            );

        handles.figGUI_panStages_value_txt2(i) = uicontrol(...
            'Parent', handles.figGUI_panStages(i), ...
            'Style', 'text', ...
            'FontName', handles.gui_textFontName, ...    
            'BackgroundColor', handles.gui_panelBackgroundColor, ...            
            'String', sprintf('%sm', char(181)), ...
            'Units', 'pixels', ...
            'Position', [92 145 22 15], ...
            'HorizontalAlignment', 'left'...
            );

        % Push button to start motion (Go)
        handles.figGUI_panStages_buttGo(i) = uicontrol(...
            'Parent', handles.figGUI_panStages(i), ...
            'Style', 'pushbutton', ...
            'FontName', handles.gui_textFontName, ...            
            'String', 'Go', ...
            'Position', [125 143 30 20], ...
            'Callback', {@CallbackFunc_Pressbutton, {'Stages', sprintf('start motion %d', i)}, []}...
            );

        % Push button to stop motion
        handles.figGUI_panStages_buttStop(i) = uicontrol(...
            'Parent', handles.figGUI_panStages(i), ...
            'Style', 'pushbutton', ...
            'FontName', handles.gui_textFontName, ...            
            'String', 'Stop', ...
            'Position', [158 143 30 20], ...
            'Callback', {@CallbackFunc_Pressbutton, {'Stages', sprintf('stop motion %d', i)}, []}...
            );


        % Text (Current position)
        handles.figGUI_panStages_currentPos_txt1(i) = uicontrol(...
            'Parent', handles.figGUI_panStages(i), ...
            'Style', 'text', ...
            'FontName', handles.gui_textFontName, ...    
            'String', 'Current Position:', ...
            'BackgroundColor', handles.gui_panelBackgroundColor, ...    
            'Units', 'pixels', ...
            'Position', [12 115 95 15], ...
            'HorizontalAlignment', 'left'...
            );
        handles.figGUI_panStages_currentPos(i) = uicontrol(...
            'Parent', handles.figGUI_panStages(i), ...
            'Style', 'text', ...
            'FontName', handles.gui_editFontName, ...            
            'BackgroundColor', handles.gui_panelBackgroundColor, ...        
            'String', num2str(handles.stages_currentPos{i}), ...
            'Units', 'pixels', ...
            'Position', [105 115 55 15], ...
            'HorizontalAlignment', 'center'...
            );
        handles.figGUI_panStages_currentPos_txt2(i) = uicontrol(...
            'Parent', handles.figGUI_panStages(i), ...
            'Style', 'text', ...
            'FontName', handles.gui_textFontName, ...    
            'BackgroundColor', handles.gui_panelBackgroundColor, ...            
            'String', sprintf('%sm', char(181)), ...
            'Units', 'pixels', ...
            'Position', [162 115 26 16], ...
            'HorizontalAlignment', 'left'...
            );

        % Text (Target position)
        handles.figGUI_panStages_targetPos_txt1(i) = uicontrol(...
            'Parent', handles.figGUI_panStages(i), ...
            'Style', 'text', ...
            'FontName', handles.gui_textFontName, ...    
            'String', 'Target Position:', ...
            'BackgroundColor', handles.gui_panelBackgroundColor, ...            
            'Units', 'pixels', ...
            'Position', [0 95 95 15], ...
            'HorizontalAlignment', 'right'...
            );
        
        handles.figGUI_panStages_targetPos(i) = uicontrol(...
            'Parent', handles.figGUI_panStages(i), ...
            'Style', 'text', ...
            'FontName', handles.gui_editFontName, ...            
            'BackgroundColor', handles.gui_panelBackgroundColor, ...
            'String', num2str(handles.stages_targetPos{i}), ...
            'Units', 'pixels', ...
            'Position', [105 95 55 15], ...
            'HorizontalAlignment', 'center'...
            );
        
        handles.figGUI_panStages_targetPos_txt2(i) = uicontrol(...
            'Parent', handles.figGUI_panStages(i), ...
            'Style', 'text', ...
            'FontName', handles.gui_textFontName, ...    
            'BackgroundColor', handles.gui_panelBackgroundColor, ...            
            'String', sprintf('%sm', char(181)), ...
            'Units', 'pixels', ...
            'Position', [162 95 26 16], ...
            'HorizontalAlignment', 'left'...
            );

        % Push button to connect stage server
        handles.figGUI_panStages_buttConn(i) = uicontrol(...
            'Parent', handles.figGUI_panStages(i), ...
            'Style', 'pushbutton', ...
            'FontName', handles.gui_textFontName, ...            
            'String', 'Connect', ...
            'Position', [40 35 70 30], ...
            'Callback', {@CallbackFunc_Pressbutton, {'Stages', sprintf('connect %d', i)}, []}...
            );
            

        % Push button to disconnect from stage server
        handles.figGUI_panStages_buttDiscon(i) = uicontrol(...
            'Parent', handles.figGUI_panStages(i), ...
            'Style', 'pushbutton', ...
            'FontName', handles.gui_textFontName, ...            
            'String', 'Disconnect', ...
            'Position', [120 35 70 30], ...
            'Callback', {@CallbackFunc_Pressbutton, {'Stages', sprintf('disconnect %d', i)}, []}...
            );


        % Text (COM)
        handles.figGUI_panStages_COMStatus_txtCOM(i) = uicontrol(...
            'Parent', handles.figGUI_panStages(i), ...
            'Style', 'text', ...
            'String', 'COM', ...
            'FontName', handles.gui_textFontName, ...
            'BackgroundColor', handles.gui_panelBackgroundColor, ...  
            'Units', 'pixels', ...
            'Position', [10 60 30 15], ...
            'HorizontalAlignment', 'left'...
            );

        % Edit text box for stage COM status
        handles.figGUI_panStages_COMStatus(i) = uicontrol(...
            'Parent', handles.figGUI_panStages(i), ...
            'Style', 'edit',...
            'String', '?',...
            'FontName', handles.gui_textFontName, ...
            'BackgroundColor', 'yellow',...
            'Units', 'pixels',...
            'Position', [17 42 15 15],...
            'HorizontalAlignment', 'center'...
            );

        % Edit text box for stage status
        handles.figGUI_panStages_comStatus(i) = uicontrol(...
            'Parent', handles.figGUI_panStages(i), ...
            'Style', 'edit', ...
            'FontName', handles.gui_textFontName, ...            
            'BackgroundColor', handles.gui_panelBackgroundColor, ...
            'String', handles.stages_comStatus{i}, ...
            'BackgroundColor', handles.gui_panelBackgroundColor, ...
            'Units', 'pixels', ...
            'Position', [10 10 180 15], ...
            'HorizontalAlignment', 'left'...
            );
        
        if(i == 2)
            set(handles.figGUI_panStages_dir(i), 'String', {'Down', 'Up'})
        end
        
        if(i == 5)
            set(handles.figGUI_panStages_value_txt2(i),'String','deg')
            set(handles.figGUI_panStages_currentPos_txt2(i),'String','deg')
            set(handles.figGUI_panStages_targetPos_txt2(i),'String','deg')
        end

    end
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Initialize GUI
    for(i = 1:5)

        % Disable edits
        set(handles.figGUI_panStages_COMStatus(i), 'Enable', 'off');
        set(handles.figGUI_panStages_comStatus(i), 'Enable', 'off');
        set(handles.figGUI_panStages_buttGo(i), 'Enable', 'off');
        set(handles.figGUI_panStages_buttStop(i), 'Enable', 'off');
        set(handles.figGUI_panStages_opMode(i), 'Enable', 'off');
        set(handles.figGUI_panStages_dir(i), 'Enable', 'off');
        set(handles.figGUI_panStages_value(i), 'Enable', 'off');
        set(handles.figGUI_panStages_currentPos(i), 'Enable', 'off');
        set(handles.figGUI_panStages_targetPos(i), 'Enable', 'off'); 
        
        % Disable control buttons
        set(handles.figGUI_panStages_buttConn(i), 'Enable', 'off');
        set(handles.figGUI_panStages_buttDiscon(i), 'Enable', 'off');

    end 

    % Enable connection
    
    for(i = 1:5)
        set(handles.figGUI_panStages_buttConn(i), 'Enable', 'on');
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Save handles in base workspace
    assignin('base','handles',handles)
end