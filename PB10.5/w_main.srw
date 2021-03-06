$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type cb_6 from commandbutton within w_main
end type
type cb_5 from commandbutton within w_main
end type
type st_4 from statictext within w_main
end type
type cb_4 from commandbutton within w_main
end type
type st_3 from statictext within w_main
end type
type st_2 from statictext within w_main
end type
type st_1 from statictext within w_main
end type
type cb_3 from commandbutton within w_main
end type
type cb_2 from commandbutton within w_main
end type
type sle_pass from singlelineedit within w_main
end type
type sle_user from singlelineedit within w_main
end type
type sle_db from singlelineedit within w_main
end type
type cb_1 from commandbutton within w_main
end type
type system_info from structure within w_main
end type
end forward

type system_info from structure
	unsignedinteger		wprocessorarchitecture
	unsignedinteger		wreserved
	unsignedlong		dwpagesize
	unsignedlong		lpminimumapplicationaddress
	unsignedlong		lpmaximumapplicationaddress
	unsignedlong		dwactiveprocessormask
	unsignedlong		dwnumberofprocessors
	unsignedlong		dwprocessortype
	unsignedlong		dwallocationgranularity
	unsignedinteger		wprocessorlevel
	unsignedinteger		wprocessorrevsion
end type

global type w_main from window
integer width = 2203
integer height = 840
boolean titlebar = true
string title = "Connect MS Access"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_6 cb_6
cb_5 cb_5
st_4 st_4
cb_4 cb_4
st_3 st_3
st_2 st_2
st_1 st_1
cb_3 cb_3
cb_2 cb_2
sle_pass sle_pass
sle_user sle_user
sle_db sle_db
cb_1 cb_1
end type
global w_main w_main

type prototypes
Subroutine GetNativeSystemInfo ( 	Ref SYSTEM_INFO lpSystemInfo ) Library "kernel32.dll"
Subroutine GetSystemInfo ( Ref SYSTEM_INFO lpSystemInfo ) Library "kernel32.dll"
Function Boolean IsWow64Process ( Long hProcess, 	Ref Boolean Wow64Process ) Library "kernel32.dll"
Function Long GetCurrentProcess ( ) Library "kernel32.dll"

end prototypes

forward prototypes
public function integer wf_getosbits ()
end prototypes

public function integer wf_getosbits ();// This function determines if OS is 32 bits or 64 bits.

Constant Long PROCESSOR_ARCHITECTURE_INTEL = 0	// x86
Constant Long PROCESSOR_ARCHITECTURE_IA64  = 6	// Intel Itanium-based
Constant Long PROCESSOR_ARCHITECTURE_AMD64 = 9	// x64 (AMD or Intel)
SYSTEM_INFO lstr_si
Integer li_bits
Boolean lb_IsWow64

IsWOW64Process(GetCurrentProcess(), lb_IsWow64)

If lb_IsWow64 Then
	GetNativeSystemInfo(lstr_si)
Else
	GetSystemInfo(lstr_si)
End If

choose case lstr_si.wProcessorArchitecture
	case PROCESSOR_ARCHITECTURE_IA64
		li_bits = 64
	case PROCESSOR_ARCHITECTURE_AMD64
		li_bits = 64
	case else
		li_bits = 32
end choose

Return li_bits

end function

on w_main.create
this.cb_6=create cb_6
this.cb_5=create cb_5
this.st_4=create st_4
this.cb_4=create cb_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.sle_pass=create sle_pass
this.sle_user=create sle_user
this.sle_db=create sle_db
this.cb_1=create cb_1
this.Control[]={this.cb_6,&
this.cb_5,&
this.st_4,&
this.cb_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_3,&
this.cb_2,&
this.sle_pass,&
this.sle_user,&
this.sle_db,&
this.cb_1}
end on

on w_main.destroy
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.st_4)
destroy(this.cb_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.sle_pass)
destroy(this.sle_user)
destroy(this.sle_db)
destroy(this.cb_1)
end on

event open;string ls_path
ls_path = GetCurrentDirectory ( )

sle_db.text = ls_path + "\accdb.mdb"
end event

type cb_6 from commandbutton within w_main
integer x = 731
integer y = 608
integer width = 571
integer height = 92
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Connect ADO.Net"
end type

event clicked;String ls_db, ls_database,  ls_user, ls_pass

ls_user = sle_user.Text
ls_pass = sle_pass.Text
ls_database = sle_db.Text

Transaction ltran_conn
ltran_conn = Create Transaction

