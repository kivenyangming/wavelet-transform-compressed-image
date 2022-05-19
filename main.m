%软件工具版本为 MATLAB R2019b
%清除变量
clc
clear
close all
%%图像预处理
tic
%%
img=imread('a.jpg');%获取图像
wavename='haar';
level=3;
%三通道图像处理
%先判断是否为三通道，不是的话取0，是的话对RGB三通道读取数据
if ndims(img)==3 %
    imgcolor=1;
    Xr=img(:,:,1);
    Xg=img(:,:,2);
    Xb=img(:,:,3);
else
    imgcolor=0;
end
img=double(img);
%%
%小波分解（三通道分解）
if imgcolor
    [Cr,Sr]=wavedec2(Xr,level,wavename);
    [Cg,Sg]=wavedec2(Xg,level,wavename);
    [Cb,Sb]=wavedec2(Xb,level,wavename);
    C(1,:)=Cr;
    C(2,:)=Cg;
    C(3,:)=Cb;
else
    [C,S]=wavedec2(img,level,wavename);
end

%设置阈值
T=4.5544;%T的值决定了变换后的图像大小
C(abs(C)<=T)=T;

%重构不同阈值下图像
if imgcolor
    Cr=C(1,:);
    Cg=C(2,:);
    Cb=C(3,:);
    Ar=waverec2(Cr,Sr,wavename);
    Ag=waverec2(Cg,Sg,wavename);
    Ab=waverec2(Cb,Sb,wavename);
    A(:,:,1)=uint8(round(Ar));
    A(:,:,2)=uint8(round(Ag));
    A(:,:,3)=uint8(round(Ab));
else
    A=waverec2(C,wavename);
    A=unit8(round(A));
end
A=uint8(A);
imwrite(A,'b.jpg');%重构后的图像
toc