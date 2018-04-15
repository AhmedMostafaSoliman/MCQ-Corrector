function v1 = getPart(im)
Y =  [30,70,110,150,190,230,270,310,350,390,430,470,510,550,590];
radius = 11;
[imcenters, ~] = imfindcircles(imdilate(im,strel('disk',1)),[8 20],'Sensitivity',0.86);
imcenters = sortrows(imcenters,2);    
q = zeros(60,2);
imit = 1;
for i = 1:15
    yi = Y(i);
    while imit <= size(imcenters,1) && abs(imcenters(imit,2)-yi) <= 15
        if abs(imcenters(imit,1) - 30) <= 15
            q((i-1)*4+1,:) = imcenters(imit,:);
        elseif abs(imcenters(imit,1) - 70) <= 15
            q((i-1)*4+2,:) = imcenters(imit,:);
        elseif abs(imcenters(imit,1) - 110) <= 15
            q((i-1)*4+3,:) = imcenters(imit,:);
        else
            q((i-1)*4+4,:) = imcenters(imit,:);
        end
        imit = imit + 1;
    end        
    for j = 1:4
        if q((i-1)*4+j,1) == 0
            for k = 1 :4 
                if q((i-1)*4+k,1) ~= 0
                    q((i-1)*4+j,1) = q((i-1)*4+k,1)-(k-j)*40;
                    q((i-1)*4+j,2) = q((i-1)*4+k,2);
                    break;
                end
            end
        end
    end        
end
v1 = zeros(60,1);
for i = 1:60
    [rNum,cNum,~] = size(im);
    [xx,yy] = ndgrid((1:rNum)-q(i,2),(1:cNum)-q(i,1));
    all_px = im((xx.^2 + yy.^2) < radius^2);
    v1(i) = sum(all_px) / (255*size(all_px,1));
end