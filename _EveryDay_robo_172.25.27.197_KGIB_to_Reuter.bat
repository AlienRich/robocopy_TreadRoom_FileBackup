::::	說明：交易室每日備份作業，每日16:30發動備份。
::::	備註：1.來源端檔案異動-->備份
::::	      2.來源端檔案刪除-->目的端不刪除繼續留存。
::::	窗口：許景翔
::::		FORM1	\\172.25.27.197\d$\KGIB\CONV
::::		FORM2	\\172.25.27.197\d$\KGIB\TICKET
::::		TO1	\\172.25.30.16\D$\TTD DATA\帳務組\02.By Product產品別資料\FX\Reuter\CONV
::::		TO2	\\172.25.30.16\D$\TTD DATA\帳務組\02.By Product產品別資料\FX\Reuter\TICKET
::::		Log	\\172.25.30.16\D$\TTD DATA\帳務組\02.By Product產品別資料\FX\Reuter\_EveryDay_roboCopy.log



:::::取得月YYYYMM
for /F "usebackq tokens=1,2,3 delims=/ " %%I IN (`echo %date%`) do set YYYMM=%%I%%J
set Log="\\172.25.30.16\D$\TTD DATA\帳務組\02.By Product產品別資料\FX\Reuter\%YYYMM%_EveryDay_roboCopy.log"


:::		net use \\172.25.27.197\C$ Password /user:"UserID"
net use \\172.25.27.197\d$ Password /user:"UserID"


set Form1="\\172.25.27.197\d$\KGIB\CONV"
set To1="\\172.25.30.16\D$\TTD DATA\帳務組\02.By Product產品別資料\FX\Reuter\CONV"
echo == >> %Log%
echo == >> %Log%
echo ===================================================================================== >> %Log%
echo 【%Form1%】Copy：%DATE%%TIME% >> %Log%
robocopy %Form1% %To1% /XO /r:3 /w:3
robocopy %Form1% %To1% /XO /r:3 /w:3 /log+:%Log%


set Form2="\\172.25.27.197\d$\KGIB\TICKET"
set To2="\\172.25.30.16\D$\TTD DATA\帳務組\02.By Product產品別資料\FX\Reuter\TICKET"
echo == >> %Log%
echo == >> %Log%
echo ===================================================================================== >> %Log%
echo 【%Form2%】Copy：%DATE%%TIME% >> %Log%
robocopy %Form2% %To2% /XO /r:3 /w:3
robocopy %Form2% %To2% /XO /r:3 /w:3 /log+:%Log%