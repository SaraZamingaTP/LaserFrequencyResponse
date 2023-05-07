function PlotParams(isLegend, PlotInput, isXLim, isYLim, XLimit, YLimit, ...
    XLabelStr, YLabelStr, Xvector, Yvector)

%legend settings
if isLegend
    
    legend(PlotInput,'NumColumns', 1,'fontsize',25,'interpreter','latex');
    box off
    legend boxoff
    
end 

%axis settings
xlabel(XLabelStr,'fontsize',30,'interpreter','latex');
ylabel(YLabelStr,'fontsize',30,'interpreter','latex');
set(gca,'xtick', Xvector,'ytick', Yvector,'xminortick', 'on', ...
    'yminortick', 'on','FontSize', 25,...
        'TickLabelInterpreter','latex', 'TickDir', 'in') %Ticks

if isXLim 
    xlim(XLimit);
end 
if isYLim
    ylim(YLimit);
end 

% Figure settings
ScreenSize=get(groot,'ScreenSize');
ScreenSize=ScreenSize(3:4);
Height=600;
Width=1200;
set(gcf, 'color', 'w') ;
set(gca,'GraphicsSmoothing','on', ...
    'Position', [(ScreenSize(1)-Width)/2 (ScreenSize(2)-Height)/2 Width Height]);


end