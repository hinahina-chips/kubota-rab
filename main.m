
import matlab.io.*;

%変数の初期設定------
size_default = [200, 200];
i = 0;
label = blocks();

imA = imread('base_blocks\base_red_block.jpg');
imB = imread("data_test\block.jpg");

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




    

