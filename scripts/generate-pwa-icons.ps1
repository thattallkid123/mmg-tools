$ErrorActionPreference = "Stop"

Add-Type -AssemblyName System.Drawing

$root = Split-Path -Parent $PSScriptRoot
$logoRoot = Join-Path (Split-Path -Parent $root) "mrmallorcagolf-real\public"

$apps = @(
  @{
    Slug = "guide"
    Label = @("Mallorca Golf", "Course Guides")
    Logo = Join-Path $logoRoot "MMG_Logo_Green_Transparent.png"
    Background = "#F7F4EF"
    Foreground = "#2D4A3E"
    Accent = "#B8973C"
  },
  @{
    Slug = "day-cost"
    Label = @("Mr Mallorca Golf", "Day Costs")
    Logo = Join-Path $logoRoot "MMG_Logo_White_Transparent.png"
    Background = "#2D4A3E"
    Foreground = "#F7F4EF"
    Accent = "#D4B068"
  },
  @{
    Slug = "calculator"
    Label = @("Mallorca Golf", "Course Deals")
    Logo = Join-Path $logoRoot "MMG_Logo_Grey_Transparent.png"
    Background = "#1A1916"
    Foreground = "#C4BAA9"
    Accent = "#B8973C"
  }
)

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

  $accentHeight = [Math]::Max(12, [int]($size * 0.045))
  $graphics.FillRectangle($accent, 0, 0, $size, $accentHeight)

  $logo = [System.Drawing.Image]::FromFile($app.Logo)
  $logoSize = [int]($size * 0.62)
  $logoX = [int](($size - $logoSize) / 2)
  $logoY = [int]($size * 0.045)
  $graphics.DrawImage($logo, $logoX, $logoY, $logoSize, $logoSize)
  $logo.Dispose()

  $fontFamily = if ($fontCollection.Families.Count -gt 0) { $fontCollection.Families[0] } else { New-Object System.Drawing.FontFamily "Georgia" }
  $format = New-Object System.Drawing.StringFormat
  $format.Alignment = [System.Drawing.StringAlignment]::Center
  $format.LineAlignment = [System.Drawing.StringAlignment]::Center
  $format.FormatFlags = [System.Drawing.StringFormatFlags]::NoClip

  $textTop = [int]($size * 0.655)
  $textWidth = [int]($size * 0.975)
  $textLeft = [int](($size - $textWidth) / 2)
  $lineHeight = [int]($size * 0.135)
  for ($i = 0; $i -lt $app.Label.Count; $i++) {
    $fontSize = [int]($size * 0.15)
    do {
      if ($font) { $font.Dispose() }
      $font = New-Object System.Drawing.Font $fontFamily, $fontSize, ([System.Drawing.FontStyle]::Bold), ([System.Drawing.GraphicsUnit]::Pixel)
      $measured = $graphics.MeasureString($app.Label[$i], $font)
      $fontSize -= 1
    } while ($measured.Width -gt $textWidth -and $fontSize -gt 18)

    $rect = New-Object System.Drawing.RectangleF $textLeft, ($textTop + ($i * $lineHeight)), $textWidth, ($lineHeight + 12)
    $graphics.DrawString($app.Label[$i], $font, $foreground, $rect, $format)
  }

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

foreach ($app in $apps) {
  $iconDir = Join-Path $root "$($app.Slug)\icons"
  Draw-Icon $app 512 (Join-Path $iconDir "icon-512.png")
  Draw-Icon $app 192 (Join-Path $iconDir "icon-192.png")
  Draw-Icon $app 180 (Join-Path $iconDir "apple-touch-icon.png")
}
