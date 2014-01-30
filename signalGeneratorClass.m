classdef signalGeneratorClass
    %signalGeneratorClass Generate signals for analysis
    %   Creates signals expected to be used in the testing of analytical
    %   functions.  The goal is to expand the class to include the
    %   generation of simulated physiological signals (ECG, EEG).
    %
    %
    % Version: 0.1.04
    %
    % ---------------------------------------------
    % Dennis A. Dean, II, Ph.D
    %
    % Program for Sleep and Cardiovascular Medicine
    % Brigam and Women's Hospital
    % Harvard Medical School
    % 221 Longwood Ave
    % Boston, MA  02149
    %
    % File created: November 21, 2013
    % Last updated: November 21, 2013 
    %    
    % Copyright © [2012] The Brigham and Women's Hospital, Inc. THE BRIGHAM AND 
    % WOMEN'S HOSPITAL, INC. AND ITS AGENTS RETAIN ALL RIGHTS TO THIS SOFTWARE 
    % AND ARE MAKING THE SOFTWARE AVAILABLE ONLY FOR SCIENTIFIC RESEARCH 
    % PURPOSES. THE SOFTWARE SHALL NOT BE USED FOR ANY OTHER PURPOSES, AND IS
    % BEING MADE AVAILABLE WITHOUT WARRANTY OF ANY KIND, EXPRESSED OR IMPLIED, 
    % INCLUDING BUT NOT LIMITED TO IMPLIED WARRANTIES OF MERCHANTABILITY AND 
    % FITNESS FOR A PARTICULAR PURPOSE. THE BRIGHAM AND WOMEN'S HOSPITAL, INC. 
    % AND ITS AGENTS SHALL NOT BE LIABLE FOR ANY CLAIMS, LIABILITIES, OR LOSSES 
    % RELATING TO OR ARISING FROM ANY USE OF THIS SOFTWARE.
    %

    %---------------------------------------------------- Public Properties
    properties (Access = public)
        t
        y
        signalParam
        generatingFunction
        
        % Display parameters
        titleStr = '';
        figPosition = [];
        fids = [];
    end   
    %------------------------------------------------ Dependent Properties
    properties (Dependent = true)
    end
    %--------------------------------------------------- Private Properties
    properties (Access = protected)
    end       
    %------------------------------------------------------- Public Methods
    methods
        %------------------------------------------------------ Constructor
        function obj = signalGeneratorClass(varargin)
            
        end
        %--------------------------------------------------------- sinusoid
        function varargout = sinusoid(varargin)
            % Default values
            A = 100;      % Amplitude
            f = 1;        % Period (sec)
            SR = 256;     % Sampling Rate (Hz)
            D = 30;        % Signal Duration (sec)
            
            % Process input
            if nargin == 1 
                obj = varargin{1};
            elseif nargin == 5
                obj = varargin{1};
                A = varargin{2};
                f = varargin{3};
                SR = varargin{4};
                D = varargin{5};
            else
                fprintf('--- obj.sinusoid(A, T, SR, D)\n');
            end
            
            % Generate signal
            t = [0:1/SR:D-1/SR]';
            y = A*sin(t*2*pi*f);
            
            % Store signal
            obj.y = y;
            obj.t = t;
            signalParam.A = A;
            signalParam.f = f;
            signalParam.SR = SR;
            signalParam.D = D;
            generatingFunction = 'sinunsoid';
            obj.signalParam = signalParam;
            
            % Create function return
            varargout{1} = {};
            if nargout == 1
                varargout{1} = obj;
            elseif nargout == 2
                varargout{1} = t;
                varargout{2} = y;
             elseif nargout == 3
                varargout{1} = t;
                varargout{2} = y;
                varargout{3} = signalParam;
            end
            
            % Store object 
        end
        %------------------------------------------------------------- plot
        function obj = plot(varargin)
            %% Generate pletysmogrpahy pulse dip figure  
            % Include annotations if flags are set
            
            % Process input
            if nargin == 1
                % Set current object
                obj = varargin{1};
            elseif nargin == 2
                % Process input
                obj = varargin{1};
                figPosition = varargin{2};
                
                % Save figure position
                obj.figPosition = figPosition;
            end
            
            % Create figure ids
            if isempty(obj.figPosition)
                fid = figure('InvertHardcopy','off','Color',[1 1 1]);
            else
                fid = figure('InvertHardcopy','off','Color',[1 1 1],...
                    'Position', obj.figPosition);
            end
            obj.fids = [obj.fids;fid];
            
            % Plot data
            plot(obj.t, obj.y, 'LineWidth', 2);
            
            % Set axis properties
            set(gca,'LineWidth',2);
            set(gca,'FontWeight','bold');
            set(gca,'FontSize',14);
            box(gca,'on');
          
            
            % Redefine x axis
            v = axis();
            axis(v);

            % Annotate 
            title(obj.titleStr, 'FontWeight','bold','FontSize',14);
            ylabel('Amplitude', 'FontWeight','bold', 'FontSize',14);
            xlabel('Time (sec)', 'FontWeight','bold', 'FontSize',14);



        end
    end
    %---------------------------------------------------- Private functions
    methods (Access=protected)        
    end
    %------------------------------------------------- Dependent Properties
    methods
    end
    %------------------------------------------------- Dependent Properties
    methods(Static)
    end
end

