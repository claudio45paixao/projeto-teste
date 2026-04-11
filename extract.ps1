[xml]$stringsXml = Get-Content 'tags_extracted/xl/sharedStrings.xml' -Raw
$sharedStrings = @()
if ($stringsXml -and $stringsXml.sst.si) {
    foreach ($si in $stringsXml.sst.si) {
        $val = ""
        if ($si.t) { if ($si.t.GetType().Name -eq "String") { $val = $si.t } else { $val = $si.t.'#text' } }
        elseif ($si.r) { 
            foreach ($r in $si.r) { 
                if ($r.t.GetType().Name -eq "String") { $val += $r.t } else { $val += $r.t.'#text' }
            }
        }
        $sharedStrings += $val
    }
}

Function Read-ExcelSheet {
    param([string]$path, [string]$outName)
    [xml]$sheet = Get-Content $path -Raw
    $rows = @($sheet.worksheet.sheetData.row)
    $outData = @()
    foreach($row in $rows) {
        $rowStr = ""
        $cells = @($row.c)
        foreach($c in $cells) {
            $val = $c.v
            if ($c.t -eq "s") {
                $idx = [int]$val
                if ($idx -lt $sharedStrings.Length) {
                    $val = $sharedStrings[$idx]
                }
            }
            $rowStr += "$($c.r): $val`t"
        }
        $outData += $rowStr
    }
    $outData | Out-File -FilePath "$outName.txt"
}

Read-ExcelSheet 'tags_extracted/xl/worksheets/sheet1.xml' 'sheet1'
Read-ExcelSheet 'tags_extracted/xl/worksheets/sheet2.xml' 'sheet2'
Read-ExcelSheet 'tags_extracted/xl/worksheets/sheet3.xml' 'sheet3'
Read-ExcelSheet 'tags_extracted/xl/worksheets/sheet4.xml' 'sheet4'
