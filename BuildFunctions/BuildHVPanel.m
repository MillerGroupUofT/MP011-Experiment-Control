% Build panel for high voltage control
function BuildHVPanel()

    % Load handles from base workspace
    handles = evalin('base','handles');
    
    % HV Panel
    handles.figGUI_panHV = uipanel(...
        'Title', 'High Voltage Power Supply', ...         
        'FontSize', 12, ...
        'FontName', handles.gui_textFontName, ...
        'BackgroundColor', handles.gui_panelBackgroundColor, ...  
        'BorderType', 'line', ...
        'BorderWidth', 1, ...
        'HighlightColor', [0.5 0.5 0.5], ...
        'Units', 'pixels', ...
        'Position', [10 480 400-1 230]...
        );
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Push button for start
    handles.figGUI_panHV_start = uicontrol(...
        'Parent', handles.figGUI_panHV, ...
        'Style', 'pushbutton', ...
        'String', 'Start', ...
        'FontName', handles.gui_textFontName, ...
        'Position', [10 170 70 30], ...
        'Callback', {@CallbackFunc_Pressbutton, {'HV', 'Start'}, []}...
        );

    % Push button for shutdown
    handles.figGUI_panHV_shutdown = uicontrol(...
        'Parent', handles.figGUI_panHV, ...
        'Style', 'pushbutton', ...
        'String', 'Shutdown', ...
        'FontName', handles.gui_textFontName, ...
        'Position', [10 130 70 30], ...
        'Callback', {@CallbackFunc_Pressbutton, {'HV', 'Shutdown'}, []}...
        );

    % Text (Arc)
    i = 10;
    j = 110;
    handles.figGUI_panHV_ArcStatus_txtArc = uicontrol(...
        'Parent', handles.figGUI_panHV, ...
        'Style', 'text', ...
        'String', 'Arc Detect', ...
        'FontName', handles.gui_textFontName, ...
        'BackgroundColor', handles.gui_panelBackgroundColor, ...  
        'Units', 'pixels', ...
        'Position', [i+20 j 60 15], ...
        'HorizontalAlignment', 'left'...
        );

    % Checkbox for arc detection status
    handles.figGUI_panHV_ArcStatus = uicontrol(...
        'Parent', handles.figGUI_panHV, ...
        'Style', 'checkbox', ...
        'FontName', handles.gui_textFontName, ...
        'BackgroundColor', 'white', ...            
        'Units', 'pixels',...
        'Position', [i j 17 15], ...
        'HorizontalAlignment', 'center', ...
        'Callback', {@CallbackFunc_Pressbutton, {'HV', 'Arc detection'}, []}...
        );

    % Text (Autoconditioning)
    handles.figGUI_panHV_AutoStatus_txtAuto = uicontrol(...
        'Parent', handles.figGUI_panHV, ...
        'Style', 'text', ...
        'String', 'Condition', ...
        'FontName', handles.gui_textFontName, ...
        'BackgroundColor', handles.gui_panelBackgroundColor, ...
        'Units', 'pixels', ...
        'Position', [i+20 j-20 60 15], ...
        'HorizontalAlignment', 'left'...
        );

    % Checkbox for autoconditioning
    handles.figGUI_panHV_AutoStatus = uicontrol(...
        'Parent', handles.figGUI_panHV, ...
        'Style', 'checkbox', ...
        'FontName', handles.gui_textFontName, ...
        'BackgroundColor', 'white', ...            
        'Units', 'pixels',...
        'Position', [i j-20 17 15], ...
        'HorizontalAlignment', 'center', ...
        'Callback',{@CallbackFunc_Pressbutton, {'HV', 'Autoconditioning'}, []} ...
        );

    % Text (COM)
    handles.figGUI_panHV_COMStatus_txtCOM = uicontrol(...
        'Parent', handles.figGUI_panHV, ...
        'Style', 'text', ...
        'String', 'COM', ...
        'FontName', handles.gui_textFontName, ...
        'BackgroundColor', handles.gui_panelBackgroundColor, ...  
        'Units', 'pixels', ...
        'Position', [5 28 30 15], ...
        'HorizontalAlignment', 'left'...
        );

    % Edit text box for stage COM status
    handles.figGUI_panHV_COMStatus = uicontrol(...
        'Parent', handles.figGUI_panHV, ...
        'Style', 'edit',...
        'String', '?',...
        'FontName', handles.gui_textFontName, ...
        'BackgroundColor', 'yellow',...
        'Units', 'pixels',...
        'Position', [12 10 15 15],...
        'HorizontalAlignment', 'center'...
        );

    % Edit text box for camera COM status
    handles.figGUI_panHV_comStatus = uicontrol(...
        'Parent', handles.figGUI_panHV, ...
        'Style', 'edit', ...
        'FontName', handles.gui_textFontName, ...
        'String', handles.camera_comStatus, ...
        'BackgroundColor', handles.gui_panelBackgroundColor, ...
        'Units', 'pixels', ...
        'Position', [30+5 10 180 15], ...
        'HorizontalAlignment', 'left'...
        );

    % Nominal Voltage
    i = 10;
    j = 50;
    handles.figGUI_panHV_NomVoltagetext = uicontrol(...
        'Parent', handles.figGUI_panHV, ...
        'Style', 'text', ...
        'String', 'Nominal V', ...
        'FontName', handles.gui_textFontName, ...
        'BackgroundColor', handles.gui_panelBackgroundColor, ...
        'Units', 'pixels', ...
        'Position',[i j+20 70 15], ...
        'HorizontalAlignment', 'left' ...
        );
    
    handles.figGUI_panHV_NomVoltage = uicontrol(...
        'Parent', handles.figGUI_panHV, ...
        'Style', 'edit', ...
        'String',num2str(handles.nominalVoltage,'%.3f'), ...
        'BackgroundColor', 'white', ...
        'Units', 'pixels', ...
        'Position',[i j 45 15], ...
        'Callback', {@CallbackFunc_Pressbutton, {'HV', 'Nominal voltage'}, []}...
        );

    % Buttons to change nominal voltage
    handles.figGUI_panHV_NomVoltageAdd = uicontrol(...
        'Parent', handles.figGUI_panHV, ...
        'Style', 'pushbutton',...
        'String', '+',...
        'Position',[i+50 j+7 15 15],...
        'Callback', {@CallbackFunc_Pressbutton, {'HV', 'Nominal voltage add'}, []} ...
        );
    
    handles.figGUI_panHV_NomVoltageMinus = uicontrol(...
        'Parent', handles.figGUI_panHV, ...
        'Style', 'pushbutton', ...
        'String', '-', ...
        'Position',[i+50 j-8 15 15], ...
        'Callback', {@CallbackFunc_Pressbutton, {'HV', 'Nominal voltage minus'}, []} ...
        );
    
    % Present voltage and current
    i = 200;
    j = 192;
    l = lines(2);
    handles.figGUI_panHV_Currenttxt = uicontrol(...
        'Parent', handles.figGUI_panHV, ...
        'Style', 'text', ...
        'String', sprintf('I (%sA)', char(181)) , ...
        'Units', 'pixels', ...
        'FontName', handles.gui_textFontName, ...
        'ForegroundColor', l(1, :), ...
        'BackgroundColor', handles.gui_panelBackgroundColor, ...
        'Position',[i j 40 15], ...
        'HorizontalAlignment', 'left' ...
        );
    
    handles.figGUI_panHV_Current = uicontrol(...
        'Parent', handles.figGUI_panHV, ...
        'Style', 'edit', ...
        'String', '', ...
        'BackgroundColor', 'white',...
        'Units', 'pixels', ...
        'Position', [i+32 j 45 15] ...
        );
    
    i = i + 100;
    handles.figGUI_panHV_Voltagetxt = uicontrol(...
        'Parent', handles.figGUI_panHV, ...
        'Style', 'text', ...
        'String', 'V (kV)', ...
        'Units', 'pixels', ...
        'FontName', handles.gui_textFontName, ...
        'ForegroundColor', l(2, :), ...
        'BackgroundColor', handles.gui_panelBackgroundColor, ...
        'Position',[i j 40 15], ...
        'HorizontalAlignment', 'left' ...
        );

    handles.figGUI_panHV_Voltage = uicontrol(...
        'Parent', handles.figGUI_panHV, ...
        'Style', 'edit', ...
        'String', '', ...
        'BackgroundColor', 'white', ...
        'Units', 'pixels', ...
        'Position',[i+36 j 44 15] ...
        );
        
    %%%%%%%%%
        
        % Plotting commands
        handles.Current(:,1) =  transpose(...
        (datenum(clock) - (handles.numTimePointsPlot - 1)*(handles.QueryPeriod / (24 * 3600))):...
        (handles.QueryPeriod / (24 * 3600)):...
        datenum(clock)...
        );
    
        handles.Current(:,2) = handles.nominalCurrent*ones(handles.numTimePointsPlot,1);
        handles.Voltage(:,1) = handles.Current(:,1);
        handles.Voltage(:,2) = handles.nominalVoltage*ones(handles.numTimePointsPlot,1);
    
        [plotTicksCurrent] = GeneratePlotTicks(handles.minCurrentDivision,...
        reshape(handles.Current(:,2:3),2*handles.numTimePointsPlot,1));
        [plotTicksVoltage] = GeneratePlotTicks(handles.minVoltageDivision,...
        reshape(handles.Voltage(:,2:3),2*handles.numTimePointsPlot,1));
        
        % Plot effective data
        [handles.Axes, handles.GraphCurrent, handles.GraphVoltage] = plotyy(...
            handles.Current(:,1), handles.Current(:,3),...
            handles.Voltage(:,1), handles.Voltage(:,3),...
            'plot', 'plot');

        % Modify axis limits
        i = [115, 50, 250, 135];
        set(handles.Axes(1), ...
            'Units', 'pixels', ...
            'Position', i, ...
            'Fontsize', 8, ...
            'Parent', handles.figGUI_panHV, ...
            'XLim', [handles.Current(1,1), handles.Current(end,1)], ...
            'YLim', [plotTicksCurrent(1), plotTicksCurrent(end)], ...
            'XTick', linspace(handles.Current(1,1), handles.Current(end,1),10), ...
            'YTick', plotTicksCurrent, ...
            'XTickLAbelRotation', 0.0 ...
            );
         
        set(handles.Axes(2), ...
            'Units', 'pixels', ...
            'Position', i, ...
            'Fontsize', 8, ...
            'Parent', handles.figGUI_panHV, ...
            'XLim', [handles.Voltage(1,1), handles.Voltage(end,1)], ...
            'YLim', [plotTicksVoltage(1), plotTicksVoltage(end)], ...
            'XTick', linspace(handles.Voltage(1,1), handles.Voltage(end,1),10), ...
            'YTick', plotTicksVoltage ...
            );
        
        % set(get(handles.Axes(1), 'Ylabel'), 'String', 'Current (\muA)');
        % set(get(handles.Axes(2), 'Ylabel'), 'String', 'Voltage (kV)');
        % set(get(handles.Axes(1), 'Xlabel'), 'String', 'Time');
        set(handles.Axes(1), 'YTickLabel', sprintf('%.1f\n', plotTicksCurrent));
        set(handles.Axes(2), 'YTickLabel', sprintf('%.1f\n', plotTicksVoltage));

        % Plot nominal data
        set(handles.Axes, 'NextPlot', 'add');
        handles.GraphNominalCurrent = plot(handles.Axes(1), handles.Current(:,1), handles.Current(:,2), ':');
        handles.GraphNominalVoltage = plot(handles.Axes(2), handles.Voltage(:,1), handles.Voltage(:,2), ':');
        
        % Set date format for x-axis
        datetick(handles.Axes(1), 'x', 'MM:SS', 'keeplimits');
        datetick(handles.Axes(2), 'x', 'MM:SS', 'keeplimits');
        
    % Initialize GUI

    % Permanently disable status edit boxes
    set(handles.figGUI_panHV_comStatus, 'Enable', 'off');
    set(handles.figGUI_panHV_ArcStatus, 'Enable', 'off');
    set(handles.figGUI_panHV_AutoStatus, 'Enable', 'off');
    set(handles.figGUI_panHV_start, 'Enable', 'off');
    set(handles.figGUI_panHV_shutdown, 'Enable', 'off');
    % set(handles.figGUI_panHV_emergencyshutdown, 'Enable', 'off');
    set(handles.figGUI_panHV_NomVoltage, 'Enable', 'off');
    set(handles.figGUI_panHV_NomVoltageAdd, 'Enable', 'off');
    set(handles.figGUI_panHV_NomVoltageMinus, 'Enable', 'off');

    % Save handles in base workspace
    assignin('base','handles',handles)

end
