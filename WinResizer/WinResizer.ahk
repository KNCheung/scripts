/*
    ��Ʒ˵����Windows�������й���
    ����ϵͳ��Win XP/7
    ���ߣ���ң�����
    E-mail�� TroyC.public@gmail.com
    ������Tariq Porter��GDI+ ��׼������ Rajat��SmartGUI
    �༭ע�ͣ�����ʹ��Vim�༭��:set foldmethod=marker
    ������־��
        01.06 ʹ���������ڵײ���������ʹ��
        01.05 С�޸ģ������ȼ�ΪCtrl+Win+������
        01.02 С�޸�
        12.29 �޸�һ�����ص�Bug
        12.24 �޸�һ��Bug
        12.23 ����淶��
        12.18 ����
        12.17 ����
        12.07 ��������������ƣ��ɹ���������Bug��
        12.06 ��Autohotkey ForumѰ�ҽ����������֪�����Ѿ�д��ֱ�ӵ���GDI�����ĺ������ñ�Ť������������Դ���о�����AHK������Դ������д������ƣ�ʧ�ܡ�
        12.05 �����о�DllCall��GDI��ʧ�ܡ�
        12.04 �޵����ã���ͣ��
        12.03 ��ʼдGDI��ʧ�ܡ�
        12.02 ��ʶ��API������ֱ�ӱ������������ã��������²鿴Autohotkey�����ĵ�������DllCall������������AHK��д��������ܡ��㷨����ʼд��һ������ɡ�
        12.01 ѧϰAPI�ı�д��֪����GDI��
        11.30 ����У��ͼ������飬�����м���APIһ�ʣ������ҵ���Windows API������⡷��
        11.29 �����뵽��Autohotkey��д�����Ƿ���û�л�ͼ������GUI���治�ñ�д�������뵽��VC++��д��
        11.27 �ڻ���ѧϰʱ���ִ���̫�࣬��Ļ�����ã����ò��������������ڵĴ�С��λ�ã���ʾ�൱ץ���ȷ�����������뷨��  
*/

