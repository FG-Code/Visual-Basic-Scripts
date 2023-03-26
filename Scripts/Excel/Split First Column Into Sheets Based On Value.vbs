Sub parse_data()
    Dim xRCount As Long
    Dim xSht As Worksheet
    Dim xNSht As Worksheet
    Dim I As Long
    Dim xTRrow As Integer
    Dim xCol As New Collection
    Dim xTitle As String
    Dim xSUpdate As Boolean
    Set xSht = ActiveSheet
    On Error Resume Next
    xRCount = xSht.Cells(xSht.Rows.Count, 1).End(xlUp).Row
    xTitle = "A1:K1" 'Change cell range here
    xTRrow = xSht.Range(xTitle).Cells(1).Row
    For I = 2 To xRCount
        Call xCol.Add(xSht.Cells(I, 1).Text, xSht.Cells(I, 1).Text)
    Next
    xSUpdate = Application.ScreenUpdating
    Application.ScreenUpdating = False
    For I = 1 To xCol.Count
        Call xSht.Range(xTitle).AutoFilter(1, CStr(xCol.Item(I)))
        Set xNSht = Nothing
        Set xNSht = Worksheets(CStr(xCol.Item(I)))
        If xNSht Is Nothing Then
            Set xNSht = Worksheets.Add(, Sheets(Sheets.Count))
            xNSht.Name = CStr(xCol.Item(I))
        Else
            xNSht.Move , Sheets(Sheets.Count)
        End If
        xSht.Range("A" & xTRrow & ":A" & xRCount).EntireRow.Copy xNSht.Range("A1")
        xNSht.Columns.AutoFit
    Next
    xSht.AutoFilterMode = False
    xSht.Activate
    Application.ScreenUpdating = xSUpdate
End Sub