If upper(right(trim(ls_database), 4)) = ".MDB" Then
	ltran_conn.DBParm =  "Namespace='System.Data.OleDb',Provider='Microsoft.Jet.OLEDB.4.0',DataSource='"+ls_database+"'"
Else
	ltran_conn.DBParm =  "Namespace='System.Data.OleDb',Provider='Microsoft.ACE.OLEDB.12.0',DataSource='"+ls_database+"'"
End if

// Using ADO.Net Connect To MS Access 
ltran_conn.DBMS ="ADO.Net"
ltran_conn.AutoCommit = False
ltran_conn.LogId = ls_user
ltran_conn.LogPass = ls_pass


Connect Using ltran_conn ;
If ltran_conn.SQLCode = -1 Then
	MessageBox('Warning','Connect Database Error' + ltran_conn.SQLErrText)
Else
	MessageBox('Warning',"Connect Success!")
End If

Disconnect Using ltran_conn ;

end event

type cb_5 from commandbutton within w_main
integer x = 219
integer y = 608
integer width = 498
integer height = 92
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Connect OLE DB"
end type

event clicked;String ls_db, ls_database,  ls_user, ls_pass

ls_user = sle_user.Text
ls_pass = sle_pass.Text
ls_database = sle_db.Text

Transaction ltran_conn
ltran_conn = Create Transaction

If upper(right(trim(ls_database), 4)) = ".MDB" Then
	ltran_conn.DBParm = "PROVIDER='Microsoft.Jet.OLEDB.4.0',DATASOURCE='"+ls_database+""
Else
	ltran_conn.DBParm = "PROVIDER='Microsoft.ACE.OLEDB.12.0',DATASOURCE='"+ls_database+""
End if

// Using OLE DB Connect To MS Access 
ltran_conn.DBMS ="OLE DB"
ltran_conn.AutoCommit = False
ltran_conn.LogId = ls_user
ltran_conn.LogPass = ls_pass


Connect Using ltran_conn ;
If ltran_conn.SQLCode = -1 Then
	MessageBox('Warning','Connect Database Error' + ltran_conn.SQLErrText)
Else
	MessageBox('Warning',"Connect Success!")
End If

Disconnect Using ltran_conn ;

end event

type st_4 from statictext within w_main
integer x = 55
integer y = 40
integer width = 2139
integer height = 136
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Connect MS-Access Database"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_main
integer x = 2007
integer y = 216
integer width = 123
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "..."
end type

event clicked;String ls_path, ls_file
Int li_rc

ls_path = sle_db.Text
li_rc = GetFileSaveName ( "Select File",   ls_path, ls_file, "mdb",  "Microsoft Access 2003 (*.mdb),*.mdb,Microsoft Access 2007 (*.accdb),*.accdb,All Files (*.*),*.*" )

If li_rc = 1 Then
	sle_db.Text = ls_path
End If


end event

type st_3 from statictext within w_main
integer x = 736
integer y = 360
integer width = 320
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "PassWord:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_main
integer x = 55
integer y = 360
integer width = 165
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "User:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_main
integer x = 55
integer y = 236
integer width = 165
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "DB:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_main
integer x = 1865
integer y = 608
integer width = 265
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Close"
end type

event clicked;Close(Parent)
end event

type cb_2 from commandbutton within w_main
integer x = 731
integer y = 480
integer width = 571
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Connect JDBC"
end type

event clicked;String ls_path, ls_classpath
Boolean lb_jvm_started, lb_debug
javavm ljvm
ls_path = GetCurrentDirectory ( )

// set classpath or you can environment variables of window
ls_classpath = ls_path + "\UCanAccess\ucanaccess-4.0.4.jar"

If Not FileExists(ls_classpath) Then
	MessageBox('Warning',"driver class file not exists")
	Return
End If

// add libary
ls_classpath = ls_classpath + ";" + ls_path +"\UCanAccess\lib\commons-logging-1.1.3.jar"
ls_classpath = ls_classpath + ";" + ls_path +"\UCanAccess\lib\hsqldb.jar"
ls_classpath = ls_classpath + ";" + ls_path +"\UCanAccess\lib\jackcess-2.1.11.jar"
ls_classpath = ls_classpath + ";" + ls_path +"\UCanAccess\lib\commons-lang-2.6.jar"

If Not lb_jvm_started Then
	ljvm = Create javavm //using pbejbclientXXX.pbd
	Choose Case ljvm.createJavaVM(ls_classpath, lb_debug)
		Case 0
			lb_jvm_started = True
		Case -1
			MessageBox('Warning',"Failed to load JavaVM")
			Return
		Case -2
			MessageBox('Warning',"Failed to load EJBLocator")
			Return
	End Choose
