::::	�����G	1.����ǨC��ƥ��@�~�A�C��16:30�o�ʳƥ�(JobName:_EveryDay_robo_172.25.27.197_KGIB_to_Reuter.bat)�C
::::			2.����ǨC��멳��Ʀ��e�@�~�A�C��멳23:50�o�ʦ��e�ܤ����Ƨ�(JobName:_MonthEnd_robo_172.25.27.197_KGIB_to_Reuter.bat)�C
::::	�Ƶ��G	1.�ӷ����ɮײ���-->�ƥ�
::::			2.�ӷ����ɮקR��-->�ت��ݤ��R���~��d�s�C
::::	���f�G�\����
::::		FORM1	\\172.25.27.197\d$\KGIB\CONV
::::		FORM2	\\172.25.27.197\d$\KGIB\TICKET
::::		TO1	\\172.25.30.16\D$\TTD DATA\�b�Ȳ�\02.By Product���~�O���\FX\Reuter\CONV
::::		TO2	\\172.25.30.16\D$\TTD DATA\�b�Ȳ�\02.By Product���~�O���\FX\Reuter\TICKET
::::		Log	\\172.25.30.16\D$\TTD DATA\�b�Ȳ�\02.By Product���~�O���\FX\Reuter\_MonthEnd_roboCopy_Move.log

:::::���o�멳����
for /F "usebackq tokens=1,2,3 delims=/ " %%I IN (`echo %date%`) do set Today=%%I%%J%%K
:::::���o�멳��YYYYMM�إߤ멳���Ƨ�
for /F "usebackq tokens=1,2,3 delims=/ " %%I IN (`echo %date%`) do set MonthEndDir=%%I%%J

:::		net use \\172.25.27.197\c$ Password /user:"UserID"
net use \\172.25.27.197\d$ Password /user:"UserID"


:::::�C�멳23:50�إߤ멳���Ƨ��C
MKDIR %Form1%\%MonthEndDir%
MKDIR %Form2%\%MonthEndDir%
MKDIR %To1%\%MonthEndDir%
MKDIR %To2%\%MonthEndDir%


:::::���o�C��Ĥ@����
timeout 660
for /F "usebackq tokens=1,2,3 delims=/ " %%I IN (`echo %date%`) do set NewDay=%%I%%J%%K


:::::�C��Ĥ@��00:05���k�̫�P�B�ƻs�ɮצܥت���
set Form1="\\172.25.27.197\d$\KGIB\CONV"
set To1="\\172.25.30.16\D$\TTD DATA\�b�Ȳ�\02.By Product���~�O���\FX\Reuter\CONV"
set MoveLog="\\172.25.30.16\D$\TTD DATA\�b�Ȳ�\02.By Product���~�O���\FX\Reuter\%Today%_MonthEnd_roboCopy_Move.log"
echo *** >> %MoveLog%
echo *** >> %MoveLog%
echo *** >> %MoveLog%
echo ===================================================================================== >> %MoveLog%
echo �i%Form1%�jMonthEnd_Copy�G%DATE%%TIME% >> %MoveLog%
robocopy %Form1% %To1% /XO /r:3 /w:3
robocopy %Form1% %To1% /XO /r:3 /w:3 /log+:%MoveLog%


set Form2="\\172.25.27.197\d$\KGIB\TICKET"
set To2="\\172.25.30.16\D$\TTD DATA\�b�Ȳ�\02.By Product���~�O���\FX\Reuter\TICKET"
echo *** >> %MoveLog%
echo *** >> %MoveLog%
echo *** >> %MoveLog%
echo ===================================================================================== >> %MoveLog%
echo �i%Form2%�jMonthEnd_Copy�G%DATE%%TIME% >> %MoveLog%
robocopy %Form2% %To2% /XO /r:3 /w:3
robocopy %Form2% %To2% /XO /r:3 /w:3 /log+:%MoveLog%


:::::�N�W�Ӥ멳���e����Ʒh���ܤ멳���Ƨ�
robocopy %To1% %To1%\%MonthEndDir% /MOV /r:3 /w:3 /MINAGE:%NewDay% /log+:%MoveLog%
robocopy %To2% %To2%\%MonthEndDir% /MOV /r:3 /w:3 /MINAGE:%NewDay% /log+:%MoveLog%
robocopy %Form1% %Form1%\%MonthEndDir% /MOV /r:3 /w:3 /MINAGE:%NewDay% /log+:%MoveLog%
robocopy %Form2% %Form2%\%MonthEndDir% /MOV /r:3 /w:3 /MINAGE:%NewDay% /log+:%MoveLog%