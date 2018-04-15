clear;clc;
warning('off','all')
t = readtable('Sample Submission.csv');
tnew = t;
files_names = t.FileName;
scores = [];
for k= 1:size(files_names,1)
    fi_name = fullfile('test',files_names{k});
    im = rgb2gray(imread(fi_name));
    centers = round(sortrows(imfindcircles(im2bw(im(1000:end,:)),[35 50],'ObjectPolarity','dark')));
    v1 = centers(1,:)-centers(2,:);
    v2 = [-1,0];
    angle = atan2d(v1(1)*v2(2)-v1(2)*v2(1),v1(1)*v2(1)+v1(2)*v2(2));
    im= imrotate(im,-angle);
    imcomp = imcomplement(im);
    imcomp = imdilate(imcomp,strel('disk',8));
    imcomp = im2bw(imcomp,0.1);
    locs = [centers(1,2)+1000,centers(1,1)+100;
        centers(1,2)+1000,centers(1,1)+110;
        centers(1,2)+1000,centers(1,1)+120];
    filled= imfill(imcomp,locs);
    imcomp = imcomplement(filled);
    imcomp = imclose(imcomp,strel('rectangle',[1,20]));
    cc = bwconncomp(imcomp);
    s = regionprops(imcomp,'Area','BoundingBox');
    [~,ind] = max([s.Area]);
    bb = round(s(ind).BoundingBox);
    vert_edge = im(200:end-200,bb(1)-10:bb(1)+10);
    bw_vert_edge = edge(vert_edge,'canny');
    [H,theta,rho] = hough(bw_vert_edge);
    P = houghpeaks(H,1,'threshold',ceil(0.3*max(H(:))));
    lines = houghlines(bw_vert_edge,theta,rho,P,'FillGap',200,'MinLength',5);
    cornerx = lines(1).point1(1)+bb(1)-10;
    hor_edge = im(bb(2)-15:bb(2)+15,100:end-100);
    bw_hor_edge = edge(hor_edge,'canny');
    [H,theta,rho] = hough(bw_hor_edge);
    P = houghpeaks(H,1,'threshold',ceil(0.3*max(H(:))));
    lines = houghlines(bw_hor_edge,theta,rho,P,'FillGap',200,'MinLength',5);
    xy = [lines(1).point1; lines(1).point2];
    cornery = lines(1).point1(2)+bb(2)-15;
    cropped = imcrop(im,[cornerx,cornery,990-1,735-1]);
    cropped = imcomplement(cropped);
    st = 315;
    mid = 645;
    tmp = lines(1).point2(2)-lines(1).point1(2);
    im1 = cropped(60+round(1.8*tmp/3):end-50+round(1.0*tmp/3),95:st-50);
    im2 = cropped(60+round(2.8*tmp/3):end-50+round(1.0*tmp/3),st+105:mid-50);
    im3 = cropped(60+tmp:end-50+tmp,mid+105:end-65);
    mat1 = getPart(im1);    
    mat2 = getPart(im2);    
    mat3 = getPart(im3);
    %% Get student answers
    %%Get answers for part1
    score = getStudentScore(mat1,1);
    %%Get answers for part2
    score = score + getStudentScore(mat2,2);    
    %%Get answers for part3
    score = score + getStudentScore(mat3,3);
    fprintf('score = %d\n',score);
    scores = [scores,score];
end
finallcell = num2cell(scores');
tnew.Mark = finallcell;
writetable(tnew,'new3.csv','WriteRowNames',true);
