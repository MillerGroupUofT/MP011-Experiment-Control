
% Build panel for shutter control
function BuildShuttersPanel()

    % Get shared data
    %handles = getappdata(hFigData, 'handles');

    % Load handles from base workspace
    handles = evalin('base','handles');


	% Panel
	handles.figGUI_panShutters = uipanel(...
        'Title', 'Optical Shutters', ...    		
        'FontSize', 12, ...
        'FontName', handles.gui_textFontName, ...
        'BackgroundColor', handles.gui_panelBackgroundColor, ...  
        'BorderType', 'line', ...
        'BorderWidth', 1, ...
        'HighlightColor', [0.5 0.5 0.5], ...
        'Units', 'pixels', ...
        'Position', [810-4 480 200 230]...
        );
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Text (COM)
    handles.figGUI_panShutters_txtCOM = uicontrol(...
        'Parent', handles.figGUI_panShutters, ...
        'Style', 'text', ...
        'String', 'COM', ...
        'FontName', handles.gui_textFontName, ...
        'BackgroundColor', handles.gui_panelBackgroundColor, ...  
        'Units', 'pixels', ...
        'Position', [85 192 50 15], ...
        'HorizontalAlignment', 'left'...
        );

    % Text (Control)
    handles.figGUI_panShutters_txtControl = uicontrol(...
        'Parent', handles.figGUI_panShutters, ...
        'Style', 'text', ...
        'String', 'Control', ...
        'FontName', handles.gui_textFontName, ...
        'BackgroundColor', handles.gui_panelBackgroundColor, ...  
        'Units', 'pixels', ...
        'Position', [140 192 50 15], ...
        'HorizontalAlignment', 'left'...
        );

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    for(i = 1:3)

        j = 175 - (i-1)*20;

        % Checkbox for shutter
        handles.figGUI_panShutters_check(i) = uicontrol(...
            'Parent', handles.figGUI_panShutters, ...
            'Style', 'checkbox', ...
            'FontName', handles.gui_textFontName, ...
            'String', sprintf('Shutter %d', i), ...
            'BackgroundColor', 'white', ...            
            'Position', [10 j 80 15]...
            ); 
 

        % COM status box for shutter
        handles.figGUI_panShutters_COMStatus(i) = uicontrol(...
            'Parent',handles.figGUI_panShutters, ...
            'Style','edit',...
            'String','?',...
            'FontName', handles.gui_textFontName, ...
            'BackgroundColor','yellow',...
            'Units','pixels',...
            'Position',[90 j 15 15],...
            'HorizontalAlignment','center'...
            );

        % Shutter status box for shutter
        handles.figGUI_panShutters_ShutStatus(i) = uicontrol(...
            'Parent',handles.figGUI_panShutters, ...
            'Style','edit',...
            'String','?',...
            'FontName', handles.gui_textFontName, ...
            'BackgroundColor','yellow',...
            'Units','pixels',...
            'Position',[120 j 15 15],...
            'HorizontalAlignment','center'...
            );

        % Push button for shutter control (open)
        handles.figGUI_panShutters_buttO(i) = uicontrol(...
            'Parent', handles.figGUI_panShutters, ...
            'Style', 'pushbutton', ...
            'String', 'O', ...
            'FontName', handles.gui_textFontName, ...
            'Position', [140 j-2 20 20], ...
            'Callback', {@CallbackFunc_Pressbutton, {'Shutters', sprintf('open shutter %d', i)}, []}...
            );
        
        % Push button for shutter control (close)
        handles.figGUI_panShutters_buttX(i) = uicontrol(...
            'Parent', handles.figGUI_panShutters, ...
            'Style', 'pushbutton', ...
            'FontName', handles.gui_textFontName, ...
            'String', 'X', ...
            'Position', [162 j-2 20 20], ...
            'Callback', {@CallbackFunc_Pressbutton, {'Shutters', sprintf('close shutter %d', i)}, []}...
            );

    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Push button for shutters server connection
    handles.figGUI_panShutters_buttConn = uicontrol(...
        'Parent', handles.figGUI_panShutters, ...
        'Style', 'pushbutton', ...
        'String', 'Connect', ...
        'FontName', handles.gui_textFontName, ...
        'Position', [40 35 70 30], ...
        'Callback', {@CallbackFunc_Pressbutton, {'Shutters', 'connect shutters'}, []}...
        );

%             'Callback', {@CallbackFunc_Shutters, 'connect shutters'}...
    
    % Push button to disconnect from shutters server
    handles.figGUI_panShutters_buttDiscon = uicontrol(...
        'Parent', handles.figGUI_panShutters, ...
        'Style', 'pushbutton', ...
        'String', 'Disconnect', ...
        'FontName', handles.gui_textFontName, ...
        'Position', [120 35 70 30], ...
        'Callback', {@CallbackFunc_Pressbutton, {'Shutters', 'disconnect shutters'}, []}...
        );
    
%             'Callback', {@CallbackFunc_Shutters, 'disconnect shutters'}...

    % Edit text box for shutters COM status
    handles.figGUI_panShutters_shuttersCOMStatus = uicontrol(...
        'Parent', handles.figGUI_panShutters, ...
        'Style', 'edit', ...
        'String', handles.shutters_comStatus, ...
        'FontName', handles.gui_textFontName, ...
        'BackgroundColor', 'white', ...
        'Units', 'pixels', ...
        'Position', [10 10 180 15], ...
        'HorizontalAlignment', 'left'...
        );

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Initialize GUI
    set(handles.figGUI_panShutters_buttConn, 'Enable', 'on');
    set(handles.figGUI_panShutters_buttDiscon, 'Enable', 'off');
    set(handles.figGUI_panShutters_shuttersCOMStatus, 'Enable', 'off');

    for(i = 1:3)

        % Checkmark all shutters
        set(handles.figGUI_panShutters_check(i), 'Value', 1);
        
        % Disable control buttons
        set(handles.figGUI_panShutters_COMStatus(i), 'Enable', 'off');
        set(handles.figGUI_panShutters_ShutStatus(i), 'Enable', 'off');
        set(handles.figGUI_panShutters_buttO(i), 'Enable', 'off');
        set(handles.figGUI_panShutters_buttX(i), 'Enable', 'off');
    end

    % Save handles in base workspace
    assignin('base','handles',handles)

end







