function score = getStudentScore(mat,part_no)
%%get student score given a matrix for a part of the image
model_ans = [2,3,1,1,4,1,3,3,1,3,1,2,3,3,2,1,4,2,3,2,4,3,4,2,4,3,4,4,2,3,2,2,4,3,2,3,2,3,3,1,2,2,3,3,2];
score=0;
for i=1:4:60
    q_i = [mat(i);mat(i+1);mat(i+2);mat(i+3)];
    [mx,mx_idx] = max(q_i); 
    good =1;
    if (mx < 0.1)
        good = 0;
    end
    for j=1:4
        if  (q_i(j)/mx > 0.65)  && (j ~= mx_idx)  
            good =0;
            break;
        end
    end
    if good & (mx_idx == model_ans(ceil(i/4)+(part_no-1)*15)) 
        score = score +1;
    end
end