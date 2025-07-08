% MATLAB script to visualize kernel trick in SVM - super clean version

% 1. Create smaller 2D non-linearly separable dataset
theta = rand(40,1) * 2 * pi;
r_inner = 0.5 + 0.05*rand(20,1);
r_outer = 1.0 + 0.05*rand(20,1);

x_inner = [r_inner.*cos(theta(1:20)), r_inner.*sin(theta(1:20))];
x_outer = [r_outer.*cos(theta(21:end)), r_outer.*sin(theta(21:end))];

% Labels
y_inner = ones(20,1);    % Class +1
y_outer = -ones(20,1);   % Class -1

X = [x_inner; x_outer];
Y = [y_inner; y_outer];

% 2. Create the figure with white background
fig = figure('Color', 'w'); % White background
subplot(1,2,1);
hold on;
for i = 1:length(Y)
    if Y(i) == 1
        text(X(i,1), X(i,2), '+', 'FontSize',16, 'HorizontalAlignment','center', 'Color','k', 'FontWeight','bold');
    else
        text(X(i,1), X(i,2), '-', 'FontSize',16, 'HorizontalAlignment','center', 'Color','k', 'FontWeight','bold');
    end
end
viscircles([0 0], 0.75, 'LineStyle','--','Color','k', 'LineWidth',1);
axis equal;
xlabel('x');
ylabel('y');
axis off; % no ticks/grid
% No title here

% 3. Apply a simple kernel transform (e.g., r^2 feature)
r2 = sum(X.^2,2); % New feature: radius squared

% 4. Plot the 3D transformed data
subplot(1,2,2);
hold on;
for i = 1:length(Y)
    if Y(i) == 1
        text(X(i,1), X(i,2), r2(i), '+', 'FontSize',24, 'HorizontalAlignment','center', 'Color','k', 'FontWeight','bold');
    else
        text(X(i,1), X(i,2), r2(i), '-', 'FontSize',24, 'HorizontalAlignment','center', 'Color','k', 'FontWeight','bold');
    end
end
% Plot the separating plane
[xplane, yplane] = meshgrid(linspace(-1.5,1.5,10));
zplane = 0.75^2 * ones(size(xplane)); % Plane at r^2 = (0.75)^2
surf(xplane, yplane, zplane, 'FaceAlpha',0.2, 'EdgeColor','none', 'FaceColor','green');
axis equal;
xlabel('x');
ylabel('y');
zlabel('r^2');
axis off; % no ticks/grid
view(-30,30);
% No title here

% 5. Save figure as high-res PNG
exportgraphics(fig, 'svm_kernel_trick_clean.png', 'BackgroundColor','white', 'Resolution',300);
