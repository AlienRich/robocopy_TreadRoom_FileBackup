::::	�����G����ǨC��ƥ��@�~�A�C��16:30�o�ʳƥ��C
::::	�Ƶ��G1.�ӷ����ɮײ���-->�ƥ�
::::	      2.�ӷ����ɮקR��-->�ت��ݤ��R���~��d�s�C
::::	���f�G�\����
::::		FORM1	\\172.25.27.197\d$\KGIB\CONV
::::		FORM2	\\172.25.27.197\d$\KGIB\TICKET
::::		TO1	\\172.25.30.16\D$\TTD DATA\�b�Ȳ�\02.By Product���~�O���\FX\Reuter\CONV
::::		TO2	\\172.25.30.16\D$\TTD DATA\�b�Ȳ�\02.By Product���~�O���\FX\Reuter\TICKET
::::		Log	\\172.25.30.16\D$\TTD DATA\�b�Ȳ�\02.By Product���~�O���\FX\Reuter\_EveryDay_roboCopy.log



:::::���o��YYYYMM
for /F "usebackq tokens=1,2,3 delims=/ " %%I IN (`echo %date%`) do set YYYMM=%%I%%J
set Log="\\172.25.30.16\D$\TTD DATA\�b�Ȳ�\02.By Product���~�O���\FX\Reuter\%YYYMM%_EveryDay_roboCopy.log"


:::		net use \\172.25.27.197\C$ Password /user:"UserID"
net use \\172.25.27.197\d$ Password /user:"UserID"


set Form1="\\172.25.27.197\d$\KGIB\CONV"
set To1="\\172.25.30.16\D$\TTD DATA\�b�Ȳ�\02.By Product���~�O���\FX\Reuter\CONV"
echo == >> %Log%
echo == >> %Log%
echo ===================================================================================== >> %Log%
echo �i%Form1%�jCopy�G%DATE%%TIME% >> %Log%
robocopy %Form1% %To1% /XO /r:3 /w:3
robocopy %Form1% %To1% /XO /r:3 /w:3 /log+:%Log%


set Form2="\\172.25.27.197\d$\KGIB\TICKET"
set To2="\\172.25.30.16\D$\TTD DATA\�b�Ȳ�\02.By Product���~�O���\FX\Reuter\TICKET"
echo == >> %Log%
echo == >> %Log%
echo ===================================================================================== >> %Log%
echo �i%Form2%�jCopy�G%DATE%%TIME% >> %Log%
robocopy %Form2% %To2% /XO /r:3 /w:3
robocopy %Form2% %To2% /XO /r:3 /w:3 /log+:%Log%