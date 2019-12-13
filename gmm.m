%������Ů����ߵ�GMM
clc
clear all
%��Ů����ȡ2000�ˣ�Ů��ƽ�����163������ƽ�����180
male=180+sqrt(10)*randn(1,1000);
%������ֵΪ180������Ϊ10��һ��1*1000�������
female=163+sqrt(10)*randn(1,1000);
h=[female male];

%������Ϻ��Ƶ�ʷֲ�ֱ��ͼ������150��ֱ��ͼ
figure(1)
hist(h,150);

%�������ɵ���Ů�Ե�Ƶ�ʷֲ�ֱ��ͼ
figure(2)
hist(female,100);
f=findobj(gca,'Type','patch');%�õ�ÿ�����߾���ļ���
set(f,'facecolor','g');%��������ͼ��ɫ
hold on
hist(male,100);%�������ɵ����Ե�Ƶ�ʷֲ�ֱ��ͼ
title('ĳУ��Ů����ߵķֲ�ֱ��ͼ');
xlabel('���/cm');
ylabel('����/��');
hold off;

%GMM�Ĺ���
%Step 1.���ȸ��ݾ������ֱ����Ů���ľ�ֵ�������Ȩֵ���г�ʼ��
mu1_first=170;sigmal_first=10;w1_first=0.7;%������
mu2_first=160;sigma2_first=10;w2_first=0.3;%������ѧУ��ԺУΪ��

iteration=30;%���õ�������
outcome=zeros(iteration,6);%����һ���������洢ÿ�εĵ������
outcome(1,1)=mu1_first;outcome(1,4)=mu2_first;
outcome(1,2)=sigmal_first;outcome(1,5)=sigma2_first;
outcome(1,3)=w1_first;outcome(1,6)=w2_first;%����һ�д洢��ʼֵ

%��ʼ����
for i=1:iteration-1
    [mu1_last,sigma1_last,w1_last,mu2_last,sigma2_last,w2_last]=em(male,female,outcome(i,1),outcome(i,2),outcome(i,3),outcome(i,4),outcome(i,5),outcome(i,6));
    %�����������������em,����outcome�е���ֵ
    outcome(i+1,1)=mu1_last;outcome(i+1,2)=sigma1_last;outcome(i+1,3)=w1_last;
    outcome(i+1,4)=mu2_last;outcome(i+1,5)=sigma2_last;outcome(i+1,6)=w2_last;
end

outcome ;% ���ÿ�ε������

%������Ů����Ȩ�ص�����ʷ
figure(3);
x1=1:0.5:iteration;
y1=interp1(outcome(:,3),x1,'spline');
%interp1�÷��ο�https://www.cnblogs.com/jiahuiyu/articles/4978005.html   
plot(y1,'linewidth',1.5);%����������Ȩ�ص�����ʷ
hold on;
grid on;
y2=interp1(outcome(:,6),x1,'spline');
plot(y2,'r','linewidth',1.5);%����Ů��Ȩ�ص�����ʷ
legend('����Ȩ�ر仯','Ů��Ȩ�ر仯','location','northeast');%���������ã�����ʶ�������ͼ�����Ͻ�
title('Changes in weights of boys and girls with the number of iterations');
xlabel('Number of iterations');
ylabel('Weights');
axis([1 iteration 0 1]);

%���������ս��ȡ��
mu1_last=outcome(iteration,1);
sigma1_last=outcome(iteration,2);
w1_last=outcome(iteration,3);
mu2_last=outcome(iteration,4);
sigma2_last=outcome(iteration,5);
w2_last=outcome(iteration,6);

figure(4);
hold on;
%����Ů���Լ���Ϻ���ߵĸ����ܶ�����
t=linspace(140,220,550);%500��
%Ů���ĸ����ܶȺ���
yy2=normpdf(t,mu2_last,sigma2_last);
plot(t,yy2,'m','linewidth',1.5);
%�����ĸ����ܶȺ���
yy1=normpdf(t,mu1_last,sigma1_last);
plot(t,yy1,'linewidth',1.5);
y3=w1_last*yy1+w2_last*yy2;
plot(t,y3,'k','linewidth',1.5);
legend('Ů��','����','���');
title('����Ů���Լ���Ϻ���ߵĸ����ܶ�����');
xlabel('���/cm');ylabel('����');hold off;%����������
hold off;

%����˹���ģ�͵�����������ı仯���仯ͼ��
figure(5)
plot(t,yy2,'--g','linewidth',1.5);
hold on;
plot(t,yy1,'linewidth',1.5);
title('��˹���ģ�͵�����������ı仯ͼ��');
xlabel('���/cm');
ylabel('�����ܶ�');
grid on;
weights1=outcome(:,3);
weights2=outcome(:,6);
%
%���ַ���������Ϣ��ʾ�����Ͻ�
text(180,0.13,'��ǰ����Ȩ��W1�� ','FontSize',14,'FontWeight','demi');%ͼ����ʾȨ��
text(180,0.117,'��ǰŮ��Ȩ��W2�� ','FontSize',14,'FontWeight','demi');
c=colormap(lines(iteration));%����times����ͬ��ɫ������
for i=1:iteration
      pause(0.2);
    %���Ƶ���i�ε�ͼ��,�Բ�ͬ��ɫ
    y4=weights1(i)*yy1+weights2(i)*yy2;%��������˹�����ܶ�ͼ����м�Ȩ
    plt=plot(t,y4,'color',c(i,:),'linewidth',1.5);%�滭��Ȩ���ͼ��
    %weights�������ֵת��Ϊ�ַ���
    str1=num2str(weights1(i));
    str2=num2str(weights2(i));
    %Ȩ�ظ���i�任
    tex1=text(210,0.13,str1,'FontSize',14,'FontWeight','demi','color','r');%��ʾ��ǰȨ��ֵ
    tex2=text(210,0.117,str2,'FontSize',14,'FontWeight','demi','color','r');
    %ɾ��ԭ���ģ���̬��ʾ
    pause(0.4);
    if(iteration>i)
        delete(tex1);
        delete(tex2);
        delete(plt);
    end
end
hold off;
   


    
