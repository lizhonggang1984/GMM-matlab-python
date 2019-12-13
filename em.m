function [mu1_last,sigmal_last,w1_last,mu2_last,sigma2_last,w2_last]=em(male,female,mu1_first,sigmal_first,w1_first,mu2_first,sigma2_first,w2_first)
%Step 1.���ȸ��ݾ������ֱ�������Ů���ľ�ֵ�������Ȩֵ
% mu1_first,sigmal_first,w1_first=175,10,0.5;%������
% mu2_first,sigma2_first,w2_first=158,10,0.5;%Ů����

%Step 2. 
%�����е�������зֲ��е���ӦR1i
%����Ů��������зֲ��е���ӦR2i
h=[female male];%���
N=2000;
R1i=zeros(1,N);
R2i=zeros(1,N);
for i=1:N
    p1=w1_first*pdf('norm',h(i),mu1_first,sigmal_first);
    p2=w2_first*pdf('norm',h(i),mu2_first,sigma2_first);
    %p1,p2Ȩ��*��Ů���ĺ������
   R1i(i)=p1/(p1+p2);
   R2i(i)=p2/(p1+p2);
end

%Step 3.
%�����С�Ů����߷ֲ�������mu
s1=0;
s2=0;
for i=1:N
    s1=s1+R1i(i)*h(i);
    s2=s2+R2i(i)*h(i);
end
s11=sum(R1i);
s22=sum(R2i);
mu1_last=s1/s11;
mu2_last=s2/s22;

%Step 4.
%�����С�Ů����߷ֲ��ı�׼��sigma(һά��
t1=0;
t2=0;
for i=1:N
    t1=t1+R1i(i)*(h(i)-mu1_last)^2;
    t2=t2+R2i(i)*(h(i)-mu2_last)^2;
end
t11=sum(R1i);
t22=sum(R2i);
sigmal_last=sqrt(t1/t11);
sigma2_last=sqrt(t2/t22);

%Step 5.
%����Ȩֵ
w1_last=s11/N;
w2_last=s22/N;

end

    