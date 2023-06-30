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
// ��Ƽ�� �����
  Multiview1.HideMaster;
end;

procedure TMainForm.NewMemo_ButtonClick(Sender: TObject);
begin
//���� �̵��ϸ鼭 �޸���,�̹������� ǥ���Ѵ�.
 TabControl1.SetActiveTabWithTransitionAsync(TabItem2,TTabTransition.Slide,TTabTransitionDirection.Normal,Procedure
   begin
       EditPanel.Height := oldheight;
       memo.lines.clear;
       ImageClear_ButtonClick(Sender);
   end);

end;
procedure TMainForm.Button2Click(Sender: TObject);
begin
//��Ƽ�� ǥ��
  multiview1.ShowMaster;
end;

procedure TMainForm.Prior_ButtonClick(Sender: TObject);
begin
  Tabcontrol1.ActiveTab := Tabitem1;
//�����е���ǥ��
  InitListView;
//�̹��� Ŭ����
  ImageClear_ButtonClick(sender);
end;

procedure TMainForm.Save_ButtonClick(Sender: TObject);
var
   str      : string;
   MemoText : TStrings;
begin
    // �ؽ�Ʈ ���Ϸ� ������ ������ ���� TStringList ����
    MemoText := TStringList.Create;
    // �޸��忡 �����Ͱ� �ϳ��� ���� ���� �������� ����
    if Memo.Lines.Text = '' then
       raise Exception.Create('�����Ͱ� �ϳ��� �����ϴ�');

    // TMemo�� Lines �Ӽ��� ����Ͽ� �ؽ�Ʈ�� ������
    MemoText.Assign(Memo.Lines);

    if Layout <> nil  then
    begin
    // �̹����� �����ϰ� �����е忡 'Image : ���\�����̸�.jpg'�� �ؽ����� �߰��Ѵ�.

       for var i: Integer := 0 to Layout.ControlsCount - 1 do
          if   Layout.Controls[i] is TImage then
          begin
            str := System.IOUtils.TPath.Combine(FilePath, memo.Lines[0] + '.jpg');
            TImage(Layout.Controls[0]).Bitmap.SaveToFile(str);
            MemoText.Add('Image: ' + str);
          end;
    end;
    // ���� ��ο� .txt ���Ϸ� ����
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
// �޸���, �̹��� �����
  Memo.Lines.Text := '';
  ImageClear_ButtonClick(Sender);
end;

procedure TMainForm.ImageClear_ButtonClick(Sender: TObject);
begin
  if Layout <> nil  then
  begin
  // layout�� �� ���� �ִ� Image ������Ʈ��  �����ϱ� ;
       FreeAndNil(Layout);
  end;
end;

procedure TMainForm.CheckBox1Change(Sender: TObject);
begin
// üũ �ڽ� üũ�� ����ü�� ����� ��üũ�ÿ��� ���� �ƴϰ�.
  if CheckBoX1.IsChecked then
      memo.Textsettings.Font.Style := memo.Textsettings.Font.Style + [TFontStyle.fsBold]
  else
      memo.Textsettings.Font.Style := memo.Textsettings.Font.Style - [TFontStyle.fsBold];
end;

procedure TMainForm.CheckBox2Change(Sender: TObject);
begin
// üũ �ڽ� üũ�� ����ü�� ���¸�ü�� ��üũ�ÿ��� ���¸�ü �ƴϰ�.
 if CheckBoX2.IsChecked then
    memo.Textsettings.Font.Style := memo.Textsettings.Font.Style + [TFontStyle.fsItalic]
  else
    memo.Textsettings.Font.Style := memo.Textsettings.Font.Style - [TFontStyle.fsItalic];
end;

procedure TMainForm.CheckBox3Change(Sender: TObject);
begin
// üũ �ڽ� üũ�� ���ڸ� ����������� ��üũ�ÿ��� �����������.
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
// ���� �׸���� �������� �ʽ��ϴ�.
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
 // ���� �׸��ϴ�.
//  image.Bitmap.Canvas.BeginScene;
//  image.Bitmap.Canvas.DrawEllipse(myrec, 1);
//  image.Bitmap.Canvas.endScene;
// end

end;

