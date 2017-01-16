::::	說明：	1.交易室每日備份作業，每日16:30發動備份(JobName:_EveryDay_robo_172.25.27.197_KGIB_to_Reuter.bat)。
::::			2.交易室每月月底資料收容作業，每月月底23:50發動收容至日期資料夾(JobName:_MonthEnd_robo_172.25.27.197_KGIB_to_Reuter.bat)。
::::	備註：	1.來源端檔案異動-->備份
::::			2.來源端檔案刪除-->目的端不刪除繼續留存。
::::	窗口：許景翔
::::		FORM1	\\172.25.27.197\d$\KGIB\CONV
::::		FORM2	\\172.25.27.197\d$\KGIB\TICKET
::::		TO1	\\172.25.30.16\D$\TTD DATA\帳務組\02.By Product產品別資料\FX\Reuter\CONV
::::		TO2	\\172.25.30.16\D$\TTD DATA\帳務組\02.By Product產品別資料\FX\Reuter\TICKET
::::		Log	\\172.25.30.16\D$\TTD DATA\帳務組\02.By Product產品別資料\FX\Reuter\_MonthEnd_roboCopy_Move.log

:::::取得月底日日期
for /F "usebackq tokens=1,2,3 delims=/ " %%I IN (`echo %date%`) do set Today=%%I%%J%%K
:::::取得月底日YYYYMM建立月底日資料夾
for /F "usebackq tokens=1,2,3 delims=/ " %%I IN (`echo %date%`) do set MonthEndDir=%%I%%J

:::		net use \\172.25.27.197\c$ Password /user:"UserID"
net use \\172.25.27.197\d$ Password /user:"UserID"


:::::每月底23:50建立月底日資料夾。
MKDIR %Form1%\%MonthEndDir%
MKDIR %Form2%\%MonthEndDir%
MKDIR %To1%\%MonthEndDir%
MKDIR %To2%\%MonthEndDir%


:::::取得每月第一日日期
timeout 660
for /F "usebackq tokens=1,2,3 delims=/ " %%I IN (`echo %date%`) do set NewDay=%%I%%J%%K


:::::每月第一日00:05左右最後同步複製檔案至目的端
set Form1="\\172.25.27.197\d$\KGIB\CONV"
set To1="\\172.25.30.16\D$\TTD DATA\帳務組\02.By Product產品別資料\FX\Reuter\CONV"
set MoveLog="\\172.25.30.16\D$\TTD DATA\帳務組\02.By Product產品別資料\FX\Reuter\%Today%_MonthEnd_roboCopy_Move.log"
echo *** >> %MoveLog%
echo *** >> %MoveLog%
echo *** >> %MoveLog%
echo ===================================================================================== >> %MoveLog%
echo 【%Form1%】MonthEnd_Copy：%DATE%%TIME% >> %MoveLog%
robocopy %Form1% %To1% /XO /r:3 /w:3
robocopy %Form1% %To1% /XO /r:3 /w:3 /log+:%MoveLog%


set Form2="\\172.25.27.197\d$\KGIB\TICKET"
set To2="\\172.25.30.16\D$\TTD DATA\帳務組\02.By Product產品別資料\FX\Reuter\TICKET"
echo *** >> %MoveLog%
echo *** >> %MoveLog%
echo *** >> %MoveLog%
echo ===================================================================================== >> %MoveLog%
echo 【%Form2%】MonthEnd_Copy：%DATE%%TIME% >> %MoveLog%
robocopy %Form2% %To2% /XO /r:3 /w:3
robocopy %Form2% %To2% /XO /r:3 /w:3 /log+:%MoveLog%


:::::將上個月底之前的資料搬移至月底日資料夾
robocopy %To1% %To1%\%MonthEndDir% /MOV /r:3 /w:3 /MINAGE:%NewDay% /log+:%MoveLog%
robocopy %To2% %To2%\%MonthEndDir% /MOV /r:3 /w:3 /MINAGE:%NewDay% /log+:%MoveLog%
robocopy %Form1% %Form1%\%MonthEndDir% /MOV /r:3 /w:3 /MINAGE:%NewDay% /log+:%MoveLog%
robocopy %Form2% %Form2%\%MonthEndDir% /MOV /r:3 /w:3 /MINAGE:%NewDay% /log+:%MoveLog%