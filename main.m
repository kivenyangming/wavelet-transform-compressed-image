%������߰汾Ϊ MATLAB R2019b
%�������
clc
clear
close all
%%ͼ��Ԥ����
tic
%%
img=imread('a.jpg');%��ȡͼ��
wavename='haar';
level=3;
%��ͨ��ͼ����
%���ж��Ƿ�Ϊ��ͨ�������ǵĻ�ȡ0���ǵĻ���RGB��ͨ����ȡ����
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
%С���ֽ⣨��ͨ���ֽ⣩
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

%������ֵ
T=4.5544;%T��ֵ�����˱任���ͼ���С
C(abs(C)<=T)=T;

%�ع���ͬ��ֵ��ͼ��
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
imwrite(A,'b.jpg');%�ع����ͼ��
toc