procedure TMainForm.ColorComboBox1Change(Sender: TObject);
begin
// ������ ��Ÿ���� ��Ʈ������ ������� �ʰ� �޺��ڽ����� ������ �������� ��Ʈ ���� ����
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
// �˻��ϰ��� �ϴ� ���� �̸��� �ִ� ���ϵ��� ǥ���ϱ�
  InitListView;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
// �ȵ���̵��� ��츸 �ڹ�Ŭ������  permission�� ���ϱ� ���� �Լ� ȣ��
  {$IFDEF ANDROID}
  FPermissionCamera := JStringToString(TJManifest_permission.JavaClass.CAMERA);
  FPermissionReadExternalStorage := JStringToString(TJManifest_permission.JavaClass.READ_EXTERNAL_STORAGE);
  FPermissionWriteExternalStorage := JStringToString(TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE);
  {$ENDIF}
  // ��ť��Ʈ ������ ��α��ϱ�, Ư�� �������� ���� ��ť��Ʈ ���������� �б�/���� �Ҽ� ����
  FilePath :=  System.IOUtils.TPath.GetDocumentsPath;
  // �����е� ��� ����Ʈ�� ǥ���ϱ�
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
//Ű���� ǥ�ý� panel ������ �����ϱ�
   OldHeight := EditPanel.height;
   EditPanel.Height := Bounds.Top - 50 ;
end;

procedure TMainForm.InitListView;
var
//TSearchRec�� FindFirst�� FindNext�� �˻��Ǵ� ���� ������ ����.
//TSearchRec ������ FindFirst �Ǵ� FindNext �Լ� ȣ��� �˻��� ���� ������ ����.
//������ �߰ߵǸ� TSearchRec ���� �Ű������� �ʵ尡 �����Ǿ� �߰ߵ� ������ ����.
 SearchRec : TSearchRec;
 Storage : String;
 Item: TListViewitem;
begin
  ListView1.items.Clear;
// .txt�� �ش��ϴ� ���ϵ��� ���ǥ���ϱ�
  Storage := System.IOUtils.TPath.Combine(Filepath, '*.txt');
  if FindFirst(Storage, faAnyfile, SearchRec) = 0 then
    begin
      repeat
        // �˻��ϴ� ������ ���ų�, ��Ͽ��� �˻��ϴ� ������ �̸��� �ִ� ���
        if (Edit1.Text = '') or (pos(Edit1.Text, SearchRec.Name) > 0)  then
        begin
          Item := ListView1.Items.Add;
          // .txt Ȯ���ڸ� �����ϰ� ���� �̸��� ǥ��
          Item.Text :=  ChangeFileExt(SearchRec.Name, '');
          Item.Detail := DateTimeToStr(SearchRec.TimeStamp);
        end;
      until FindNext(SearchRec) <> 0;
    end;
  FindClose(SearchRec);
end;

procedure TMainForm.ListBoxItem1Click(Sender: TObject);
begin
// ��Ͽ��� üũ�ڽ����� üũ���� Ǯ���ֱ�
   for var I :integer := 0  to ListView1.Items.Count -1  do
       if ListView1.Items[I].Checked  then
          ListView1.Items[i].Checked := False;
end;

procedure TMainForm.ListBoxItem2Click(Sender: TObject);
var
  FileName: string;
  str     : string;
begin
// üũ �Ǿ� �ִ� ���� �����ϱ� ������Ʈ���ϻӸ� �ƴ϶�
// ���� �̸��� �̹��� ������ �ִ��� Ȯ���� �̹��� ���ϵ� �����Ѵ�.

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
//�������� ��ȯ�ϰ� üũ�ڽ� ǥ���ϱ�
  ListView1.EditMode :=  true;
  for var I:integer := 0 to ListView1.Items.Count - 1 do
      ListView1.Items[I].Checked := True;
end;


procedure TMainForm.ListBoxItem4Click(Sender: TObject);
begin
//��� ��ȯ�ϱ�
   ListView1.EditMode := not ListView1.EditMode;
end;


procedure TMainForm.ListView1DeletingItem(Sender: TObject; AIndex: Integer;
  var ACanDelete: Boolean);
var
  str :string;
  FileName : string;
