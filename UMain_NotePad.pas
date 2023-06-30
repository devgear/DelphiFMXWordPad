unit UMAIN_NOTEPAD;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.MultiView, FMX.Edit, FMX.SearchBox,
  FMX.Layouts, FMX.ListBox, FMX.StdCtrls, FMX.TabControl,FMX.Memo, FMX.ExtCtrls,
  FMX.MediaLibrary.Actions, System.Actions, FMX.ActnList, FMX.StdActns,
  System.IOUtils,FMX.Platform,System.Rtti, fmx.Objects,
  FMX.Effects,system.UIConsts, system.Permissions, FMX.Menus,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.EditBox, FMX.NumberBox, FMX.Colors, FMX.Memo.Types,
  FMX.ScrollBox, FMX.SpinBox, FMX.Surfaces,FMX.TextLayout, System.NetEncoding,
  Data.Bind.GenData, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.ObjectScope, FMX.Gestures, FMX.Ani;


type

  TMainForm = class(TForm)
    StyleBook1: TStyleBook;
    Layout1: TLayout;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    ToolBar1: TToolBar;
    Panel1: TPanel;
    NewMemo_Button: TButton;
    Panel2: TPanel;
    Button2: TButton;
    ToolBar2: TToolBar;
    Prior_Button: TButton;
    Button4: TButton;
    Save_Button: TButton;
    EditPanel: TPanel;
    TakeCamera_Button: TButton;
    ActionList1: TActionList;
    TakePhotoFromLibraryAction1: TTakePhotoFromLibraryAction;
    TakePhotoFromCameraAction1: TTakePhotoFromCameraAction;
    ShowShareSheetAction1: TShowShareSheetAction;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    ClearMemo_Button: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    ColorComboBox1: TColorComboBox;
    Memo: TMemo;
    SpinBox1: TSpinBox;
    Panel4: TPanel;
    Edit1: TEdit;
    FromLibrary_Button: TButton;
    ImageClear_Button: TButton;
    MultiView1: TMultiView;
    ToolBar3: TToolBar;
    Text1: TText;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    Button10: TButton;
    ShadowEffect1: TShadowEffect;
    ListBoxItem4: TListBoxItem;
    ListView1: TListView;
    PrototypeBindSource1: TPrototypeBindSource;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    GestureManager1: TGestureManager;
    NextTabAction1: TNextTabAction;
    PreviousTabAction1: TPreviousTabAction;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    procedure NewMemo_ButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Prior_ButtonClick(Sender: TObject);
    procedure Save_ButtonClick(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure CheckBox3Change(Sender: TObject);
    procedure ClearMemo_ButtonClick(Sender: TObject);
    procedure ColorComboBox1Change(Sender: TObject);
    procedure SpinBox1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure TakeCamera_ButtonClick(Sender: TObject);
    procedure TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure MemoChangeTracking(Sender: TObject);
    procedure CheckBox4Change(Sender: TObject);
    procedure ImageClear_ButtonClick(Sender: TObject);
    procedure FromLibrary_ButtonClick(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ListBoxItem3Click(Sender: TObject);
    procedure ListBoxItem2Click(Sender: TObject);
    procedure ListBoxItem1Click(Sender: TObject);
    procedure ListBoxItem4Click(Sender: TObject);
    procedure ListView1ItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure ListView1DeletingItem(Sender: TObject; AIndex: Integer;
      var ACanDelete: Boolean);

  private
    FCursorPos: TPointF;
    FPermissionCamera,
    FPermissionReadExternalStorage,
    FPermissionWriteExternalStorage: string;
    procedure DisplayRationale(Sender: TObject; const APermissions: TClassicStringDynArray; const APostRationaleProc: TProc);
    procedure LoadPicturePermissionRequestResult(Sender: TObject; const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray);
    procedure TakePicturePermissionRequestResult(Sender: TObject; const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray);

    { Private declarations }
    Procedure InitListView;
  public
//    property CursorPos: TPointF read FCursorPos;
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
uses
{$IFDEF ANDROID}
  Androidapi.Helpers,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Os,
{$ENDIF}
  FMX.DialogService,
   EncdDecd;


var
  FilePath : string;
  Memo : TMemo;
  MyImage : TImage;
  Layout : TLayout;
  OldHeight : single;

{$R *.fmx}

procedure TMainForm.Button10Click(Sender: TObject);
begin
// 멀티뷰 숨기기
  Multiview1.HideMaster;
end;

procedure TMainForm.NewMemo_ButtonClick(Sender: TObject);
begin
//탭을 이동하면서 메모장,이미지등을 표시한다.
 TabControl1.SetActiveTabWithTransitionAsync(TabItem2,TTabTransition.Slide,TTabTransitionDirection.Normal,Procedure
   begin
       EditPanel.Height := oldheight;
       memo.lines.clear;
       ImageClear_ButtonClick(Sender);
   end);

end;
procedure TMainForm.Button2Click(Sender: TObject);
begin
//멀티뷰 표시
  multiview1.ShowMaster;
end;

procedure TMainForm.Prior_ButtonClick(Sender: TObject);
begin
  Tabcontrol1.ActiveTab := Tabitem1;
//워드패드목록표시
  InitListView;
//이미지 클리어
  ImageClear_ButtonClick(sender);
end;

procedure TMainForm.Save_ButtonClick(Sender: TObject);
var
   str      : string;
   MemoText : TStrings;
begin
    // 텍스트 파일로 저장할 내용을 담을 TStringList 생성
    MemoText := TStringList.Create;
    // 메모장에 데이터가 하나도 없는 경우는 저장하지 않음
    if Memo.Lines.Text = '' then
       raise Exception.Create('데이터가 하나도 없습니다');

    // TMemo의 Lines 속성을 사용하여 텍스트를 가져옴
    MemoText.Assign(Memo.Lines);

    if Layout <> nil  then
    begin
    // 이미지를 저장하고 워드패드에 'Image : 경로\파일이름.jpg'로 텍스츠를 추가한다.

       for var i: Integer := 0 to Layout.ControlsCount - 1 do
          if   Layout.Controls[i] is TImage then
          begin
            str := System.IOUtils.TPath.Combine(FilePath, memo.Lines[0] + '.jpg');
            TImage(Layout.Controls[0]).Bitmap.SaveToFile(str);
            MemoText.Add('Image: ' + str);
          end;
    end;
    // 지정 경로에 .txt 파일로 저장
    str := system.IOUtils.tpath.Combine(FilePath, memo.Lines[0]+'.txt');
    MemoText.SaveToFile(str);
    MemoText.Free;

end;

procedure TMainForm.TakeCamera_ButtonClick(Sender: TObject);
begin
 PermissionsService.RequestPermissions([FPermissionCamera, FPermissionReadExternalStorage, FPermissionWriteExternalStorage], TakePicturePermissionRequestResult, DisplayRationale);
end;

procedure TMainForm.FromLibrary_ButtonClick(Sender: TObject);
begin
    PermissionsService.RequestPermissions([FPermissionReadExternalStorage, FPermissionWriteExternalStorage], LoadPicturePermissionRequestResult, DisplayRationale);
end;

procedure TMainForm.ClearMemo_ButtonClick(Sender: TObject);
begin
// 메모장, 이미지 지우기
  Memo.Lines.Text := '';
  ImageClear_ButtonClick(Sender);
end;

procedure TMainForm.ImageClear_ButtonClick(Sender: TObject);
begin
  if Layout <> nil  then
  begin
  // layout과 그 위에 있는 Image 컴포넌트등  해제하기 ;
       FreeAndNil(Layout);
  end;
end;

procedure TMainForm.CheckBox1Change(Sender: TObject);
begin
// 체크 박스 체크시 글자체를 볼드로 넌체크시에는 볼드 아니게.
  if CheckBoX1.IsChecked then
      memo.Textsettings.Font.Style := memo.Textsettings.Font.Style + [TFontStyle.fsBold]
  else
      memo.Textsettings.Font.Style := memo.Textsettings.Font.Style - [TFontStyle.fsBold];
end;

procedure TMainForm.CheckBox2Change(Sender: TObject);
begin
// 체크 박스 체크시 글자체를 이태릭체로 넌체크시에는 이태릭체 아니게.
 if CheckBoX2.IsChecked then
    memo.Textsettings.Font.Style := memo.Textsettings.Font.Style + [TFontStyle.fsItalic]
  else
    memo.Textsettings.Font.Style := memo.Textsettings.Font.Style - [TFontStyle.fsItalic];
end;

procedure TMainForm.CheckBox3Change(Sender: TObject);
begin
// 체크 박스 체크시 글자를 언더라인으로 넌체크시에는 언더라인해제.
 if CheckBoX3.IsChecked then
      memo.Textsettings.Font.Style := memo.Textsettings.Font.Style + [TFontStyle.fsUnderline]
  else
      memo.Textsettings.Font.Style := memo.Textsettings.Font.Style - [TFontStyle.fsUnderLine];
end;

procedure TMainForm.CheckBox4Change(Sender: TObject);
var
  MyRec : TRectF;
  CursorPos: TPointF;
  image : TImage;
  x1,x2,y1,y2: integer;
  bitmap : tbitmap;
// 도형 그리기는 구현하지 않습니다.
begin
//  if CheckBox4.ischecked then
// begin
//     cursorpos := self.CursorPos;
//  Image := TImage.Create(memo);
//  image.Width := 30;
//  image.Height := 30;

//  Bitmap := TBitmap.Create(round(image.width), round(image.Height));
//  Image.Bitmap := bitmap;
//  image.Parent := memo;
//  image.Position.X := cursorpos.X;
//  image.Position.Y := CursorPos.Y;
//  bitmap.free;

//  x1 := 8;
//  x2 := image.bitmap.Canvas.Width - 8;
//  y1 := 8;
//  y2 := image.Bitmap.Canvas.Height- 8;
//  MyRec := TRectF.Create( x1, y1, x2, y2);

//  image.bitmap.Canvas.Stroke.Color := clared;
 // 원을 그립니다.
//  image.Bitmap.Canvas.BeginScene;
//  image.Bitmap.Canvas.DrawEllipse(myrec, 1);
//  image.Bitmap.Canvas.endScene;
// end

end;

procedure TMainForm.ColorComboBox1Change(Sender: TObject);
begin
// 기존의 스타일의 폰트색상을 사용하지 않고 콤보박스에서 지정한 색상으로 폰트 색상 변경
  memo.StyledSettings := memo.styledsettings - [TStyledSetting.FontColor];
  memo.Textsettings.fontcolor := ColorCombobox1.Color;
end;

procedure TMainForm.DisplayRationale(Sender: TObject;
  const APermissions: TClassicStringDynArray; const APostRationaleProc: TProc);
var
  I: Integer;
  RationaleMsg: string;
begin
  for I := 0 to High(APermissions) do
  begin
    if APermissions[I] = FPermissionCamera then
      RationaleMsg := RationaleMsg + 'The app needs to access the camera to take a photo' + SLineBreak + SLineBreak
    else if APermissions[I] = FPermissionReadExternalStorage then
      RationaleMsg := RationaleMsg + 'The app needs to load photo files from your device';
  end;

  // Show an explanation to the user *asynchronously* - don't block this thread waiting for the user's response!
  // After the user sees the explanation, invoke the post-rationale routine to request the permissions
  TDialogService.ShowMessage(RationaleMsg,
    procedure(const AResult: TModalResult)
    begin
      APostRationaleProc;
    end)
 end;

procedure TMainForm.Edit1Change(Sender: TObject);
begin
// 검색하고자 하는 파일 이름이 있는 파일들을 표시하기
  InitListView;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
// 안드로이드인 경우만 자바클래스의  permission을 구하기 위한 함수 호출
  {$IFDEF ANDROID}
  FPermissionCamera := JStringToString(TJManifest_permission.JavaClass.CAMERA);
  FPermissionReadExternalStorage := JStringToString(TJManifest_permission.JavaClass.READ_EXTERNAL_STORAGE);
  FPermissionWriteExternalStorage := JStringToString(TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE);
  {$ENDIF}
  // 도큐먼트 폴더의 경로구하기, 특히 아이폰의 경우는 도큐먼트 폴더에서만 읽기/쓰기 할수 있음
  FilePath :=  System.IOUtils.TPath.GetDocumentsPath;
  // 워드패드 목록 리스트에 표시하기
  InitListView;
  Oldheight := EditPanel.Height;
  SpinBox1.value := Memo.TextSettings.Font.Size;
  TabControl1.ActiveTab := TabItem1;
 end;
 
procedure TMainForm.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  EditPanel.Height := OldHeight;
end;

procedure TMainForm.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
//키보드 표시시 panel 사이즈 조절하기
   OldHeight := EditPanel.height;
   EditPanel.Height := Bounds.Top - 50 ;
end;

procedure TMainForm.InitListView;
var
//TSearchRec은 FindFirst나 FindNext로 검색되는 파일 정보를 정의.
//TSearchRec 유형은 FindFirst 또는 FindNext 함수 호출로 검색된 파일 정보를 정의.
//파일이 발견되면 TSearchRec 유형 매개변수의 필드가 수정되어 발견된 파일을 지정.
 SearchRec : TSearchRec;
 Storage : String;
 Item: TListViewitem;
begin
  ListView1.items.Clear;
// .txt에 해당하는 파일들의 목록표시하기
  Storage := System.IOUtils.TPath.Combine(Filepath, '*.txt');
  if FindFirst(Storage, faAnyfile, SearchRec) = 0 then
    begin
      repeat
        // 검색하는 파일이 없거나, 목록에서 검색하는 파일의 이름이 있는 경우
        if (Edit1.Text = '') or (pos(Edit1.Text, SearchRec.Name) > 0)  then
        begin
          Item := ListView1.Items.Add;
          // .txt 확장자를 제거하고 파일 이름만 표시
          Item.Text :=  ChangeFileExt(SearchRec.Name, '');
          Item.Detail := DateTimeToStr(SearchRec.TimeStamp);
        end;
      until FindNext(SearchRec) <> 0;
    end;
  FindClose(SearchRec);
end;

procedure TMainForm.ListBoxItem1Click(Sender: TObject);
begin
// 목록에서 체크박스에서 체크상태 풀어주기
   for var I :integer := 0  to ListView1.Items.Count -1  do
       if ListView1.Items[I].Checked  then
          ListView1.Items[i].Checked := False;
end;

procedure TMainForm.ListBoxItem2Click(Sender: TObject);
var
  FileName: string;
  str     : string;
begin
// 체크 되어 있는 파일 삭제하기 워드패트파일뿐만 아니라
// 같은 이름의 이미지 파일이 있는지 확인후 이미지 파일도 삭제한다.

  for var I :integer := 0  to ListView1.items.count -1  do
      if ListView1.Items[I].Checked  then
      begin
         str := ListView1.Items[i].Text;
         FileName := System.IOUtils.TPath.Combine(Filepath, str);
         TFile.Delete(FileName+'.txt');
         if FileExists(FileName+'.jpg') then
            TFile.Delete(FileName+'.jpg');
      end;

   InitListView;
end;

procedure TMainForm.ListBoxItem3Click(Sender: TObject);
begin
//편집모드로 전환하고 체크박스 표시하기
  ListView1.EditMode :=  true;
  for var I:integer := 0 to ListView1.Items.Count - 1 do
      ListView1.Items[I].Checked := True;
end;


procedure TMainForm.ListBoxItem4Click(Sender: TObject);
begin
//모드 전환하기
   ListView1.EditMode := not ListView1.EditMode;
end;


procedure TMainForm.ListView1DeletingItem(Sender: TObject; AIndex: Integer;
  var ACanDelete: Boolean);
var
  str :string;
  FileName : string;
begin
//   TDialogService.MessageDialog('정말 삭제 하시겠습니까?', TMsgDlgType.mtConfirmation,
//    [TMsgDlgBtn.mbOK,TMsgDlgBtn.mbCancel], TMsgDlgBtn.mbOK, 0,
//    procedure(const AResult: TModalResult)
//    begin
//    대화 상자가 닫힐 때 실행되는 콜백 함수
//      if AResult = mrOK then
//       begin
// 워드패드 파일 지우기 전에 해당파일 이름의 이미지 파일이 있는지
// 확인후 삭제 한다.
         str := ListView1.Items[Aindex].Text;
         FileName := System.IOUtils.TPath.Combine(Filepath, str);
         TFile.Delete(FileName+'.txt');
         if FileExists(FileName+'.jpg') then
            TFile.Delete(FileName+'.jpg');
//       end;
//    end);
end;

procedure TMainForm.ListView1ItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
var
   str  : string;
   FileName: string;
   TextAndImageList: TStrings;
   ImageFileName: string;
   ImageBitmap: TBitmap;

begin
//편집모드에서는 루틴 수행하지 않음
  if ListView1.EditMode then
     exit;
//다음 탭으로 이동하면서  해당 파일을 표시하고 이미지 파일이 있는경우 이미지도 표시한다.
  TabControl1.SetActiveTabWithTransitionAsync(TabItem2,TTabTransition.Slide,TTabTransitionDirection.Normal,
  Procedure
  begin

  // .txt 파일 읽기
    str := Listview1.items[itemIndex].Text + '.txt';
    FileName := system.IOUtils.tpath.Combine(Filepath, str);
    TextAndImageList := TStringList.Create;
    try
      TextAndImageList.LoadFromFile(FileName);
      // 이미지정보가 나오기 전까지 텍스트를 메모장에 표시
      Memo.Lines.Clear;
      for var I :integer := 0 to TextAndImageList.Count - 1 do
      begin
          if not TextAndImageList[I].StartsWith('Image: ') then
             Memo.Lines.Add(TextAndImageList[I]);
      end;

      // 텍스트상에 'Image: ' 이런 텍스트가 있으면 이미지 파일의 경로,이름을 구해서 TBitmap을 생성해서
      // 이미지를 불러와  표시한다
      for var I :integer := 0 to TextAndImageList.Count - 1 do
      begin
        if TextAndImageList[I].StartsWith('Image: ') then
        begin
           ImageFileName := TextAndImageList[I].Substring(7);
           ImageBitmap := TBitmap.Create;
           try
             ImageBitmap.LoadFromFile(ImageFileName);
             Memo.lines.add(' ');
             TakePhotoFromCameraAction1DidFinishTaking(ImageBitmap);
           finally
             ImageBitmap.Free;
           end;
       end;
    end;
  finally
    TextAndImageList.Free;
  end;
end);
end;

procedure TMainForm.LoadPicturePermissionRequestResult(Sender: TObject;
  const APermissions: TClassicStringDynArray;
  const AGrantResults: TClassicPermissionStatusDynArray);
begin
// 사진 불러오기 승인 구하기
// 2 permissions involved: READ_EXTERNAL_STORAGE, WRITE_EXTERNAL_STORAGE
  if (Length(AGrantResults) = 2) and
     (AGrantResults[0] = TPermissionStatus.Granted) and
     (AGrantResults[1] = TPermissionStatus.Granted) then
    TakePhotoFromLibraryAction1.Execute
  else
    TDialogService.ShowMessage('사진불러오기 승인 안됨');

end;

procedure TMainForm.MemoChangeTracking(Sender: TObject);
begin
//메모의 텍스트가 변경될 때 발생하는 이벤트.
//CaretPosition을 사용하여 메모 컨트롤에서 커서(삽입점)의 좌표를 결정합니다.
//TCaretPosition 유형에는 Line 및 Pos 정수 필드가 있습니다.
  fCursorPos.x := Memo.CaretPosition.pos;
  fCursorPos.Y := Memo.CaretPosition.Line;
end;

procedure TMainForm.MenuItem1Click(Sender: TObject);
begin
  PermissionsService.RequestPermissions([FPermissionReadExternalStorage, FPermissionWriteExternalStorage], LoadPicturePermissionRequestResult, DisplayRationale);
end;

procedure TMainForm.MenuItem2Click(Sender: TObject);
begin
  PermissionsService.RequestPermissions([FPermissionCamera, FPermissionReadExternalStorage, FPermissionWriteExternalStorage], TakePicturePermissionRequestResult, DisplayRationale);
end;

procedure TMainForm.SpinBox1Change(Sender: TObject);
begin
// 기존 스타일인 아닌 지정한 폰트 사이즈로 변경한다.
  Memo.StyledSettings := Memo.StyledSettings - [TStyledSetting.Size];
  Memo.TextSettings.Font.Size := SpinBox1.value;
end;

procedure TMainForm.TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
begin
// Tlayout,TImage 컴포넌트를 동적으로 생성하여 메모장에 추가한다.
  ImageClear_ButtonClick(ImageClear_Button);
  Layout := TLayout.create(nil);
  Layout.Parent := Memo;
  Layout.width := Image.width;
  Layout.Height := Image.height;
  MyImage := TImage.Create(Layout);
  Myimage.Parent := Layout;
  MyImage.Align :=  TAlignLayout.client;
  MyImage.Bitmap.assign(Image);
  Layout.AddObject(MyImage);
//메모장의 특정 위치에  Layout 컴포넌트를 추가한다.
  Layout.position.x := Memo.CaretPosition.pos + 30;
  Layout.Position.Y := Memo.CaretPosition.Line + 30;
  Memo.AddObject(Layout);
end;

procedure TMainForm.TakePicturePermissionRequestResult(Sender: TObject;
  const APermissions: TClassicStringDynArray;
  const AGrantResults: TClassicPermissionStatusDynArray);
begin
//사진찎기 승인하기
    if (Length(AGrantResults) = 3) and
     (AGrantResults[0] = TPermissionStatus.Granted) and
     (AGrantResults[1] = TPermissionStatus.Granted) and
     (AGrantResults[2] = TPermissionStatus.Granted) then
    TakePhotoFromCameraAction1.Execute
  else
    TDialogService.ShowMessage('사진 찍기 승인 안됨');
end;

end.
