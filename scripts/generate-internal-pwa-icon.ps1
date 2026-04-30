$ErrorActionPreference = "Stop"

Add-Type -AssemblyName System.Drawing

$root = Split-Path -Parent $PSScriptRoot
$driveLogoRoot = "C:\Users\andyg\My Drive\Mr Mallorca Golf\Logos and Signature"
$repoLogoRoot = Join-Path (Split-Path -Parent $root) "mrmallorcagolf-real\public"

$logo = Join-Path $driveLogoRoot "MMG_Logo_White_Transparent.png"
if (!(Test-Path $logo)) {
  $logo = Join-Path $repoLogoRoot "MMG_Logo_White_Transparent.png"
}
if (!(Test-Path $logo)) {
  throw "Could not find MMG_Logo_White_Transparent.png"
}

$app = @{
  Label = @("Internal")
  Logo = $logo
  Background = "#6D2437"
  Foreground = "#F7F4EF"
  Accent = "#B8973C"
}

$fontCollection = New-Object System.Drawing.Text.PrivateFontCollection
$brandFontPath = Join-Path $env:WINDIR "Fonts\CormorantInfant-Bold.ttf"
if (Test-Path $brandFontPath) {
  $fontCollection.AddFontFile($brandFontPath)
}

function ColorFromHex($hex) {
  $value = $hex.TrimStart("#")
  return [System.Drawing.Color]::FromArgb(
    [Convert]::ToInt32($value.Substring(0, 2), 16),
    [Convert]::ToInt32($value.Substring(2, 2), 16),
    [Convert]::ToInt32($value.Substring(4, 2), 16)
  )
}

function Draw-Icon($app, $size, $path) {
  $bitmap = New-Object System.Drawing.Bitmap $size, $size
  $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
  $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
  $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

  $background = New-Object System.Drawing.SolidBrush (ColorFromHex $app.Background)
  $foreground = New-Object System.Drawing.SolidBrush (ColorFromHex $app.Foreground)
  $accent = New-Object System.Drawing.SolidBrush (ColorFromHex $app.Accent)

  $graphics.FillRectangle($background, 0, 0, $size, $size)

  $pad = [int]($size * 0.06)
  $accentH = [Math]::Max(10, [int]($size * 0.04))
  $graphics.FillRectangle($accent, 0, ($size - $accentH), $size, $accentH)

  $logoSize = [int]($size * 0.58)
  $logoX = [int](($size - $logoSize) / 2)
  $logoY = [int]($size * 0.07)
  $logoImage = [System.Drawing.Image]::FromFile($app.Logo)
  $graphics.DrawImage($logoImage, $logoX, $logoY, $logoSize, $logoSize)
  $logoImage.Dispose()

  $fontFamily = if ($fontCollection.Families.Count -gt 0) { $fontCollection.Families[0] } else { New-Object System.Drawing.FontFamily "Georgia" }
  $format = New-Object System.Drawing.StringFormat
  $format.Alignment = [System.Drawing.StringAlignment]::Center
  $format.LineAlignment = [System.Drawing.StringAlignment]::Center
  $format.FormatFlags = [System.Drawing.StringFormatFlags]::NoClip

  $textAreaTop = $logoY + $logoSize + [int]($size * 0.015)
  $textAreaBottom = $size - $accentH - [int]($size * 0.02)
  $textAreaHeight = $textAreaBottom - $textAreaTop
  $textWidth = $size - ($pad * 2)

  $fontSize = [int]($size * 0.17)
  do {
    if ($font) { $font.Dispose() }
    $font = New-Object System.Drawing.Font $fontFamily, $fontSize, ([System.Drawing.FontStyle]::Bold), ([System.Drawing.GraphicsUnit]::Pixel)
    $measured = $graphics.MeasureString($app.Label[0], $font)
    $fontSize -= 1
  } while ($measured.Width -gt $textWidth -and $fontSize -gt 16)

  $rect = New-Object System.Drawing.RectangleF $pad, $textAreaTop, $textWidth, $textAreaHeight
  $graphics.DrawString($app.Label[0], $font, $foreground, $rect, $format)

  $dir = Split-Path -Parent $path
  New-Item -ItemType Directory -Force -Path $dir | Out-Null
  $bitmap.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)

  $format.Dispose()
  if ($font) { $font.Dispose() }
  $accent.Dispose()
  $foreground.Dispose()
  $background.Dispose()
  $graphics.Dispose()
  $bitmap.Dispose()
}

$iconDir = Join-Path $root "internal\icons"
Draw-Icon $app 512 (Join-Path $iconDir "icon-512.png")
Draw-Icon $app 192 (Join-Path $iconDir "icon-192.png")
Draw-Icon $app 180 (Join-Path $iconDir "apple-touch-icon.png")
Write-Host "Generated internal PWA icons"
