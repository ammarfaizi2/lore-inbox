Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292347AbSBULvw>; Thu, 21 Feb 2002 06:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292346AbSBULvm>; Thu, 21 Feb 2002 06:51:42 -0500
Received: from mz01.hal9001.net ([80.16.61.154]:34689 "EHLO HAL9001.net")
	by vger.kernel.org with ESMTP id <S292348AbSBULvg>;
	Thu, 21 Feb 2002 06:51:36 -0500
Message-ID: <3C74DF02.DE5CAB74@hal9001.net>
Date: Thu, 21 Feb 2002 12:50:26 +0100
From: Stefano Biella <sbiella@hal9001.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel panic on asus a7a266 and athlon xp 1600+
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------msC4C6C7D904EEE746FA88D541"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------msC4C6C7D904EEE746FA88D541
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I have several kernel panic on server running with a Asus A7A266
(chipset Ali M1647 North Bridge and M1535D South Bridge) and a Athlon XP
1600+

I run 2.4.17 kernel.

Are there any bugs with this Motherboard/Chipset/CPU?

The 2.4.18-rc2 or the 2.4.18-rc2-ac1 might help to fix the problem?

I run a _very_ conservative bios settings, but the kelnel panic halt the
machine at least on time every day... :-(

Any help? :-)
--------------msC4C6C7D904EEE746FA88D541
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIFHQYJKoZIhvcNAQcCoIIFDjCCBQoCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3DQEHAaCC
AtYwggLSMIICO6ADAgECAgEOMA0GCSqGSIb3DQEBBAUAMIGuMQswCQYDVQQGEwJJVDEPMA0G
A1UECBMGTWlsYW5vMQ4wDAYDVQQHEwVNb256YTEaMBgGA1UEChMRU3RlZmFubyBCaWVsbGEg
Q0ExKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xFDASBgNVBAMT
C2hhbDkwMDEubmV0MSIwIAYJKoZIhvcNAQkBFhNzYmllbGxhQGhhbDkwMDEubmV0MB4XDTAy
MDEwMzA4NDczOVoXDTAzMDEwMzA4NDczOVowPTEXMBUGA1UEAxMOU3RlZmFubyBCaWVsbGEx
IjAgBgkqhkiG9w0BCQEWE3NiaWVsbGFAaGFsOTAwMS5uZXQwgZ8wDQYJKoZIhvcNAQEBBQAD
gY0AMIGJAoGBAOVPL7eosufkCn2OcoUn7CnT5uXlAbkAPaPfdoxQwYNmqCJbw2+U5ZRRYBcC
9YdcFnMIH8b5gxeiaQBnVNGTSmVkWonmDrx6oFSy4dZH5Us37Ag5rJtbO8VkDY6y60Di6+Ez
uY7LHEG5WayfaSaSl8IczwRClcTCoQscXo8qgIzzAgMBAAGjcDBuMB4GA1UdEQQXMBWBE3Ni
aWVsbGFAaGFsOTAwMS5uZXQwDAYDVR0TAQH/BAIwADAfBgNVHSMEGDAWgBQa//X4emYSll34
o4opCRVCXZyPFjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwDQYJKoZIhvcNAQEE
BQADgYEAoS4jBCM3QCuenCoPpfo1XwVbXFM3XGSr3wWi7i257oInqhc0OcCXpl2CSU2gI+Mw
9Z9bs8fIlJYraSgtuOQq/qSGY7tEG1TH8a0CVCOOhSth2PW1JEqID2swrn2q+wYgas7z5fq9
zXfgvRjRUIujekmn4/GJyXfryvsY0Yj4gTIxggIPMIICCwIBATCBtDCBrjELMAkGA1UEBhMC
SVQxDzANBgNVBAgTBk1pbGFubzEOMAwGA1UEBxMFTW9uemExGjAYBgNVBAoTEVN0ZWZhbm8g
QmllbGxhIENBMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMRQw
EgYDVQQDEwtoYWw5MDAxLm5ldDEiMCAGCSqGSIb3DQEJARYTc2JpZWxsYUBoYWw5MDAxLm5l
dAIBDjAJBgUrDgMCGgUAoIGxMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTAyMDIyMTExNTAyOFowIwYJKoZIhvcNAQkEMRYEFJMEyYyasQ/Nftq0RSIUscpA
11jKMFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMAcGBSsO
AwIHMA0GCCqGSIb3DQMCAgFAMA0GCCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUABIGAWV8+
mEuxjA4rfQ0Ilpv/fpRwOFlh+oablpJvB2BNLekZ4on9iPuqFRepNH/iNW6hvCob7e3qURrG
OoJyit62YCMKSqRb/RAIbVX5bKDoM+lw4PsupKueT78RTuAlW68l7VftS8mr84hNsmJb17hO
yBJ36I+we75QEMON9bwFYtE=
--------------msC4C6C7D904EEE746FA88D541--


