object FScrapix: TFScrapix
  Left = 0
  Top = 0
  Caption = 'Scrapix'
  ClientHeight = 494
  ClientWidth = 778
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object BoxMain: TscPanel
    Left = 0
    Top = 0
    Width = 778
    Height = 31
    Align = alTop
    FluentUIOpaque = False
    TabOrder = 0
    CustomImageIndex = -1
    DragForm = False
    DragTopForm = True
    StyleKind = scpsPanel
    ShowCaption = False
    BorderStyle = scpbsNone
    WallpaperIndex = -1
    LightBorderColor = clBtnHighlight
    ShadowBorderColor = clBtnShadow
    CaptionGlowEffect.Enabled = False
    CaptionGlowEffect.Color = clBtnShadow
    CaptionGlowEffect.AlphaValue = 255
    CaptionGlowEffect.GlowSize = 7
    CaptionGlowEffect.Offset = 0
    CaptionGlowEffect.Intensive = True
    CaptionGlowEffect.StyleColors = True
    StorePaintBuffer = False
    WordWrap = False
    object BtnStart: TscButton
      AlignWithMargins = True
      Left = 399
      Top = 3
      Width = 80
      Height = 25
      Align = alRight
      FluentUIOpaque = False
      TabOrder = 0
      TabStop = True
      OnClick = BtnStartClick
      Animation = False
      Caption = 'D'#233'marrer'
      CaptionCenterAlignment = False
      CanFocused = True
      CustomDropDown = False
      Margin = -1
      Spacing = 1
      Layout = blGlyphLeft
      ImageIndex = -1
      ImageMargin = 0
      TransparentBackground = True
      ColorOptions.NormalColor = clBtnFace
      ColorOptions.HotColor = clBtnFace
      ColorOptions.PressedColor = clBtnShadow
      ColorOptions.FocusedColor = clBtnFace
      ColorOptions.DisabledColor = clBtnFace
      ColorOptions.FrameNormalColor = clBtnShadow
      ColorOptions.FrameHotColor = clHighlight
      ColorOptions.FramePressedColor = clHighlight
      ColorOptions.FrameFocusedColor = clHighlight
      ColorOptions.FrameDisabledColor = clBtnShadow
      ColorOptions.FrameWidth = 1
      ColorOptions.FontNormalColor = clBtnText
      ColorOptions.FontHotColor = clBtnText
      ColorOptions.FontPressedColor = clBtnText
      ColorOptions.FontFocusedColor = clBtnText
      ColorOptions.FontDisabledColor = clBtnShadow
      ColorOptions.TitleFontNormalColor = clBtnText
      ColorOptions.TitleFontHotColor = clBtnText
      ColorOptions.TitleFontPressedColor = clBtnText
      ColorOptions.TitleFontFocusedColor = clBtnText
      ColorOptions.TitleFontDisabledColor = clBtnShadow
      ColorOptions.StyleColors = True
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -18
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = [fsBold]
      ToggleMode = False
      HotImageIndex = -1
      FocusedImageIndex = -1
      PressedImageIndex = -1
      StyleKind = scbsPushButton
      UseGalleryMenuImage = False
      UseGalleryMenuCaption = False
      CustomImageNormalIndex = -1
      CustomImageHotIndex = -1
      CustomImagePressedIndex = -1
      CustomImageDisabledIndex = -1
      CustomImageFocusedIndex = -1
      ScaleMarginAndSpacing = False
      WidthWithCaption = 0
      WidthWithoutCaption = 0
      UseFontColorToStyleColor = False
      RepeatClick = False
      RepeatClickInterval = 100
      GlowEffect.Enabled = False
      GlowEffect.Color = clHighlight
      GlowEffect.AlphaValue = 255
      GlowEffect.GlowSize = 7
      GlowEffect.Offset = 0
      GlowEffect.Intensive = True
      GlowEffect.StyleColors = True
      GlowEffect.HotColor = clNone
      GlowEffect.PressedColor = clNone
      GlowEffect.FocusedColor = clNone
      GlowEffect.PressedGlowSize = 7
      GlowEffect.PressedAlphaValue = 255
      GlowEffect.States = [scsHot, scsPressed, scsFocused]
      ImageGlow = True
      ShowGalleryMenuFromTop = False
      ShowGalleryMenuFromRight = False
      ShowMenuArrow = True
      SplitButton = False
      ShowFocusRect = False
      Down = False
      GroupIndex = 0
      AllowAllUp = False
    end
    object BtnBreak: TscButton
      AlignWithMargins = True
      Left = 485
      Top = 3
      Width = 80
      Height = 25
      Align = alRight
      FluentUIOpaque = False
      TabOrder = 1
      TabStop = True
      OnClick = BtnBreakClick
      Animation = False
      Caption = 'Pause'
      CaptionCenterAlignment = False
      CanFocused = True
      CustomDropDown = False
      Margin = -1
      Spacing = 1
      Layout = blGlyphLeft
      ImageIndex = -1
      ImageMargin = 0
      TransparentBackground = True
      ColorOptions.NormalColor = clBtnFace
      ColorOptions.HotColor = clBtnFace
      ColorOptions.PressedColor = clBtnShadow
      ColorOptions.FocusedColor = clBtnFace
      ColorOptions.DisabledColor = clBtnFace
      ColorOptions.FrameNormalColor = clBtnShadow
      ColorOptions.FrameHotColor = clHighlight
      ColorOptions.FramePressedColor = clHighlight
      ColorOptions.FrameFocusedColor = clHighlight
      ColorOptions.FrameDisabledColor = clBtnShadow
      ColorOptions.FrameWidth = 1
      ColorOptions.FontNormalColor = clBtnText
      ColorOptions.FontHotColor = clBtnText
      ColorOptions.FontPressedColor = clBtnText
      ColorOptions.FontFocusedColor = clBtnText
      ColorOptions.FontDisabledColor = clBtnShadow
      ColorOptions.TitleFontNormalColor = clBtnText
      ColorOptions.TitleFontHotColor = clBtnText
      ColorOptions.TitleFontPressedColor = clBtnText
      ColorOptions.TitleFontFocusedColor = clBtnText
      ColorOptions.TitleFontDisabledColor = clBtnShadow
      ColorOptions.StyleColors = True
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -18
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = [fsBold]
      ToggleMode = False
      HotImageIndex = -1
      FocusedImageIndex = -1
      PressedImageIndex = -1
      StyleKind = scbsPushButton
      UseGalleryMenuImage = False
      UseGalleryMenuCaption = False
      CustomImageNormalIndex = -1
      CustomImageHotIndex = -1
      CustomImagePressedIndex = -1
      CustomImageDisabledIndex = -1
      CustomImageFocusedIndex = -1
      ScaleMarginAndSpacing = False
      WidthWithCaption = 0
      WidthWithoutCaption = 0
      UseFontColorToStyleColor = False
      RepeatClick = False
      RepeatClickInterval = 100
      GlowEffect.Enabled = False
      GlowEffect.Color = clHighlight
      GlowEffect.AlphaValue = 255
      GlowEffect.GlowSize = 7
      GlowEffect.Offset = 0
      GlowEffect.Intensive = True
      GlowEffect.StyleColors = True
      GlowEffect.HotColor = clNone
      GlowEffect.PressedColor = clNone
      GlowEffect.FocusedColor = clNone
      GlowEffect.PressedGlowSize = 7
      GlowEffect.PressedAlphaValue = 255
      GlowEffect.States = [scsHot, scsPressed, scsFocused]
      ImageGlow = True
      ShowGalleryMenuFromTop = False
      ShowGalleryMenuFromRight = False
      ShowMenuArrow = True
      SplitButton = False
      ShowFocusRect = False
      Down = False
      GroupIndex = 0
      AllowAllUp = False
    end
    object BtnStop: TscButton
      AlignWithMargins = True
      Left = 571
      Top = 3
      Width = 80
      Height = 25
      Align = alRight
      FluentUIOpaque = False
      TabOrder = 2
      TabStop = True
      OnClick = BtnStopClick
      Animation = False
      Caption = 'Arreter'
      CaptionCenterAlignment = False
      CanFocused = True
      CustomDropDown = False
      Margin = -1
      Spacing = 1
      Layout = blGlyphLeft
      ImageIndex = -1
      ImageMargin = 0
      TransparentBackground = True
      ColorOptions.NormalColor = clBtnFace
      ColorOptions.HotColor = clBtnFace
      ColorOptions.PressedColor = clBtnShadow
      ColorOptions.FocusedColor = clBtnFace
      ColorOptions.DisabledColor = clBtnFace
      ColorOptions.FrameNormalColor = clBtnShadow
      ColorOptions.FrameHotColor = clHighlight
      ColorOptions.FramePressedColor = clHighlight
      ColorOptions.FrameFocusedColor = clHighlight
      ColorOptions.FrameDisabledColor = clBtnShadow
      ColorOptions.FrameWidth = 1
      ColorOptions.FontNormalColor = clBtnText
      ColorOptions.FontHotColor = clBtnText
      ColorOptions.FontPressedColor = clBtnText
      ColorOptions.FontFocusedColor = clBtnText
      ColorOptions.FontDisabledColor = clBtnShadow
      ColorOptions.TitleFontNormalColor = clBtnText
      ColorOptions.TitleFontHotColor = clBtnText
      ColorOptions.TitleFontPressedColor = clBtnText
      ColorOptions.TitleFontFocusedColor = clBtnText
      ColorOptions.TitleFontDisabledColor = clBtnShadow
      ColorOptions.StyleColors = True
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -18
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = [fsBold]
      ToggleMode = False
      HotImageIndex = -1
      FocusedImageIndex = -1
      PressedImageIndex = -1
      StyleKind = scbsPushButton
      UseGalleryMenuImage = False
      UseGalleryMenuCaption = False
      CustomImageNormalIndex = -1
      CustomImageHotIndex = -1
      CustomImagePressedIndex = -1
      CustomImageDisabledIndex = -1
      CustomImageFocusedIndex = -1
      ScaleMarginAndSpacing = False
      WidthWithCaption = 0
      WidthWithoutCaption = 0
      UseFontColorToStyleColor = False
      RepeatClick = False
      RepeatClickInterval = 100
      GlowEffect.Enabled = False
      GlowEffect.Color = clHighlight
      GlowEffect.AlphaValue = 255
      GlowEffect.GlowSize = 7
      GlowEffect.Offset = 0
      GlowEffect.Intensive = True
      GlowEffect.StyleColors = True
      GlowEffect.HotColor = clNone
      GlowEffect.PressedColor = clNone
      GlowEffect.FocusedColor = clNone
      GlowEffect.PressedGlowSize = 7
      GlowEffect.PressedAlphaValue = 255
      GlowEffect.States = [scsHot, scsPressed, scsFocused]
      ImageGlow = True
      ShowGalleryMenuFromTop = False
      ShowGalleryMenuFromRight = False
      ShowMenuArrow = True
      SplitButton = False
      ShowFocusRect = False
      Down = False
      GroupIndex = 0
      AllowAllUp = False
    end
    object BtnSettings: TscButton
      AlignWithMargins = True
      Left = 657
      Top = 3
      Width = 25
      Height = 25
      Align = alRight
      FluentUIOpaque = False
      TabOrder = 3
      TabStop = True
      OnClick = BtnSettingsClick
      Animation = False
      CaptionCenterAlignment = False
      CanFocused = True
      CustomDropDown = False
      Margin = -1
      Spacing = 1
      Layout = blGlyphLeft
      Images = ImageList
      ImageIndex = 1
      ImageMargin = 0
      TransparentBackground = True
      ColorOptions.NormalColor = clBtnFace
      ColorOptions.HotColor = clBtnFace
      ColorOptions.PressedColor = clBtnShadow
      ColorOptions.FocusedColor = clBtnFace
      ColorOptions.DisabledColor = clBtnFace
      ColorOptions.FrameNormalColor = clBtnShadow
      ColorOptions.FrameHotColor = clHighlight
      ColorOptions.FramePressedColor = clHighlight
      ColorOptions.FrameFocusedColor = clHighlight
      ColorOptions.FrameDisabledColor = clBtnShadow
      ColorOptions.FrameWidth = 1
      ColorOptions.FontNormalColor = clBtnText
      ColorOptions.FontHotColor = clBtnText
      ColorOptions.FontPressedColor = clBtnText
      ColorOptions.FontFocusedColor = clBtnText
      ColorOptions.FontDisabledColor = clBtnShadow
      ColorOptions.TitleFontNormalColor = clBtnText
      ColorOptions.TitleFontHotColor = clBtnText
      ColorOptions.TitleFontPressedColor = clBtnText
      ColorOptions.TitleFontFocusedColor = clBtnText
      ColorOptions.TitleFontDisabledColor = clBtnShadow
      ColorOptions.StyleColors = True
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -18
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = [fsBold]
      ToggleMode = False
      HotImageIndex = -1
      FocusedImageIndex = -1
      PressedImageIndex = -1
      StyleKind = scbsPushButton
      UseGalleryMenuImage = False
      UseGalleryMenuCaption = False
      CustomImageNormalIndex = -1
      CustomImageHotIndex = -1
      CustomImagePressedIndex = -1
      CustomImageDisabledIndex = -1
      CustomImageFocusedIndex = -1
      ScaleMarginAndSpacing = False
      WidthWithCaption = 0
      WidthWithoutCaption = 0
      ShowCaption = False
      UseFontColorToStyleColor = False
      RepeatClick = False
      RepeatClickInterval = 100
      GlowEffect.Enabled = False
      GlowEffect.Color = clHighlight
      GlowEffect.AlphaValue = 255
      GlowEffect.GlowSize = 7
      GlowEffect.Offset = 0
      GlowEffect.Intensive = True
      GlowEffect.StyleColors = True
      GlowEffect.HotColor = clNone
      GlowEffect.PressedColor = clNone
      GlowEffect.FocusedColor = clNone
      GlowEffect.PressedGlowSize = 7
      GlowEffect.PressedAlphaValue = 255
      GlowEffect.States = [scsHot, scsPressed, scsFocused]
      ImageGlow = True
      ShowGalleryMenuFromTop = False
      ShowGalleryMenuFromRight = False
      ShowMenuArrow = True
      SplitButton = False
      ShowFocusRect = False
      Down = False
      GroupIndex = 0
      AllowAllUp = False
    end
    object EdUrl: TscEdit
      AlignWithMargins = True
      Left = 34
      Top = 3
      Width = 359
      Height = 25
      FluentUIOpaque = False
      UseFontColorToStyleColor = False
      ContentMarginLeft = 0
      ContentMarginRight = 0
      ContentMarginTop = 0
      ContentMarginBottom = 0
      CustomBackgroundImageNormalIndex = -1
      CustomBackgroundImageHotIndex = -1
      CustomBackgroundImageDisabledIndex = -1
      PromptText = 'https://...'
      PromptTextColor = clNone
      HideMaskWithEmptyText = False
      HidePromptTextIfFocused = False
      WallpaperIndex = -1
      LeftButton.ComboButton = False
      LeftButton.Enabled = True
      LeftButton.Visible = False
      LeftButton.ShowHint = False
      LeftButton.ShowEllipses = False
      LeftButton.StyleKind = scbsPushButton
      LeftButton.Width = 18
      LeftButton.ImageIndex = -1
      LeftButton.ImageHotIndex = -1
      LeftButton.ImagePressedIndex = -1
      LeftButton.RepeatClick = False
      LeftButton.RepeatClickInterval = 200
      LeftButton.CustomImageNormalIndex = -1
      LeftButton.CustomImageHotIndex = -1
      LeftButton.CustomImagePressedIndex = -1
      LeftButton.CustomImageDisabledIndex = -1
      RightButton.ComboButton = False
      RightButton.Enabled = True
      RightButton.Visible = False
      RightButton.ShowHint = False
      RightButton.ShowEllipses = False
      RightButton.StyleKind = scbsPushButton
      RightButton.Width = 18
      RightButton.ImageIndex = -1
      RightButton.ImageHotIndex = -1
      RightButton.ImagePressedIndex = -1
      RightButton.RepeatClick = False
      RightButton.RepeatClickInterval = 200
      RightButton.CustomImageNormalIndex = -1
      RightButton.CustomImageHotIndex = -1
      RightButton.CustomImagePressedIndex = -1
      RightButton.CustomImageDisabledIndex = -1
      Transparent = False
      BorderKind = scebFrame
      CustomDraw = False
      FrameColor = clBtnShadow
      FrameActiveColor = clHighlight
      Text = ''
      Align = alClient
      AutoSelect = False
      TabOrder = 4
      ExplicitHeight = 23
    end
    object BtnTranslate: TscButton
      AlignWithMargins = True
      Left = 750
      Top = 3
      Width = 25
      Height = 25
      Align = alRight
      FluentUIOpaque = False
      TabOrder = 5
      TabStop = True
      OnClick = BtnTranslateClick
      Animation = False
      CaptionCenterAlignment = False
      CanFocused = True
      CustomDropDown = False
      Margin = -1
      Spacing = 1
      Layout = blGlyphLeft
      Images = ImageList
      ImageIndex = 2
      ImageMargin = 0
      TransparentBackground = True
      ColorOptions.NormalColor = clBtnFace
      ColorOptions.HotColor = clBtnFace
      ColorOptions.PressedColor = clBtnShadow
      ColorOptions.FocusedColor = clBtnFace
      ColorOptions.DisabledColor = clBtnFace
      ColorOptions.FrameNormalColor = clBtnShadow
      ColorOptions.FrameHotColor = clHighlight
      ColorOptions.FramePressedColor = clHighlight
      ColorOptions.FrameFocusedColor = clHighlight
      ColorOptions.FrameDisabledColor = clBtnShadow
      ColorOptions.FrameWidth = 1
      ColorOptions.FontNormalColor = clBtnText
      ColorOptions.FontHotColor = clBtnText
      ColorOptions.FontPressedColor = clBtnText
      ColorOptions.FontFocusedColor = clBtnText
      ColorOptions.FontDisabledColor = clBtnShadow
      ColorOptions.TitleFontNormalColor = clBtnText
      ColorOptions.TitleFontHotColor = clBtnText
      ColorOptions.TitleFontPressedColor = clBtnText
      ColorOptions.TitleFontFocusedColor = clBtnText
      ColorOptions.TitleFontDisabledColor = clBtnShadow
      ColorOptions.StyleColors = True
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -18
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = [fsBold]
      ToggleMode = False
      HotImageIndex = -1
      FocusedImageIndex = -1
      PressedImageIndex = -1
      StyleKind = scbsPushButton
      UseGalleryMenuImage = False
      UseGalleryMenuCaption = False
      CustomImageNormalIndex = -1
      CustomImageHotIndex = -1
      CustomImagePressedIndex = -1
      CustomImageDisabledIndex = -1
      CustomImageFocusedIndex = -1
      ScaleMarginAndSpacing = False
      WidthWithCaption = 0
      WidthWithoutCaption = 0
      ShowCaption = False
      UseFontColorToStyleColor = False
      RepeatClick = False
      RepeatClickInterval = 100
      GlowEffect.Enabled = False
      GlowEffect.Color = clHighlight
      GlowEffect.AlphaValue = 255
      GlowEffect.GlowSize = 7
      GlowEffect.Offset = 0
      GlowEffect.Intensive = True
      GlowEffect.StyleColors = True
      GlowEffect.HotColor = clNone
      GlowEffect.PressedColor = clNone
      GlowEffect.FocusedColor = clNone
      GlowEffect.PressedGlowSize = 7
      GlowEffect.PressedAlphaValue = 255
      GlowEffect.States = [scsHot, scsPressed, scsFocused]
      ImageGlow = True
      ShowGalleryMenuFromTop = False
      ShowGalleryMenuFromRight = False
      ShowMenuArrow = True
      SplitButton = False
      ShowFocusRect = False
      Down = False
      GroupIndex = 0
      AllowAllUp = False
    end
    object BtnOpenDir: TscButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 25
      Height = 25
      Align = alLeft
      FluentUIOpaque = False
      TabOrder = 6
      TabStop = True
      OnClick = BtnOpenDirClick
      Animation = False
      CaptionCenterAlignment = False
      CanFocused = True
      CustomDropDown = False
      Margin = -1
      Spacing = 1
      Layout = blGlyphLeft
      Images = ImageList
      ImageIndex = 0
      ImageMargin = 0
      TransparentBackground = True
      ColorOptions.NormalColor = clBtnFace
      ColorOptions.HotColor = clBtnFace
      ColorOptions.PressedColor = clBtnShadow
      ColorOptions.FocusedColor = clBtnFace
      ColorOptions.DisabledColor = clBtnFace
      ColorOptions.FrameNormalColor = clBtnShadow
      ColorOptions.FrameHotColor = clHighlight
      ColorOptions.FramePressedColor = clHighlight
      ColorOptions.FrameFocusedColor = clHighlight
      ColorOptions.FrameDisabledColor = clBtnShadow
      ColorOptions.FrameWidth = 1
      ColorOptions.FontNormalColor = clBtnText
      ColorOptions.FontHotColor = clBtnText
      ColorOptions.FontPressedColor = clBtnText
      ColorOptions.FontFocusedColor = clBtnText
      ColorOptions.FontDisabledColor = clBtnShadow
      ColorOptions.TitleFontNormalColor = clBtnText
      ColorOptions.TitleFontHotColor = clBtnText
      ColorOptions.TitleFontPressedColor = clBtnText
      ColorOptions.TitleFontFocusedColor = clBtnText
      ColorOptions.TitleFontDisabledColor = clBtnShadow
      ColorOptions.StyleColors = True
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -18
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = [fsBold]
      ToggleMode = False
      HotImageIndex = -1
      FocusedImageIndex = -1
      PressedImageIndex = -1
      StyleKind = scbsPushButton
      UseGalleryMenuImage = False
      UseGalleryMenuCaption = False
      CustomImageNormalIndex = -1
      CustomImageHotIndex = -1
      CustomImagePressedIndex = -1
      CustomImageDisabledIndex = -1
      CustomImageFocusedIndex = -1
      ScaleMarginAndSpacing = False
      WidthWithCaption = 0
      WidthWithoutCaption = 0
      ShowCaption = False
      UseFontColorToStyleColor = False
      RepeatClick = False
      RepeatClickInterval = 100
      GlowEffect.Enabled = False
      GlowEffect.Color = clHighlight
      GlowEffect.AlphaValue = 255
      GlowEffect.GlowSize = 7
      GlowEffect.Offset = 0
      GlowEffect.Intensive = True
      GlowEffect.StyleColors = True
      GlowEffect.HotColor = clNone
      GlowEffect.PressedColor = clNone
      GlowEffect.FocusedColor = clNone
      GlowEffect.PressedGlowSize = 7
      GlowEffect.PressedAlphaValue = 255
      GlowEffect.States = [scsHot, scsPressed, scsFocused]
      ImageGlow = True
      ShowGalleryMenuFromTop = False
      ShowGalleryMenuFromRight = False
      ShowMenuArrow = True
      SplitButton = False
      ShowFocusRect = False
      Down = False
      GroupIndex = 0
      AllowAllUp = False
    end
    object BtnResetUI: TscButton
      AlignWithMargins = True
      Left = 688
      Top = 3
      Width = 25
      Height = 25
      Align = alRight
      FluentUIOpaque = False
      TabOrder = 7
      TabStop = True
      OnClick = BtnResetUIClick
      Animation = False
      CaptionCenterAlignment = False
      CanFocused = True
      CustomDropDown = False
      Margin = -1
      Spacing = 1
      Layout = blGlyphLeft
      Images = ImageList
      ImageIndex = 4
      ImageMargin = 0
      TransparentBackground = True
      ColorOptions.NormalColor = clBtnFace
      ColorOptions.HotColor = clBtnFace
      ColorOptions.PressedColor = clBtnShadow
      ColorOptions.FocusedColor = clBtnFace
      ColorOptions.DisabledColor = clBtnFace
      ColorOptions.FrameNormalColor = clBtnShadow
      ColorOptions.FrameHotColor = clHighlight
      ColorOptions.FramePressedColor = clHighlight
      ColorOptions.FrameFocusedColor = clHighlight
      ColorOptions.FrameDisabledColor = clBtnShadow
      ColorOptions.FrameWidth = 1
      ColorOptions.FontNormalColor = clBtnText
      ColorOptions.FontHotColor = clBtnText
      ColorOptions.FontPressedColor = clBtnText
      ColorOptions.FontFocusedColor = clBtnText
      ColorOptions.FontDisabledColor = clBtnShadow
      ColorOptions.TitleFontNormalColor = clBtnText
      ColorOptions.TitleFontHotColor = clBtnText
      ColorOptions.TitleFontPressedColor = clBtnText
      ColorOptions.TitleFontFocusedColor = clBtnText
      ColorOptions.TitleFontDisabledColor = clBtnShadow
      ColorOptions.StyleColors = True
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -18
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = [fsBold]
      ToggleMode = False
      HotImageIndex = -1
      FocusedImageIndex = -1
      PressedImageIndex = -1
      StyleKind = scbsPushButton
      UseGalleryMenuImage = False
      UseGalleryMenuCaption = False
      CustomImageNormalIndex = -1
      CustomImageHotIndex = -1
      CustomImagePressedIndex = -1
      CustomImageDisabledIndex = -1
      CustomImageFocusedIndex = -1
      ScaleMarginAndSpacing = False
      WidthWithCaption = 0
      WidthWithoutCaption = 0
      ShowCaption = False
      UseFontColorToStyleColor = False
      RepeatClick = False
      RepeatClickInterval = 100
      GlowEffect.Enabled = False
      GlowEffect.Color = clHighlight
      GlowEffect.AlphaValue = 255
      GlowEffect.GlowSize = 7
      GlowEffect.Offset = 0
      GlowEffect.Intensive = True
      GlowEffect.StyleColors = True
      GlowEffect.HotColor = clNone
      GlowEffect.PressedColor = clNone
      GlowEffect.FocusedColor = clNone
      GlowEffect.PressedGlowSize = 7
      GlowEffect.PressedAlphaValue = 255
      GlowEffect.States = [scsHot, scsPressed, scsFocused]
      ImageGlow = True
      ShowGalleryMenuFromTop = False
      ShowGalleryMenuFromRight = False
      ShowMenuArrow = True
      SplitButton = False
      ShowFocusRect = False
      Down = False
      GroupIndex = 0
      AllowAllUp = False
    end
    object BtnAbout: TscButton
      AlignWithMargins = True
      Left = 719
      Top = 3
      Width = 25
      Height = 25
      Align = alRight
      FluentUIOpaque = False
      TabOrder = 8
      TabStop = True
      OnClick = BtnAboutClick
      Animation = False
      CaptionCenterAlignment = False
      CanFocused = True
      CustomDropDown = False
      Margin = -1
      Spacing = 1
      Layout = blGlyphLeft
      Images = ImageList
      ImageIndex = 5
      ImageMargin = 0
      TransparentBackground = True
      ColorOptions.NormalColor = clBtnFace
      ColorOptions.HotColor = clBtnFace
      ColorOptions.PressedColor = clBtnShadow
      ColorOptions.FocusedColor = clBtnFace
      ColorOptions.DisabledColor = clBtnFace
      ColorOptions.FrameNormalColor = clBtnShadow
      ColorOptions.FrameHotColor = clHighlight
      ColorOptions.FramePressedColor = clHighlight
      ColorOptions.FrameFocusedColor = clHighlight
      ColorOptions.FrameDisabledColor = clBtnShadow
      ColorOptions.FrameWidth = 1
      ColorOptions.FontNormalColor = clBtnText
      ColorOptions.FontHotColor = clBtnText
      ColorOptions.FontPressedColor = clBtnText
      ColorOptions.FontFocusedColor = clBtnText
      ColorOptions.FontDisabledColor = clBtnShadow
      ColorOptions.TitleFontNormalColor = clBtnText
      ColorOptions.TitleFontHotColor = clBtnText
      ColorOptions.TitleFontPressedColor = clBtnText
      ColorOptions.TitleFontFocusedColor = clBtnText
      ColorOptions.TitleFontDisabledColor = clBtnShadow
      ColorOptions.StyleColors = True
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -18
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = [fsBold]
      ToggleMode = False
      HotImageIndex = -1
      FocusedImageIndex = -1
      PressedImageIndex = -1
      StyleKind = scbsPushButton
      UseGalleryMenuImage = False
      UseGalleryMenuCaption = False
      CustomImageNormalIndex = -1
      CustomImageHotIndex = -1
      CustomImagePressedIndex = -1
      CustomImageDisabledIndex = -1
      CustomImageFocusedIndex = -1
      ScaleMarginAndSpacing = False
      WidthWithCaption = 0
      WidthWithoutCaption = 0
      ShowCaption = False
      UseFontColorToStyleColor = False
      RepeatClick = False
      RepeatClickInterval = 100
      GlowEffect.Enabled = False
      GlowEffect.Color = clHighlight
      GlowEffect.AlphaValue = 255
      GlowEffect.GlowSize = 7
      GlowEffect.Offset = 0
      GlowEffect.Intensive = True
      GlowEffect.StyleColors = True
      GlowEffect.HotColor = clNone
      GlowEffect.PressedColor = clNone
      GlowEffect.FocusedColor = clNone
      GlowEffect.PressedGlowSize = 7
      GlowEffect.PressedAlphaValue = 255
      GlowEffect.States = [scsHot, scsPressed, scsFocused]
      ImageGlow = True
      ShowGalleryMenuFromTop = False
      ShowGalleryMenuFromRight = False
      ShowMenuArrow = True
      SplitButton = False
      ShowFocusRect = False
      Down = False
      GroupIndex = 0
      AllowAllUp = False
    end
  end
  object BoxScrap: TscPanel
    Left = 0
    Top = 31
    Width = 778
    Height = 443
    Align = alClient
    FluentUIOpaque = False
    TabOrder = 1
    CustomImageIndex = -1
    DragForm = False
    DragTopForm = True
    StyleKind = scpsPanel
    ShowCaption = False
    BorderStyle = scpbsNone
    WallpaperIndex = -1
    LightBorderColor = clBtnHighlight
    ShadowBorderColor = clBtnShadow
    CaptionGlowEffect.Enabled = False
    CaptionGlowEffect.Color = clBtnShadow
    CaptionGlowEffect.AlphaValue = 255
    CaptionGlowEffect.GlowSize = 7
    CaptionGlowEffect.Offset = 0
    CaptionGlowEffect.Intensive = True
    CaptionGlowEffect.StyleColors = True
    StorePaintBuffer = False
    WordWrap = False
    DesignSize = (
      778
      443)
    object ListView: TscListView
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 532
      Height = 281
      FluentUIOpaque = False
      Align = alClient
      Columns = <>
      ColumnClick = False
      ExtendedColumnDraw = False
      OwnerDraw = True
      ReadOnly = True
      RowSelect = True
      ShowWorkAreas = True
      TabOrder = 0
      ViewStyle = vsReport
      SelectionStyle = scstStyled
      ShowFocusRect = False
      AlternateRow = False
      GridLines = False
      DefaultDraw = False
      SelectionColor = clNone
      SelectionTextColor = clHighlightText
      StyleElements = [seClient, seBorder]
      OnDblClick = ListViewDblClick
      ExplicitWidth = 372
      ExplicitHeight = 211
    end
    object SplitView: TscSplitView
      AlignWithMargins = True
      Left = 538
      Top = 0
      Width = 240
      Height = 287
      Anchors = [akTop, akRight, akBottom]
      FluentUIOpaque = False
      TabOrder = 1
      CustomImageIndex = -1
      DragForm = False
      DragTopForm = True
      StyleKind = scpsPanel
      ShowCaption = False
      BorderStyle = scpbsLeftLightLine
      WallpaperIndex = -1
      LightBorderColor = clBtnHighlight
      ShadowBorderColor = clBtnShadow
      CaptionGlowEffect.Enabled = False
      CaptionGlowEffect.Color = clBtnShadow
      CaptionGlowEffect.AlphaValue = 255
      CaptionGlowEffect.GlowSize = 7
      CaptionGlowEffect.Offset = 0
      CaptionGlowEffect.Intensive = True
      CaptionGlowEffect.StyleColors = True
      StorePaintBuffer = False
      WordWrap = False
      AnimationStep = 25
      AnimationType = scsvaInertial
      CompactWidth = 0
      CompactHeight = 20
      GripSize = 0
      Opened = True
      OpenedWidth = 240
      OpenedHeight = 50
      OpenedMinWidth = 0
      OpenedMaxWidth = 0
      OpenedMinHeight = 0
      OpenedMaxHeight = 0
      ParentBackground = False
      ParentColor = False
      Placement = scsvpRight
      HideControls = False
      Animation = False
      DisplayMode = scsvmDocked
      object ScrollBox: TscScrollBox
        Left = 1
        Top = 0
        Width = 239
        Height = 287
        HorzScrollBar.Tracking = True
        HorzScrollBar.Visible = False
        VertScrollBar.Tracking = True
        Align = alClient
        BorderStyle = bsNone
        TabOrder = 0
        WallpaperIndex = -1
        CustomBackgroundImageIndex = -1
        FullUpdate = True
        FluentUIOpaque = False
        StorePaintBuffer = False
        MouseWheelSupport = True
        BackgroundStyle = scsbsFormBackground
        object LabListFileTypes: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 311
          Width = 207
          Height = 15
          Align = alTop
          Caption = 'Types de fichiers '#224' rechercher'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsUnderline]
          ParentFont = False
          ExplicitTop = 47
          ExplicitWidth = 155
        end
        object LabDepth: TscLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 207
          Height = 17
          Align = alTop
          FluentUIOpaque = False
          TabOrder = 0
          DragForm = False
          DragTopForm = True
          GlowEffect.Enabled = False
          GlowEffect.Color = clBtnShadow
          GlowEffect.AlphaValue = 255
          GlowEffect.GlowSize = 7
          GlowEffect.Offset = 0
          GlowEffect.Intensive = True
          GlowEffect.StyleColors = True
          AutoSize = True
          UseFontColorToStyleColor = False
          Caption = 'Profondeur d'#39'exploration'
        end
        object SeDepth: TscSpinEdit
          AlignWithMargins = True
          Left = 3
          Top = 26
          Width = 207
          Height = 23
          FluentUIOpaque = False
          UseFontColorToStyleColor = False
          ContentMarginLeft = 0
          ContentMarginRight = 0
          ContentMarginTop = 0
          ContentMarginBottom = 0
          CustomBackgroundImageNormalIndex = -1
          CustomBackgroundImageHotIndex = -1
          CustomBackgroundImageDisabledIndex = -1
          PromptTextColor = clNone
          HideMaskWithEmptyText = False
          HidePromptTextIfFocused = False
          WallpaperIndex = -1
          Increment = 1.000000000000000000
          UpDownKind = scupkDefault
          ValueType = scvtInteger
          MouseWheelSupport = False
          DisplayType = scedtNumeric
          Transparent = False
          BorderKind = scebFrame
          Align = alTop
          AutoSelect = False
          TabOrder = 1
        end
        object CkSameDomain: TscCheckBox
          AlignWithMargins = True
          Left = 3
          Top = 55
          Width = 207
          Height = 18
          Align = alTop
          FluentUIOpaque = False
          TabOrder = 2
          TabStop = True
          CustomCheckedImageIndex = -1
          CustomCheckedImageHotIndex = -1
          CustomCheckedImagePressedIndex = -1
          CustomCheckedImageDisabledIndex = -1
          CustomUnCheckedImageIndex = -1
          CustomUnCheckedImageHotIndex = -1
          CustomUnCheckedImagePressedIndex = -1
          CustomUnCheckedImageDisabledIndex = -1
          CustomGrayedImageIndex = -1
          CustomGrayedImageHotIndex = -1
          CustomGrayedImagePressedIndex = -1
          CustomGrayedImageDisabledIndex = -1
          UseFontColorToStyleColor = False
          Animation = False
          Caption = 'Limiter au m'#234'me domaine'
          CanFocused = True
          Spacing = 1
          Layout = blGlyphLeft
          ImageIndex = -1
          GlowEffect.Enabled = False
          GlowEffect.Color = clHighlight
          GlowEffect.AlphaValue = 255
          GlowEffect.GlowSize = 7
          GlowEffect.Offset = 0
          GlowEffect.Intensive = True
          GlowEffect.StyleColors = True
          GlowEffect.HotColor = clNone
          GlowEffect.PressedColor = clNone
          GlowEffect.FocusedColor = clNone
          GlowEffect.PressedGlowSize = 7
          GlowEffect.PressedAlphaValue = 255
          GlowEffect.States = [scsHot, scsPressed, scsFocused]
          ImageGlow = True
          Checked = False
          ShowFocusRect = False
        end
        object CkRobot: TscCheckBox
          AlignWithMargins = True
          Left = 3
          Top = 79
          Width = 207
          Height = 18
          Align = alTop
          FluentUIOpaque = False
          TabOrder = 3
          TabStop = True
          CustomCheckedImageIndex = -1
          CustomCheckedImageHotIndex = -1
          CustomCheckedImagePressedIndex = -1
          CustomCheckedImageDisabledIndex = -1
          CustomUnCheckedImageIndex = -1
          CustomUnCheckedImageHotIndex = -1
          CustomUnCheckedImagePressedIndex = -1
          CustomUnCheckedImageDisabledIndex = -1
          CustomGrayedImageIndex = -1
          CustomGrayedImageHotIndex = -1
          CustomGrayedImagePressedIndex = -1
          CustomGrayedImageDisabledIndex = -1
          UseFontColorToStyleColor = False
          Animation = False
          Caption = 'Respecter les directives Robots.txt'
          CanFocused = True
          Spacing = 1
          Layout = blGlyphLeft
          ImageIndex = -1
          GlowEffect.Enabled = False
          GlowEffect.Color = clHighlight
          GlowEffect.AlphaValue = 255
          GlowEffect.GlowSize = 7
          GlowEffect.Offset = 0
          GlowEffect.Intensive = True
          GlowEffect.StyleColors = True
          GlowEffect.HotColor = clNone
          GlowEffect.PressedColor = clNone
          GlowEffect.FocusedColor = clNone
          GlowEffect.PressedGlowSize = 7
          GlowEffect.PressedAlphaValue = 255
          GlowEffect.States = [scsHot, scsPressed, scsFocused]
          ImageGlow = True
          Checked = False
          ShowFocusRect = False
        end
        object LabTimeout: TscLabel
          AlignWithMargins = True
          Left = 3
          Top = 103
          Width = 207
          Height = 17
          Align = alTop
          FluentUIOpaque = False
          TabOrder = 4
          DragForm = False
          DragTopForm = True
          GlowEffect.Enabled = False
          GlowEffect.Color = clBtnShadow
          GlowEffect.AlphaValue = 255
          GlowEffect.GlowSize = 7
          GlowEffect.Offset = 0
          GlowEffect.Intensive = True
          GlowEffect.StyleColors = True
          AutoSize = True
          UseFontColorToStyleColor = False
          Caption = 'Temps d'#39'attente par requ'#234'te (ms)'
        end
        object SeTimeout: TscSpinEdit
          AlignWithMargins = True
          Left = 3
          Top = 126
          Width = 207
          Height = 23
          FluentUIOpaque = False
          UseFontColorToStyleColor = False
          ContentMarginLeft = 0
          ContentMarginRight = 0
          ContentMarginTop = 0
          ContentMarginBottom = 0
          CustomBackgroundImageNormalIndex = -1
          CustomBackgroundImageHotIndex = -1
          CustomBackgroundImageDisabledIndex = -1
          PromptTextColor = clNone
          HideMaskWithEmptyText = False
          HidePromptTextIfFocused = False
          WallpaperIndex = -1
          Increment = 1.000000000000000000
          UpDownKind = scupkDefault
          ValueType = scvtInteger
          MouseWheelSupport = False
          DisplayType = scedtNumeric
          Transparent = False
          BorderKind = scebFrame
          Align = alTop
          AutoSelect = False
          TabOrder = 5
        end
        object LabDelay: TscLabel
          AlignWithMargins = True
          Left = 3
          Top = 155
          Width = 207
          Height = 17
          Align = alTop
          FluentUIOpaque = False
          TabOrder = 6
          DragForm = False
          DragTopForm = True
          GlowEffect.Enabled = False
          GlowEffect.Color = clBtnShadow
          GlowEffect.AlphaValue = 255
          GlowEffect.GlowSize = 7
          GlowEffect.Offset = 0
          GlowEffect.Intensive = True
          GlowEffect.StyleColors = True
          AutoSize = True
          UseFontColorToStyleColor = False
          Caption = 'D'#233'lai entre requ'#234'tes (ms)'
        end
        object SeDelay: TscSpinEdit
          AlignWithMargins = True
          Left = 3
          Top = 178
          Width = 207
          Height = 23
          FluentUIOpaque = False
          UseFontColorToStyleColor = False
          ContentMarginLeft = 0
          ContentMarginRight = 0
          ContentMarginTop = 0
          ContentMarginBottom = 0
          CustomBackgroundImageNormalIndex = -1
          CustomBackgroundImageHotIndex = -1
          CustomBackgroundImageDisabledIndex = -1
          PromptTextColor = clNone
          HideMaskWithEmptyText = False
          HidePromptTextIfFocused = False
          WallpaperIndex = -1
          Increment = 1.000000000000000000
          UpDownKind = scupkDefault
          ValueType = scvtInteger
          MouseWheelSupport = False
          DisplayType = scedtNumeric
          Transparent = False
          BorderKind = scebFrame
          Align = alTop
          AutoSelect = False
          TabOrder = 7
        end
        object CkListFileTypes: TscCheckListBox
          AlignWithMargins = True
          Left = 3
          Top = 332
          Width = 207
          Height = 100
          Align = alTop
          ItemHeight = 18
          Style = lbOwnerDrawFixed
          TabOrder = 8
          ItemIndex = -1
          ImageIndex = -1
          WordBreak = False
          LineColor = clBtnFace
          ShowLines = False
          SelectionStyle = scstStyled
          ShowFocusRect = False
          SelectionColor = clNone
          SelectionTextColor = clHighlightText
        end
        object CkAutoDownload: TscCheckBox
          AlignWithMargins = True
          Left = 3
          Top = 438
          Width = 207
          Height = 18
          Align = alTop
          FluentUIOpaque = False
          TabOrder = 9
          TabStop = True
          CustomCheckedImageIndex = -1
          CustomCheckedImageHotIndex = -1
          CustomCheckedImagePressedIndex = -1
          CustomCheckedImageDisabledIndex = -1
          CustomUnCheckedImageIndex = -1
          CustomUnCheckedImageHotIndex = -1
          CustomUnCheckedImagePressedIndex = -1
          CustomUnCheckedImageDisabledIndex = -1
          CustomGrayedImageIndex = -1
          CustomGrayedImageHotIndex = -1
          CustomGrayedImagePressedIndex = -1
          CustomGrayedImageDisabledIndex = -1
          UseFontColorToStyleColor = False
          Animation = False
          Caption = 'T'#233'l'#233'chargement automatique'
          CanFocused = True
          Spacing = 1
          Layout = blGlyphLeft
          ImageIndex = -1
          GlowEffect.Enabled = False
          GlowEffect.Color = clHighlight
          GlowEffect.AlphaValue = 255
          GlowEffect.GlowSize = 7
          GlowEffect.Offset = 0
          GlowEffect.Intensive = True
          GlowEffect.StyleColors = True
          GlowEffect.HotColor = clNone
          GlowEffect.PressedColor = clNone
          GlowEffect.FocusedColor = clNone
          GlowEffect.PressedGlowSize = 7
          GlowEffect.PressedAlphaValue = 255
          GlowEffect.States = [scsHot, scsPressed, scsFocused]
          ImageGlow = True
          Checked = False
          ShowFocusRect = False
        end
        object CkSaveBrokenLinks: TscCheckBox
          AlignWithMargins = True
          Left = 3
          Top = 533
          Width = 207
          Height = 18
          Align = alTop
          FluentUIOpaque = False
          TabOrder = 10
          TabStop = True
          CustomCheckedImageIndex = -1
          CustomCheckedImageHotIndex = -1
          CustomCheckedImagePressedIndex = -1
          CustomCheckedImageDisabledIndex = -1
          CustomUnCheckedImageIndex = -1
          CustomUnCheckedImageHotIndex = -1
          CustomUnCheckedImagePressedIndex = -1
          CustomUnCheckedImageDisabledIndex = -1
          CustomGrayedImageIndex = -1
          CustomGrayedImageHotIndex = -1
          CustomGrayedImagePressedIndex = -1
          CustomGrayedImageDisabledIndex = -1
          UseFontColorToStyleColor = False
          Animation = False
          Caption = 'Rapport des liens corrompus'
          CanFocused = True
          Spacing = 1
          Layout = blGlyphLeft
          ImageIndex = -1
          GlowEffect.Enabled = False
          GlowEffect.Color = clHighlight
          GlowEffect.AlphaValue = 255
          GlowEffect.GlowSize = 7
          GlowEffect.Offset = 0
          GlowEffect.Intensive = True
          GlowEffect.StyleColors = True
          GlowEffect.HotColor = clNone
          GlowEffect.PressedColor = clNone
          GlowEffect.FocusedColor = clNone
          GlowEffect.PressedGlowSize = 7
          GlowEffect.PressedAlphaValue = 255
          GlowEffect.States = [scsHot, scsPressed, scsFocused]
          ImageGlow = True
          Checked = False
          ShowFocusRect = False
        end
        object CkSaveBrokenToFile: TscCheckBox
          AlignWithMargins = True
          Left = 3
          Top = 509
          Width = 207
          Height = 18
          Align = alTop
          FluentUIOpaque = False
          TabOrder = 11
          TabStop = True
          CustomCheckedImageIndex = -1
          CustomCheckedImageHotIndex = -1
          CustomCheckedImagePressedIndex = -1
          CustomCheckedImageDisabledIndex = -1
          CustomUnCheckedImageIndex = -1
          CustomUnCheckedImageHotIndex = -1
          CustomUnCheckedImagePressedIndex = -1
          CustomUnCheckedImageDisabledIndex = -1
          CustomGrayedImageIndex = -1
          CustomGrayedImageHotIndex = -1
          CustomGrayedImagePressedIndex = -1
          CustomGrayedImageDisabledIndex = -1
          UseFontColorToStyleColor = False
          Animation = False
          Caption = 'Rapport des pages visit'#233'es'
          CanFocused = True
          Spacing = 1
          Layout = blGlyphLeft
          ImageIndex = -1
          GlowEffect.Enabled = False
          GlowEffect.Color = clHighlight
          GlowEffect.AlphaValue = 255
          GlowEffect.GlowSize = 7
          GlowEffect.Offset = 0
          GlowEffect.Intensive = True
          GlowEffect.StyleColors = True
          GlowEffect.HotColor = clNone
          GlowEffect.PressedColor = clNone
          GlowEffect.FocusedColor = clNone
          GlowEffect.PressedGlowSize = 7
          GlowEffect.PressedAlphaValue = 255
          GlowEffect.States = [scsHot, scsPressed, scsFocused]
          ImageGlow = True
          Checked = False
          ShowFocusRect = False
        end
        object CkSaveFoundFilesToFile: TscCheckBox
          AlignWithMargins = True
          Left = 3
          Top = 485
          Width = 207
          Height = 18
          Align = alTop
          FluentUIOpaque = False
          TabOrder = 12
          TabStop = True
          CustomCheckedImageIndex = -1
          CustomCheckedImageHotIndex = -1
          CustomCheckedImagePressedIndex = -1
          CustomCheckedImageDisabledIndex = -1
          CustomUnCheckedImageIndex = -1
          CustomUnCheckedImageHotIndex = -1
          CustomUnCheckedImagePressedIndex = -1
          CustomUnCheckedImageDisabledIndex = -1
          CustomGrayedImageIndex = -1
          CustomGrayedImageHotIndex = -1
          CustomGrayedImagePressedIndex = -1
          CustomGrayedImageDisabledIndex = -1
          UseFontColorToStyleColor = False
          Animation = False
          Caption = 'Rapport des fichiers trouv'#233's'
          CanFocused = True
          Spacing = 1
          Layout = blGlyphLeft
          ImageIndex = -1
          GlowEffect.Enabled = False
          GlowEffect.Color = clHighlight
          GlowEffect.AlphaValue = 255
          GlowEffect.GlowSize = 7
          GlowEffect.Offset = 0
          GlowEffect.Intensive = True
          GlowEffect.StyleColors = True
          GlowEffect.HotColor = clNone
          GlowEffect.PressedColor = clNone
          GlowEffect.FocusedColor = clNone
          GlowEffect.PressedGlowSize = 7
          GlowEffect.PressedAlphaValue = 255
          GlowEffect.States = [scsHot, scsPressed, scsFocused]
          ImageGlow = True
          Checked = False
          ShowFocusRect = False
        end
        object LabReport: TscLabel
          AlignWithMargins = True
          Left = 3
          Top = 462
          Width = 207
          Height = 17
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsUnderline]
          ParentFont = False
          FluentUIOpaque = False
          TabOrder = 13
          DragForm = False
          DragTopForm = True
          GlowEffect.Enabled = False
          GlowEffect.Color = clBtnShadow
          GlowEffect.AlphaValue = 255
          GlowEffect.GlowSize = 7
          GlowEffect.Offset = 0
          GlowEffect.Intensive = True
          GlowEffect.StyleColors = True
          AutoSize = True
          UseFontColorToStyleColor = False
          Caption = 'Rapport d'#39'exploration'
        end
        object LabFoundFilesLimit: TscLabel
          AlignWithMargins = True
          Left = 3
          Top = 259
          Width = 207
          Height = 17
          Align = alTop
          FluentUIOpaque = False
          TabOrder = 14
          DragForm = False
          DragTopForm = True
          GlowEffect.Enabled = False
          GlowEffect.Color = clBtnShadow
          GlowEffect.AlphaValue = 255
          GlowEffect.GlowSize = 7
          GlowEffect.Offset = 0
          GlowEffect.Intensive = True
          GlowEffect.StyleColors = True
          AutoSize = True
          UseFontColorToStyleColor = False
          Caption = 'Limite fichiers trouv'#233's'
        end
        object SeFoundFilesLimit: TscSpinEdit
          AlignWithMargins = True
          Left = 3
          Top = 282
          Width = 207
          Height = 23
          FluentUIOpaque = False
          UseFontColorToStyleColor = False
          ContentMarginLeft = 0
          ContentMarginRight = 0
          ContentMarginTop = 0
          ContentMarginBottom = 0
          CustomBackgroundImageNormalIndex = -1
          CustomBackgroundImageHotIndex = -1
          CustomBackgroundImageDisabledIndex = -1
          PromptTextColor = clNone
          HideMaskWithEmptyText = False
          HidePromptTextIfFocused = False
          WallpaperIndex = -1
          Increment = 1.000000000000000000
          UpDownKind = scupkDefault
          ValueType = scvtInteger
          MouseWheelSupport = False
          DisplayType = scedtNumeric
          Transparent = False
          BorderKind = scebFrame
          Align = alTop
          AutoSelect = False
          TabOrder = 15
        end
        object LabExploreLimit: TscLabel
          AlignWithMargins = True
          Left = 3
          Top = 207
          Width = 207
          Height = 17
          Align = alTop
          FluentUIOpaque = False
          TabOrder = 16
          DragForm = False
          DragTopForm = True
          GlowEffect.Enabled = False
          GlowEffect.Color = clBtnShadow
          GlowEffect.AlphaValue = 255
          GlowEffect.GlowSize = 7
          GlowEffect.Offset = 0
          GlowEffect.Intensive = True
          GlowEffect.StyleColors = True
          AutoSize = True
          UseFontColorToStyleColor = False
          Caption = 'Limite d'#39'exploration'
        end
        object SeExploreLimit: TscSpinEdit
          AlignWithMargins = True
          Left = 3
          Top = 230
          Width = 207
          Height = 23
          FluentUIOpaque = False
          UseFontColorToStyleColor = False
          ContentMarginLeft = 0
          ContentMarginRight = 0
          ContentMarginTop = 0
          ContentMarginBottom = 0
          CustomBackgroundImageNormalIndex = -1
          CustomBackgroundImageHotIndex = -1
          CustomBackgroundImageDisabledIndex = -1
          PromptTextColor = clNone
          HideMaskWithEmptyText = False
          HidePromptTextIfFocused = False
          WallpaperIndex = -1
          Increment = 1.000000000000000000
          UpDownKind = scupkDefault
          ValueType = scvtInteger
          MouseWheelSupport = False
          DisplayType = scedtNumeric
          Transparent = False
          BorderKind = scebFrame
          Align = alTop
          AutoSelect = False
          TabOrder = 17
        end
      end
    end
    object ExPanelLog: TscExPanel
      AlignWithMargins = True
      Left = 3
      Top = 290
      Width = 772
      Height = 150
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBtnText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      FluentUIOpaque = False
      TabOrder = 3
      BorderWidth = 1
      BackgroundStyle = scexbgsPanel
      FrameColor = clBtnShadow
      HeaderColor = clBtnFace
      ButtonGlyphColor = clBtnText
      HeaderStyle = scexphsHeader
      CaptionImages = ImageList
      CaptionImageIndex = 6
      ChangeRollStateWithCaptionClick = False
      HorzRollButtonPosition = scrbpRight
      ShowFrame = True
      RealWidth = 0
      RealHeight = 0
      ShowRollButton = True
      ShowCloseButton = False
      CaptionHeight = 24
      RollKind = scrkRollVertical
      RollUpState = False
      Moveable = False
      Sizeable = False
      HideControlsInRollUpState = True
      StorePaintBuffer = False
      Caption = 'Observateur d'#39#233'v'#233'nements'
      object Logging: TscListBox
        Left = 1
        Top = 24
        Width = 770
        Height = 125
        FluentUIOpaque = False
        ItemIndex = -1
        ImageIndex = -1
        WordBreak = False
        LineColor = clBtnFace
        ShowLines = False
        SelectionStyle = scstStyled
        ShowFocusRect = False
        SelectionColor = clNone
        SelectionTextColor = clHighlightText
        Align = alClient
        BorderStyle = bsNone
        TabOrder = 0
      end
    end
  end
  object StatusBar: TscStatusBar
    Left = 0
    Top = 474
    Width = 778
    Height = 20
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBtnText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Panels = <
      item
        Alignment = taRightJustify
        Text = 'Fichiers trouv'#233's '
        Width = 120
      end
      item
        Alignment = taCenter
        Text = '0'
        Width = 40
      end
      item
        Alignment = taRightJustify
        Text = 'Liens corrompus '
        Width = 120
      end
      item
        Alignment = taCenter
        Text = '0'
        Width = 40
      end
      item
        Alignment = taRightJustify
        Text = 'Bloqu'#233' par robots.txt '
        Width = 120
      end
      item
        Alignment = taCenter
        Text = '0'
        Width = 40
      end
      item
        Alignment = taRightJustify
        Text = 'Liens parcourus '
        Width = 120
      end
      item
        Alignment = taCenter
        Text = '0'
        Width = 40
      end
      item
        Width = 50
      end>
    UseSystemFont = False
  end
  object scStyleManager: TscStyleManager
    ArrowsType = scsatDefault
    MenuHookEnabled = True
    MenuAlphaBlendValue = 255
    MenuWallpaperIndex = -1
    MenuBackgroundIndex = -1
    MenuBackgroundOverContentIndex = -1
    MenuHeadersSupport = True
    MenuSelectionStyle = scmssStyled
    ScaleStyles = True
    ScaleThemes = False
    ScaleResources = True
    ScaleFormBorder = True
    RTLMode = False
    SystemShellDialogs = False
    Left = 56
    Top = 48
  end
  object Collection: TImageCollection
    Images = <
      item
        Name = '0'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
              F40000000473424954080808087C086488000002A2494441545885ED97DF4B53
              6118C73FAF3B9DA9B1992913F6839AD950776711D95D21140485600DAABBC0BF
              A0BB2EBAE82288BAF0B2BA1492A661110C2A6FA21F464C109C6B569AE094C41F
              E9398DE1D9DE9D2E74E10F4C67C746D073F5BCCFF93EBC1FCEF7BC0FE715576F
              BE92FCFD08BD797AA76724FA8C92226CBE26949D34D5BA1D13954E55038826E6
              1A012A1DAA76C8E348028C4EEADEEFBAE104385A5F150798D70CE7D729DD6709
              40CB3177FF9186EA3840F4D6DB1B00B51EC7447B6B7D0FC0BDDE44DB40622E08
              D0DE5ADF0D10FD38DBF8E0C9C806807FD382BE0F53CD0389D9E0EADAD8A4EEBB
              DF9BB8B0927BF3F57C6D5E5BB6C41280B129DDC7D4722E566A0BBA51319098AB
              C86BF2F5BC159B45512CB0E57E50622E01A0D4A49F03100C068743A150F76E6D
              1A8BC51AC3E1F045808C70A0E474A0486F4031756C66BA780062555EF463F81F
              602773200E3CDEA6B606B802945B094076264EEAFDDD4D9F9B9808A5147BE0FC
              B4DDDFD2254A6C972D05304D899949B501E1CD34B94C6A323DD4790A697CDE53
              7BE661369B3554551586610024FF08603B21101E53665EA4E38F4E1AFAF4B8B9
              50D611A8961D9A9602A0C95F8E53BAAC01B0ED3F3C515256A5E5D7B9D4B77D72
              61DC23843860CA4C9F1C7F79FD2048BF4B806B59D356E706DCD600D8EBCEF6AB
              DEE3C3F9B5290D5BEADDED4BD999589D10A216E8DAAC77578EA1B0A9726FF3B5
              2EA5BA616C2BEDAECD01A19466ED8173AF01F3773A4B2C90F39FBCC6BA9A9949
              D9D3439DA7593BFA770760E94BE4044476D45BF4515C30402E972327ADBBCBFC
              B2607171D1198BC51AB701A029DA286EAB0192C9A42F1C0E6FF86F5F1FAAAA8A
              40B5EC70BBAC0128D802C330D0346D6BE13643014205F624B79614001089447A
              0A6D6AF297AFCC720B000607070B6E724A1758F419FE042C15F2A15182097200
              00000049454E44AE426082}
          end>
      end
      item
        Name = '1'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
              F40000000473424954080808087C0864880000050A494441545885D5965D4C54
              5710C77FB32CBB86F021AD02A23C009A6C4151CB6AD207D3D4184335B631A9C5
              07DE4C8C35A1D1C4F8D0C4B44D1F9A26A6B5499BD4B64F4DB52D92005A30AD4D
              41A95A944D50D08222755D10972F818B087BB977FAB0BBB86A315DB0359DE426
              77FF3373E69773E69E1DD9F1C1698BFFDE4A7FAB3958D9D17C02C73328FE9039
              679394979D12484F758D0234B70F1600A4A7B846F317A77403DCE83196DC3542
              A9005ECFF35701864643A97FDE36729E0AC086B5D9E78B5F587015A0F9C3B3EF
              02E42D4E09ECDCEAA904385CD5FE86AF7DB01060E756CF3180E63F060ABEAAEE
              780CE0FF7904BF5CB8FD92AF7DA03056EBEA3172BEAC6ADF16795F12D5A3DAD0
              68F8489E0A40D76D2387DBE1778968C34628CDD73E98168D89EAD1A398C99EC9
              1124D8633874120067E6FD9F00282C2CBC525A5A7AECDF2ADAD6D656505151F1
              26802929386D0378463BE0548304BDFF5401C6805BC0E4DFF842AA7ACBB2ACD1
              A82031CE593561ECE240A3699A1742A1D094DBED4E763A9D65C0C288FFAE6DDB
              DF8C8D8D8DFAFDFEA3898989ADA669BE17BBC05C00AE59965577FDFA75A3BEBE
              DE110C0697161717776EDEBCF94787C3F13280AA9E6B6A6A1A3D75EA54BE699A
              7EE033E0072065AE00C3A669569E3871C2BA7CF9F25ACBB20E011E9FCFE7C9CA
              CAEACECECE3E0230323242434343BA699A67815E55DD039CEEEDEDED1F1C1C9C
              13C01DC330AC4B972EADB56DFB9C8838002CCB3A505353735044F2223BD02522
              7B452403C8007E054A3A3A3A4E05028139012C4A4A4A72A4A6A6FA868787AF00
              2B0044E42D60B78844FB4C234FD4AE010DB66D4F0BB3FD0AD2DC6E77EEA2458B
              2CE0FD18DD11531C095B6C8D03B66D9B9D9D9D7306E81D1F1FEF0A068309C0EE
              38F2768948425151D1AC0014B8019C53D593172F5ED4A1A1A1721159FF5090EA
              4D55FD3AF2DC8CF589C87A1129F77ABDCC9B370F88AF07CE8C8D8D9DF1FBFD18
              86C1F9F3E713817D8F14FF4255F74C4D4D856CDBC6E572B9804322B22B266C9F
              D3E9FC7CDDBA75667F7F7F5C004DD5D5D5747474BC0DCC03B244243BA678B3AA
              96FBFD7EEBF8F1E398A649494949A8A0A0A01CF08A8837B20BD9C0475EAFF70E
              30110FC0644F4F0F22726806FFD1898909ABAAAA8A898909006A6B6BC9CCCCB4
              162C587014F0460345644F045AE36A42CB7AE200DD1F0804A68B47E3BBBABA00
              FA674A8A0BC0ED76A3AAE60CEED54B972E253333735A484E4E66E5CA9500AB67
              C831E30158E8F17870381CF35535CDB6ED15AA1ABB253B1C0E47DEF6EDDB59BE
              7C39F9F9F9949595E176BBF3801DD12055B56CDB5EAEAA69AA9A1E4F0FBCB671
              E3C6AA356BD60CDDBB778F9A9A9A2B0303036744E41500114953D5FAA4A4A4BD
              5BB66CA98BE46C023E1191E9514D55CFA8EAD593274F120C061F7C05232323A9
              6D6D6D054F0028003600A1BEBEBE9F55F508B05F55CF894862042207A854553B
              F2FBA11D8E1CDF7EC330686D6DC5B6ED0700DDDDDD391515158FCDED33D8EB4E
              A7B311F011BE0B3E8D753E5A3806609FAAFA1A1B1B89FE1FCCF62A4E364D337A
              073CF74F93442413A0AFAF6F5A7302A5B30018077E273CF9EC8D8AAADA0DB400
              7911A90B5819391A803D227238373737100C06C30075757595B300202B2B8B55
              AB56CD07BA09F707C03BB66D7F3B39191E0D5D2E17090909DB80EF098F82BD22
              92AEAA81E83ACE969696D9D42723238365CB965D4F4E4E7E51557703AFAAEA77
              4D4D4D34343400505454C4A64D9B2A815AA049553F9E9A9ABA1F9D8600FE02F9
              234AB81947F11F0000000049454E44AE426082}
          end>
      end
      item
        Name = '2'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
              F40000000473424954080808087C086488000000F0494441545885ED97BD4AC4
              401446CF9D647F928D01DD4259418B051BF5A17C11DFC62752378AD8A8D88829
              04C3B0F9B3D0B59C9B46DCE27E3030C5E1CEE156DF80E59F231797572A144570
              B2C8383FCED9494641B6AB2A9A9B8266750FF55A9D1D4FD2AC1D629AA4993FDC
              9F4F5530CFF1D785EF9C9B32D17137E4F1BF4CBCB9EC2D9641F068B9DB9F9E1D
              0C1AEAEF1EFAE6ED3DC81465096CC1064CC0044CC0044CC0044CC0044CE0B713
              96AF8F41F029CAE43609F7BC4DFCF38B743F9D4FCB566C2052210722C2475593
              A7CAC7E4B34266298C47B0AE55011927331D029C1362270812647B7A68DBEFD3
              ABA32D7C01B6993973829F2F450000000049454E44AE426082}
          end>
      end
      item
        Name = '3'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
              F40000000473424954080808087C0864880000018B494441545885ED964D2F03
              4118C77FB3B3B14A8536D21611AF17AD467C0F5F012737711691888B38FB0612
              1FC1451C5C5D8856CB8906691B412B5E23E9EE38744BDA58629136B1BF64929D
              79F699FDCF3F3BCF0C78D41931B9B8E1180C77188C0FB4D363DE63260E312FB2
              80420B87D0C7E25CB5757290B9E3FCFAD9B500DDF0F94DA7E0ED0BC487234084
              A7ED1D300C3B70474B3CA68220B6528FCAF0F9855B019ADBC4DF42AF3C04BA87
              3E7C21361A05E02118AC1AF78FC6CA797B025CACBF983B011AC0014F8027409F
              9B1804DEFFF6EFB23A1D755503D22905348003627766D60418A9D9E77FCD71A1
              003480039E00914C244D80985DDB9D785858AEEAFB579614AE4E8132E9541A68
              0007F4B5CD530002FB1F2F6675EAF3FA30BF7EA410DF77A2982B7FB7EE0E7802
              3C016F77C2CA1DAD96CAA9F564D7EE0A2DF63E2EE64F7F24A0EE0E6880746A5D
              0143662E1F652997975A5FEFDBB88884652973A6676F9E657FC8A77F36C7574D
              3435B73AABD30452136828289960597640809428A151B21496A57ED997FFC42B
              0B4768587405B0AE0000000049454E44AE426082}
          end>
      end
      item
        Name = '4'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
              F40000000473424954080808087C08648800000442494441545885D5965D4C5B
              6518C7FFCF391D0BA3ED207C2C59C18B7921429898E1C762F611C3603AA25922
              74BA444D5C7665B60B86DEE98566638B993A12CD588626DE4837371D2D9B8B4B
              D44024AED83674A585418BA54D063DF4B4A7656DE939AF17B4ACE34B6165C4FF
              D59BE77DDFF3FFBDE7799FF31C7AEF93DF643C7EE97B7EFAECB2CBDC056E1DCC
              1F926A359BB66DD5780BB4396100303B850A0028D0E4849FD469C60160C42795
              06A58416006ACA0B1D0030154E68DD7EA92C2B00B5CF6FFD63C7D3450E00309F
              EAFD1800B6E934DEA307CB2F03C0F9ABCE37FA9D4225001C3D587E0900CC8381
              8A0B3FBA1600FC3F53F0CB9FFE9DFDCE4065666CD42795B55F7536A6C6A5E978
              3A36159E4D49560046FD5219FCB3634AC54429B1B9DF296C4EAF49C7D3A9584A
              EB92025E8980637100806ACBFD9F010095959577F47AFDA5B532B5DBED150683
              A1090066480395220158A737A0621278767FFD002863BCEE65F858001863922C
              CB669EE70700B0CCB95595E10A659563F1EBC98090D46EC8391B4C4E1F01D15C
              035C6B004B622A68F47C7511CC66DF5BC3D16DC796FC0B7EAD7ACE772D536049
              044593BBAD1D61EBC06902BB952BCBDDCFF802EAE786C79251FFBD3505B026A6
              8226F7B9F34C1A709C21D009808888DBC5838C257145FDE953DB5198B3714D00
              2C89A06874B7B53369C0D14A8466D083CAE3386E37C751D713F9F979AD2FECCE
              3A8025311534A64EDE4AA0168068FE22E2F93DC4AB8C5585C5EA6C025815C64C
              A2D98AA8EBEE4922B4649E7C0104D11E807EC816805594E2C6AEDFFF666CFBB3
              8D25F52FD72E76F245A4CD46195AC448C2D4D135CC86BDA1D3831EF1ADE3FAC6
              1B4C6134D17D73C7529B186316000D8FFA062CA21437765C7331E79878465170
              C2ED8FE8BEE8BCB3BFE8CD266BC9AB75FD4B985B01D489F198F02800D6502461
              EAE81A82732C740AA066A4FA8CC71FD19D333866215EA9FD6B9EB92D6DFE7EEF
              AD5557814D94E2C68BD75CCCE909B502F4013DDCE430EA93745F763AF6171D3E
              64494330C66C0CD817969381637DBFE26E585CF9A7983126C513C9EE6F4DC3CC
              E9099D24A21660F1DBEEF64BBAB64E47FDB1C3876E30D050A0B7EFB84B85C048
              A1963679CB1882C203805028A4B5DBED15FF06A0288A5908279283EED85E107D
              B894795A233EA9F4EB2B4EDD819A9D4D23C1C9A853145E63440C401790D18CC6
              C7C7CB0C06C382FFF6F9E279BE3C27577396E4AADB8CCBED01D1AEE5D633308B
              DB27BE7365D2168D49620323FA1EC0DBE9F915DF015996ABA625F1887A6628CA
              94E401A6B09E25CD19B382A18E9F7607A2015783A22806001B33D7A800E8570A
              410439974DA8A499D288B2A1A0018C3311D14BF3CC6D00EA66E29290C73C94BA
              A4E993F7CD3DABBABA7AA5FE739A102278F1F58FA02D2AD3701C75A72152E6FB
              62513170F3BB169496E42DD8EBF57A2108C2F217E8BF6893A618F5EF7E8EFC62
              9D964057415003688845C5C9EBDF3423786F64D9FDFF00363DFBC7FE4341C600
              00000049454E44AE426082}
          end>
      end
      item
        Name = '5'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
              F40000000473424954080808087C086488000004C4494441545885D5564D4C54
              5714FECEFB63880C3838963240A38C31C02831884D6563629AA6362E4AD49258
              DD58ABE9A271D3A44DDBA40B17BA68373569534D17A6319AD174B4BA516CD516
              8A2093603A226674F89D194C190619903777BCEF74014350673083B4A4DFEAE6
              DCEFBEF39DEFDC93FBE883C33724FE7B34B55CF8FADCBDCE8B509620F953D016
              72A8D2651F74141AE300D0D913AB010087DD187797D98700E04138511E4F8842
              00A8AF5AD10D00A3E3A2B03792A85814016FBEEE6ADB58EDEC0680CE23AD5F01
              4065997DF04063D53900F8C1D7B3D3DF13F300C081C6AAB300D07977A4E6C4F9
              7BCF09F87FB6E06A4764B3BF67C43337160A272A8EFB7A76CDACCBD3F1746C74
              7CBA258B22201449542032BDA699D8584214F97B6245694E3A9E6E45362C490B
              546B020A2701005AC9D4650080C7E3B9D3D4D474F6DF4A1A08046ABC5EEF7B00
              90223B342B0160891CD0380195A7964E00CD592FE81266010388021800100390
              04A0032864661780B5990E2D860009A0CB626E1B4B88786F388168EC314C21A1
              2A84E5F63C94AFCC435FFFE025C3306E09213E5D4C012316B3AF3F3A317CE5E6
              10EE84C6CA4D21B701A805B002C06300F789F09BCE4A874D967C6B43E4270572
              765C5F46C06052C83357DAC366737BD86D0A7904448D44A466220B2C0B08BDEA
              8B49B5E2A24D3E8C4F4CBEDC251C49A6E419EFAFBDE6A596C11DA6907E22DA49
              40C6E4004044EB40CA79A9147C3FA1BB35F7E6FD20455D9003D262F65DB91936
              5BBB867730E34CBA6A22F0A69A95A2BEDA4925C5F9565248BADB3786ABB7226A
              6232A51140203A08667BD99AFABD755BF7F1420474F54727869BDBC39516E3C7
              747285607DF86E95D858EDB4CD25AF72D9D1505BF2E49B537FA5866353FA8C1B
              BB99F1A7A761D777B9B6802DE6B6CB3787600A799488661F98CDEB5F994D1E0A
              8F8B9FAFF5992D5DC349CB62ABA8C0D0F66C5B63617A54D338AC6ABA235707A2
              630911EF0E8D9581D03877A32DF0B7E174E49BAB4A0B70CCDBAD4B8B75009016
              27B7D495DA2ACBECAAA12B52A42C6DC60507187B721530D01B4EC014F29D676F
              BB65B172E146BF0D00A7CB54095C529C4F00907A62B194FCACE3DB7315101B8E
              3D06A6E73C1B8800AC76D9C5FB6FBBF1DAAB05790070DD1F956957E6A0365701
              4953580051F17CA4D5AE02F1C99EF5AAAE29AA484979E1F78127CDED612383D4
              E25C05688A02003CF5F493F234B6D49592AE292A009C387F2F753B386ACBCC64
              33D729285A6E370046703E923E23D3B258DC0E8EE6652532823939C0CCA5654E
              1B08B8361FEFF4E507D277BD5F581613E6B30AB8362BE0D1A347858140A0E605
              1AD6F6F60D5CD2A076A478598088D665223997DBA8B8304FB5183C3A9ECC568C
              04707256C0D0D05085D7EB7DEEBFFD591886D1912F4B8EA5F4AA2F19E4A30C15
              BEF546B9565FED246616078FB466FBD469660EE4FC1809213EB3C98843B5267F
              01F3F15CCF030033DF67E0D04834080D4053AE1F50208B6CF2617C5259F63133
              EC44B47BEE7E737B98FD774788999F7B1D99F901806D32958CB7F88E82366CD8
              B090223031390577C37EB8DC9B88808F001C26224736FE4CCF4F337048A692F1
              ABA73E4724E49FF786BE10A4A8A8DBBA0F9E865D5035DD41A0BD00B603A80551
              3198A70004313D35279939108B06F187EF28E20F4300807F003406183DE5139E
              CD0000000049454E44AE426082}
          end>
      end
      item
        Name = '6'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
              F40000000473424954080808087C08648800000491494441545885ED965D6CD3
              6514C67F4F57BA765F5D29762BCB186C730A934061E31B84A85916629811821B
              5191C410A289C168D4C4E08D37440D262492A0C644918F7161425886C10BA364
              6A0417238328664B5829B0D9C13660EEF378D176745F82C8C70D4FD28BF7FF9E
              BECFEF7FDE734E2B46A9B2B2925028740058377AEFBFCACC8E03156D6D6D97F6
              EEDD4B4F4FCF9818C7FF35F937492A03EA038140764D4D0D1E8F674C8CF34687
              94969636DD8A7967676756381CCE97B4C0CCBE0E040215353535974767E28600
              EBD7AFAFBD158093274F96D6D6D6E603482A37B3FA402050595D5D7D79DFBE7D
              C31077F40A9225692170242727C79B7C1D770D200EB180584D78ABABABF1783C
              7717200EB108A84F64E2AE032441D4050281AC7B0210875802D4DFB00B6E5579
              7979AD555555C31DE47038703A63760D0D0D8BE32DBAF88E01F87CBE2E9FCF37
              EE0C696A6A2A0D87C331B03B0570B3BA0F701FE09E034CD4863B80837EBF9F48
              24D2140C0691745B0CA3D1281D1D1D4B80528031A7E6E7E7E3F7FB01C8C8C820
              180CE2F57A6F8B39403018C4CC0E0C0D0DAD0370AED9F2318601D0DE7A8A1F0E
              7F486B6B2B009352D3083DB68982FCA5B8DC99315C8381FE5ECEB73472E2E86E
              AE76B6C54E9698F1C82A1E2E5F832FB710A1E1F89E2B1D84FFF891533F7DC5F2
              4573098542C340CE29790F351906C6E7BDD7BAB727365CEE0C566FDE45B63F7F
              8AA46D4095A4A099B5A57A320F17CD7962DBD4E20517EB766FA1FB5284E54FBD
              4971A8C221B4117801311B94825973AA27B32EFB81828F7CB945612E7E332223
              4E60A61086E5246FCC5DF93C5E7FBE5FD231492589E79282C08B983DEE49F32E
              5DBAE6B50B674F7D4F71A8224568BFA4A7473848B381D966D689B19D511ABF08
              251E2C5B8D437A37616E668DC031601ED2124933C0DE0B4E9FFBAC2FA71099B6
              CA113337B376E070EC0258094C33EC8BAB5DED64DE0CC0E49C425CA9E96EE099
              F881BF822D36A30FE41076146915B01687E36577BAB71BD81A8FBD6066E56643
              E706FB7B71BAD252100B31227F361E21343338C26BDC39E04ECF46304B52A2FC
              F7F4F65CE93BF0FE5ADAC3A787803DB1442955305F6856FC6A003E019D931CAE
              49AE34172245701CE49CF3E87363BC261E44223769D5DCD2F42DD7BAFEE2CC2F
              75002D497BB906D392D6BF4920A905292A14054525ED18DBF437F1B73C266370
              A00F80C1817ECC2C793049C4FB38A6A1D843A501E9C32718A9E38DB28933605C
              B8BED08C8299CB704E725350BA0249D39322CFC73F09C58A16DB6DB0D3A02F41
              399E4664C03FB5848A8D1F90EAC9C28CD3609DF13AD890EE0DEC5CFBEABE7E4F
              C66407B021FE56BD0627C0AE015D4259C02633DB25F40618923602AE89DE3319
              E049775A56615E715922A15F02FB81CD924218C7D232267F079421AD88A7E920
              D0393438484A8AF333C42B928A8046626D3804B827321F0110FF62516C0166F6
              B3616F63AC925422A91C284FC49B5933F07A34F23BD1C8194AE6AFDE062C9734
              4F5201F052B2919931B254AE03344F007719236AB00CECFA28C6DA300E01EF0C
              F4FDDDD6706807DD9722048BCBBB33BD392BC1DE02D6214D07EBC7380B34009F
              1A637FFDFE011C0A86EB28929F2C0000000049454E44AE426082}
          end>
      end>
    Left = 56
    Top = 103
  end
  object ImageList: TVirtualImageList
    Images = <
      item
        CollectionIndex = 0
        CollectionName = '0'
        Name = '0'
      end
      item
        CollectionIndex = 1
        CollectionName = '1'
        Name = '1'
      end
      item
        CollectionIndex = 2
        CollectionName = '2'
        Name = '2'
      end
      item
        CollectionIndex = 3
        CollectionName = '3'
        Name = '3'
      end
      item
        CollectionIndex = 4
        CollectionName = '4'
        Name = '4'
      end
      item
        CollectionIndex = 5
        CollectionName = '5'
        Name = '5'
      end
      item
        CollectionIndex = 6
        CollectionName = '6'
        Name = '6'
      end>
    ImageCollection = Collection
    Left = 56
    Top = 159
  end
end
