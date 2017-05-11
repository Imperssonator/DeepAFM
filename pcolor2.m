function pc = pcolor2(M)

figure;
pc=pcolor(M);
pc.EdgeAlpha=0;
ax=gca;
ax.YDir='reverse';
axis equal

end