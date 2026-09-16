param(
    [ValidateRange(1, [int]::MaxValue)]
    [int]$Length = 32
)

$characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
$generator = [System.Security.Cryptography.RandomNumberGenerator]::Create()
$bytes = New-Object byte[] $Length
$password = New-Object System.Text.StringBuilder $Length

try {
    while ($password.Length -lt $Length) {
        $generator.GetBytes($bytes)

        foreach ($byte in $bytes) {
            if ($byte -ge 248) {
                continue
            }

            [void]$password.Append($characters[$byte % $characters.Length])
            if ($password.Length -eq $Length) {
                break
            }
        }
    }
}
finally {
    $generator.Dispose()
}

[Console]::Out.Write($password.ToString())