;{{{��ʼ��
	#Persistent
	#SingleInstance force
	#include gdip.ahk

	onexit ,exitthisahk

	SetBatchLines ,-1
	CoordMode ,Mouse,Screen

	EscPressed := 0
	Suspended := 0
	IniRead, GridX, Settings.ini , Env, GridX ,8
	IniRead, GridY, Settings.ini , Env, GridY ,6
	IniRead tempnoicon , Settings.ini ,Env ,NoIcon ,0
	
	IfEqual ,tempnoicon,1
		Menu,Tray,noicon
	Else
	{ ;{{{Menu
		Menu ,tray ,NoStandard
		Menu ,tray ,Click ,1
		Menu ,tray ,Tip ,Windows ��������С�ű�`nBy ������
		Menu ,SettingsMenu ,add ,����ͼ��,FunSettingNoIcon
		Menu ,SettingsMenu ,add ,���ø���,FunSettingGrid
		Menu ,tray ,add ,����, :SettingsMenu
		Menu ,tray ,add
		Menu ,tray ,add ,����, FunAbout
		Menu ,tray ,add ,��ͣ, FunSuspend
		Menu ,tray ,add ,�˳� ,exitthisahk
	} ;}}}Menu
	Hotkey ,^#LButton,Startit,On
Return
;}}}��ʼ��

;{{{ MAIN
	Startit:		
		;{{{��ʼ����
		Hotkey ,^#LButton,,Off
		MouseGetPos, , , WinID, control
		WinGetTitle, WinTitle,ahk_id %WinID%
		WinGet ,WinMaxFlag,MinMax,ahk_id %WinID%
		IfEqual,WinMaxFlag,1
		{
			WinRestore ,ahk_id %WinID%
		}
		WinGetPos ,WinX,WinY,WinWidth,WinHeight,ahk_id %WinID%
		
		Goto Drawer
		;}}}��ʼ����
	Return

	Drawer:
		WinMinimize ,ahk_id %WinID%
		;{{{���Ƹ���
		;{{{��ȡϵͳ��Ϣ
		SysGet ,MonitorSize,MonitorWorkArea
		GridWidth := ( MonitorSizeRight - MonitorSizeLeft ) // GridX
		GridHeight := ( MonitorSizeBottom - MonitorSizeTop ) // GridY
		HalfX := GridWidth //2
		HalfY := GridHeight //2
		;}}}��ȡϵͳ��Ϣ
		
		;{{{���Ƹ���
		pToken := Gdip_Startup()
		Gui ,+AlwaysOnTop +ToolWindow -SysMenu -Theme +LastFound +E0x80000 +ToolWindow +OwnDialogs
		Gui ,Color , Silver
		Gui ,-Caption 
		Gui ,show , NA
    BackgroundWidth := MonitorSizeRight - MonitorSizeLeft
    BackgroundHeight := MonitorSizeBottom - MonitorSizeTop
    ;msgbox ,Width ranges from %MonitorSizeLeft% to %MonitorSizeRight%`nHeight ranges from %MonitorSizeTop% to %MonitorSizeBottom%
		WinMove ,,,%MonitorSizeLeft%,%MonitorSizeTop%,%BackgroundWidth%,%BackgroundHeight%
		DCID := WinExist()

		hbm := CreateDIBSection(BackgroundWidth,BackgroundHeight)
		hdc := CreateCompatibleDC()
		obm := SelectObject(hdc,hbm)
		G := Gdip_GraphicsFromHDC(hdc)
		Gdip_SetSmoothingMode(G, 4)

		;=======DRAW SOLIDS=========
		pBrush := Gdip_BrushCreateSolid(0x380000ff)
		Gdip_FillRectangle(G, pBrush, 0,0,BackgroundWidth,BackgroundHeight)
		Gdip_DeleteBrush(pBrush)

		;=======DRAW GRIDS==========
		pBrush := Gdip_BrushCreateSolid(0xffffffff)

		t := 0
		loop ,%GridX%{
			t += GridWidth
			Gdip_FillRectangle(G, pBrush, t,0,4,BackgroundHeight)
		}

		t := 0
		loop ,%GridY%{
			t += GridHeight
			Gdip_FillRectangle(G,pBrush,0,t,BackgroundWidth,4)
		}

		Gdip_DeleteBrush(pBrush)

		UpdateLayeredWindow(DCID, hdc, MonitorSizeLeft,MonitorSizeTop, BackgroundWidth, BackgroundHeight)

		SelectObject(hdc,obm)
		DeleteObject(hbm)
		DeleteDC(hdc)
		Gdip_DeleteGraphics(G)
		;}}}���Ƹ���

		;{{{�ȴ������Ϣ
		Hotkey ,Esc,PressESC,On
		Tooltip ,�����ڵ����Ĵ�����%WinTitle%

		Keywait ,LButton,D T3
		ifEqual ,Errorlevel,1
		{
			goto RestoreUI
			return
		}
		MouseGetPos ,MouseX1,MouseY1
		;settimer ,ShowMousePosition ,200
		
		IfEqual ,EscPressed,1
		{
			EscPressed := 0
			goto RestoreUI
			Return
		}

		Keywait ,LButton	
		MouseGetPos ,MouseX2,MouseY2
		;}}}�ȴ������Ϣ

		;{{{���㲢����
		ifGreater ,MouseX1,%MouseX2%
		{
			t = %MouseX1%
			MouseX1 = %MouseX2%
			MouseX2 = %t%
		}
		ifGreater ,MouseY1,%MouseY2%
		{
			t = %MouseY1%
			MouseY1 = %MouseY2%
			MouseY2 = %t%
		}
		PosX := ( MouseX1 // GridWidth ) * GridWidth + MonitorSizeLeft
		PosY := ( MouseY1 // GridHeight ) * GridHeight  + MonitorSizeTop
		NewWinWidth := ( ( MouseX2 - MouseX1 ) // GridWidth + 1 ) * GridWidth
		NewWinHeight := ( ( MouseY2 - MouseY1 ) // GridHeight + 1 ) * GridHeight
		WinRestore ,ahk_id %WinID%
		WinMove ,ahk_id %WinID%,,%PosX%,%PosY%,%NewWinWidth%,%NewWinHeight%
		WinHide ,ahk_id %WinID%
		WinShow ,ahk_id %WinID%
		;}}}���㲢����

		;{{{�ָ�
		Hotkey ,^#LButton,Startit,On
		Goto RestoreUI
		;}}}�ָ�
		;}}}���Ƹ���
	Return

	DrawGrid:
		;{{{��̬���Ƹ���
		MouseGetPos ,MouseX,MouseY
		tooltip
		tooltip ,(%MouseX%`,%MouseY%)
		Settimer ,CleanTooltip,-1000
		;}}}��̬���Ƹ���
	Return

	PressESC:
		;{{{��ֹ����
		Hotkey ,Esc,,Off
		EscPressed := 1
		Goto RestoreUI
		;}}}��ֹ����
	Return
	
	RestoreUI:
		;{{{�ָ�
		Gdip_Shutdown(pToken)
		Gui ,destroy
		WinRestore ,ahk_id %WinID%
		Hotkey ,^#LButton,Startit,On
		;Settimer ,ShowMousePosition,off
		Goto CleanTooltip
		;}}}�ָ�
	Return
;}}}

;{{{ SETTINGS
	Buttonȷ��(O):
		;{{{���á���ȷ����ť
		Gui,Submit ,NoHide
		IniWrite, %X%, Settings.ini , Env, GridX
		Iniwrite, %Y%, Settings.ini , Env, GridY
		GridX := X
		GridY := Y
		Tooltip ,��������Ϊ��%Y%��x%X%��
		Gui ,Destroy
		Settimer ,CleanTooltip ,-1000
		;}}}���á���ȷ����ť
	Return

	Buttonȡ��(C):
			;{{{���á���ȡ����ť
			Gui ,Destroy
			Tooltip ,δ����
			Settimer ,CleanTooltip ,-1000
			;}}}���á���ȡ����ť
	Return

	FunSettingNoIcon:
		;{{{���á�������ͼ��
		MsgBox ,289,����,����ͼ�꽫����ʧ���޷������̲˵�
		IfMsgBox ,OK
		{
			IniWrite ,1,Settings.ini,Env,NoIcon
			Menu ,tray ,NoIcon
			Msgbox ,64,��ʾ,����ͼ������ʧ`n�����ֶ��������ã����޸Ľű�Ŀ¼�µ�Settings.ini�ļ�`nɾ��NoIcon=1һ�л��ΪNoIcon=0������ʾ����ͼ��
		}
		;}}}���á�������ͼ��
	Return

	FunSuspend:
		;{{{���á�����ͣ
		IfEqual,Suspended,1 
		{
			Hotkey ,^#LButton,Startit,On
			Menu ,tray,Uncheck,��ͣ
			Suspended=0
		}else{
			Hotkey ,^#LButton,,Off
			Menu ,tray,Check,��ͣ
			Suspended=1
		}
		;}}}���á�����ͣ
	Return

	FunSettingGrid:
		;{{{���á�����ʼ���Ի���
		old := GridX
		Gui,+AlwaysOnTop -Resize -SysMenu +ToolWindow
		Gui, Add, Button, x12 y110 w90 h20 ,ȷ��(&O)
		GuiControl, +Default, ȷ��(&O)
		Gui, Add, Edit, x122 y20 w90 h20 r1 vY Limit2 Number ReadOnly,%GridY%
		Gui, Add, UpDown, vXUD Range1-20 Wrap, %GridY%
		Gui, Add, Edit, x122 y70 w90 h10 r1 vX Limit2 Number ReadOnly,%GridX%
		Gui, Add, UpDown, vYUD Range1-18 Wrap, %GridX%
		Gui, Add, Text, x22 y20 w80 h20 , ��������
		Gui, Add, Text, x22 y70 w80 h20 , ��������
		Gui, Add, Button, x122 y110 w90 h20 , ȡ��(&C)
		; Generated using SmartGUI Creator 4.0
		Gui, Show, h147 w234 center , ���ø���
		;}}}���á�����ʼ���Ի���
	Return
;}}}

;{{{ OTHERS
	FunAbout:
		;{{{����
		Msgbox ,64,����,Windows ��������С�ű�`n������Win7`/XP`n��������д,5
		;}}}����
	Return

	CleanTooltip:
		;{{{���Tooltip
		Settimer ,CleanTooltip ,Off
		tooltip
		;}}}���Tooltip
	Return

	exitthisahk:
		;{{{�����ű�
		exitapp
		;}}}�����ű�
	return

	;{{{Debug
	ShowMousePosition:
		MouseGetPos ,MouseX,MouseY
		tooltip ,%MouseX%x%MouseY%
	Return
	;}}}Debug
;}}}