begin
//   TDialogService.MessageDialog('���� ���� �Ͻðڽ��ϱ�?', TMsgDlgType.mtConfirmation,
//    [TMsgDlgBtn.mbOK,TMsgDlgBtn.mbCancel], TMsgDlgBtn.mbOK, 0,
//    procedure(const AResult: TModalResult)
//    begin
//    ��ȭ ���ڰ� ���� �� ����Ǵ� �ݹ� �Լ�
//      if AResult = mrOK then
//       begin
// �����е� ���� ����� ���� �ش����� �̸��� �̹��� ������ �ִ���
// Ȯ���� ���� �Ѵ�.
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
//������忡���� ��ƾ �������� ����
  if ListView1.EditMode then
     exit;
//���� ������ �̵��ϸ鼭  �ش� ������ ǥ���ϰ� �̹��� ������ �ִ°�� �̹����� ǥ���Ѵ�.
  TabControl1.SetActiveTabWithTransitionAsync(TabItem2,TTabTransition.Slide,TTabTransitionDirection.Normal,
  Procedure
  begin

  // .txt ���� �б�
    str := Listview1.items[itemIndex].Text + '.txt';
    FileName := system.IOUtils.tpath.Combine(Filepath, str);
    TextAndImageList := TStringList.Create;
    try
      TextAndImageList.LoadFromFile(FileName);
      // �̹��������� ������ ������ �ؽ�Ʈ�� �޸��忡 ǥ��
      Memo.Lines.Clear;
      for var I :integer := 0 to TextAndImageList.Count - 1 do
      begin
          if not TextAndImageList[I].StartsWith('Image: ') then
             Memo.Lines.Add(TextAndImageList[I]);
      end;

      // �ؽ�Ʈ�� 'Image: ' �̷� �ؽ�Ʈ�� ������ �̹��� ������ ���,�̸��� ���ؼ� TBitmap�� �����ؼ�
      // �̹����� �ҷ���  ǥ���Ѵ�
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
// ���� �ҷ����� ���� ���ϱ�
// 2 permissions involved: READ_EXTERNAL_STORAGE, WRITE_EXTERNAL_STORAGE
  if (Length(AGrantResults) = 2) and
     (AGrantResults[0] = TPermissionStatus.Granted) and
     (AGrantResults[1] = TPermissionStatus.Granted) then
    TakePhotoFromLibraryAction1.Execute
  else
    TDialogService.ShowMessage('�����ҷ����� ���� �ȵ�');

end;

procedure TMainForm.MemoChangeTracking(Sender: TObject);
begin
//�޸��� �ؽ�Ʈ�� ����� �� �߻��ϴ� �̺�Ʈ.
//CaretPosition�� ����Ͽ� �޸� ��Ʈ�ѿ��� Ŀ��(������)�� ��ǥ�� �����մϴ�.
//TCaretPosition �������� Line �� Pos ���� �ʵ尡 �ֽ��ϴ�.
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
// ���� ��Ÿ���� �ƴ� ������ ��Ʈ ������� �����Ѵ�.
  Memo.StyledSettings := Memo.StyledSettings - [TStyledSetting.Size];
  Memo.TextSettings.Font.Size := SpinBox1.value;
end;

procedure TMainForm.TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
begin
// Tlayout,TImage ������Ʈ�� �������� �����Ͽ� �޸��忡 �߰��Ѵ�.
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
//�޸����� Ư�� ��ġ��  Layout ������Ʈ�� �߰��Ѵ�.
  Layout.position.x := Memo.CaretPosition.pos + 30;
  Layout.Position.Y := Memo.CaretPosition.Line + 30;
  Memo.AddObject(Layout);
end;

procedure TMainForm.TakePicturePermissionRequestResult(Sender: TObject;
  const APermissions: TClassicStringDynArray;
  const AGrantResults: TClassicPermissionStatusDynArray);
begin
//�������� �����ϱ�
    if (Length(AGrantResults) = 3) and
     (AGrantResults[0] = TPermissionStatus.Granted) and
     (AGrantResults[1] = TPermissionStatus.Granted) and
     (AGrantResults[2] = TPermissionStatus.Granted) then
    TakePhotoFromCameraAction1.Execute
  else
    TDialogService.ShowMessage('���� ��� ���� �ȵ�');
end;

end.
