
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
imA_lists(1) = imA;
imB_lists(1) = imB;


while length(imB) > 5
    i = i + 1;
    imA = imresize(imA, 0.5, "bilinear");
    imB = imresize(imB, 0.5, "bilinear");
     = imA;
    imB_lists(i) = imB;
    imshow(imA);%確認用
    length(imA);%確認用
end
