function [label] = blocks
   load('save_blocks.mat', 'net');

   im = imread("data_test/block.jpg");
   im = imresize(im, [128 128]);
   label = classify(net, im);
end