End If


// Get infor
String ls_url, ls_database,  ls_user, ls_pass

ls_user = sle_user.Text
ls_pass = sle_pass.Text
ls_database = sle_db.Text

ls_url = "jdbc:ucanaccess://"+ ls_database

//connect
Transaction ltran_conn
ltran_conn = Create Transaction

ltran_conn.DBMS = "JDBC"
ltran_conn.LogPass = ls_pass
ltran_conn.LogID = ls_user
ltran_conn.AutoCommit = False
ltran_conn.DBParm = "Driver='net.ucanaccess.jdbc.UcanaccessDriver',URL='"+ls_url+"'"

Connect Using ltran_conn ;
If ltran_conn.SQLCode = -1 Then
	MessageBox('Warning','Connect Database Error' + ltran_conn.SQLErrText)
Else
	MessageBox('Warning',"Connect Success!")
End If

Disconnect Using ltran_conn ;

end event

type sle_pass from singlelineedit within w_main
integer x = 1093
integer y = 348
integer width = 901
integer height = 80
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type sle_user from singlelineedit within w_main
integer x = 233
integer y = 348
integer width = 402
integer height = 80
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "admin"
borderstyle borderstyle = stylelowered!
end type

type sle_db from singlelineedit within w_main
integer x = 233
integer y = 220
integer width = 1760
integer height = 80
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_main
integer x = 219
integer y = 480
integer width = 498
integer height = 92
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Connect ODBC"
end type

event clicked;String ls_db, ls_database,  ls_user, ls_pass, ls_odbcjt32


If wf_GetOSBits() = 64 Then
	ls_odbcjt32 = "C:\Windows\SysWOW64\odbcjt32.dll"
Else
	ls_odbcjt32 = "C:\Windows\System32\odbcjt32.dll"
End If

ls_user = sle_user.Text
ls_pass = sle_pass.Text
ls_database = sle_db.Text

If upper(right(trim(ls_database), 4)) = ".MDB" Then
	ls_db = "PBMDB"
	
	RegistrySet("HKEY_CURRENT_USE\Software\ODBC\ODBC.INI\"+ls_db,"DBQ",RegString!,ls_database)
	RegistrySet("HKEY_CURRENT_USE\Software\ODBC\ODBC.INI\"+ls_db,"Driver",RegString!,ls_odbcjt32)
	RegistrySet("HKEY_CURRENT_USE\Software\ODBC\ODBC.INI\"+ls_db,"DriverId",RegString!,"19")
	RegistrySet("HKEY_CURRENT_USE\Software\ODBC\ODBC.INI\"+ls_db,"FIL",RegString!,"MS Access;")
	RegistrySet("HKEY_CURRENT_USER\SOFTWARE\ODBC\ODBC.INI\ODBC DATA SOURCES",ls_db, RegString!, "Microsoft Access Driver (*.mdb)")
Else
	ls_odbcjt32 = "C:\Program Files\Common Files\microsoft shared\OFFICE14\ACEODBC.DLL"
	ls_db = "PBACCDB"
	
	RegistrySet("HKEY_CURRENT_USE\Software\ODBC\ODBC.INI\"+ls_db,"DBQ",RegString!,ls_database)
	RegistrySet("HKEY_CURRENT_USE\Software\ODBC\ODBC.INI\"+ls_db,"Driver",RegString!,ls_odbcjt32)
	RegistrySet("HKEY_CURRENT_USE\Software\ODBC\ODBC.INI\"+ls_db,"DriverId",ReguLong!,25)
	RegistrySet("HKEY_CURRENT_USE\Software\ODBC\ODBC.INI\"+ls_db,"FIL",RegString!,"MS Access;")
	RegistrySet("HKEY_CURRENT_USER\SOFTWARE\ODBC\ODBC.INI\ODBC DATA SOURCES",ls_db, RegString!, "Microsoft Access Driver (*.mdb, *.accdb)")
End if

Transaction ltran_conn
ltran_conn = Create Transaction

// Using ODBC Connect To MS Access 
ltran_conn.DBMS = "ODBC"
ltran_conn.AutoCommit = False
ltran_conn.DBParm = "ConnectString='DSN="+ls_db+";UID="+ls_user+";PWD="+ls_pass+"'"

Connect Using ltran_conn ;
If ltran_conn.SQLCode = -1 Then
	MessageBox('Warning','Connect Database Error' + ltran_conn.SQLErrText)
Else
	MessageBox('Warning',"Connect Success!")
End If

Disconnect Using ltran_conn ;

end event

