
import matlab.io.*;

%変数の初期設定------
size_default = [200, 200];
i = 0;
p = 0.5;%精度
label = blocks();

imA = imread('base_blocks\base_red_block.jpg');%白背景、回転する方
imB = imread("data_test\block.jpg");%回転しない方


%画像合わせ開始-------

%画像の縮小操作
imA = imresize(imA,size_default);
imB = imresize(imB,size_default);
length(imA)
imA_200 = imA;
imB_200 = imB;

imA = imresize(imA, 0.5, "bilinear");
imB = imresize(imB, 0.5, "bilinear");
imA_100  = imA;
imB_100  = imB;
imshow(imA);%確認用
length(imA)%確認用

imA = imresize(imA, 0.5, "bilinear");
imB = imresize(imB, 0.5, "bilinear");
imA_50  = imA;
imB_50  = imB;
imshow(imA);%確認用
length(imA)%確認用

imA = imresize(imA, 0.5, "bilinear");
imB = imresize(imB, 0.5, "bilinear");
imA_25  = imA;
imB_25  = imB;
imshow(imA);%確認用
length(imA)%確認用

imA = imresize(imA, 0.5, "bilinear");
imB = imresize(imB, 0.5, "bilinear");
imA_13  = imA;
imB_13  = imB;
imshow(imA);%確認用
length(imA)%確認用

imA = imresize(imA, 0.5, "bilinear");
imB = imresize(imB, 0.5, "bilinear");
imA_7  = imA;
imB_7  = imB;
imshow(imA);%確認用
length(imA)%確認用

imA = imresize(imA, 0.5, "bilinear");
imB = imresize(imB, 0.5, "bilinear");
imA_4  = imA;
imB_4  = imB;
imshow(imA);%確認用
length(imA)%確認用

imA = imresize(imA, 0.5, "bilinear");
imB = imresize(imB, 0.5, "bilinear");
imA_2  = imA;
imB_2  = imB;
imshow(imA);%確認用
length(imA)%確認用


%imA_4とimB_4との位置合わせの精度
d_degree = p * 180.0 / (1.0 * pi);%精度0.5での角度
d_pixel = p;

%回転操作
%ひとつ前の画像と移動した画像２つ保持して、良い方を残す
%平行移動操作
affine_imwk_great = imA_200;



cx = length(affine_imwk_great) / 2;
cy = length(affine_imwk_great) / 2;


affine_imwk = imrotate(affine_imwk_great, -d_degree,'bilinear')

for w = 1:length(affine_imwk_great)
    for h = 1:length(affine_imwk_great)
        affine_imwk[w][h] = (x2-cx) * cos(d_degree) - (y2-cy) * sin(d_degree) + cx
    end
end



















    

