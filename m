Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUGEWGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUGEWGx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 18:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUGEWGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 18:06:53 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:45793 "EHLO
	fmmailgate03.web.de") by vger.kernel.org with ESMTP id S261426AbUGEWGu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 18:06:50 -0400
Date: Tue, 06 Jul 2004 00:06:44 +0200
Message-Id: <971513340@web.de>
MIME-Version: 1.0
From: "Michael Thonke" <TK-SHOCKWAVE@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm6 usb lockup also with reverted bk-usb.path and usb-locking-fix
Organization: http://freemail.web.de/
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="---SKER1089065209--";
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is MIME

-----SKER1089065209--
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

No Andrew I didn't tried it so far but i will give it a try.
Thanks, i will let you know if it worked or not


Andrew Morton <akpm@osdl.org> schrieb am 05.07.04 23:53:05:
> 
> "Michael Thonke" <TK-SHOCKWAVE@web.de> wrote:
> >
> > Hello Andrew,
> > 
> > I followed your advise in the changlog.I reverted the bk-usb.patch and usb-loocking-fix but my system still not boot after the frist uhci_hcd detected. And now I don`t know what is wrong 2.6.7-mm5 works fine.
> > 
> > My system is a Intel Pentium 4 (Prescott) and HT enabled also the motherboard is from Abit (IC7 model) any hints or help are welcome.
> > 
> 
> Could you try reverting bk-acpi as well?


_______________________________________________________
WEB.DE Video-Mail - Sagen Sie mehr mit bewegten Bildern
Informationen unter: http://freemail.web.de/?mc=021199
-----SKER1089065209--
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIFnAYJKoZIhvcNAQcCoIIFjTCCBYkCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3
DQEHAaCCA/gwggP0MIIC3KADAgECAgQCWmg9MA0GCSqGSIb3DQEBBAUAMIGgMQsw
CQYDVQQGEwJERTESMBAGA1UEChMJV0VCLkRFIEFHMRUwEwYDVQQLEwxUcnVzdCBD
ZW50ZXIxGjAYBgNVBAcTEUQtNzYyMjcgS2FybHNydWhlMS0wKwYDVQQDEyRXRUIu
REUgVHJ1c3RDZW50ZXIgRU1haWwtWmVydGlmaWthdGUxGzAZBgkqhkiG9w0BCQEW
DHRydXN0QHdlYi5kZTAeFw0wNDAzMjUyMDA4MTdaFw0wNTAzMjUyMDA4MTdaMHgx
CzAJBgNVBAYTAkRFMRQwEgYDVQQIEwtEZXV0c2NobGFuZDEWMBQGA1UEBxMNMzc1
NzQgRWluYmVjazEXMBUGA1UEAxMOTWljaGFlbCBUaG9ua2UxIjAgBgkqhkiG9w0B
CQEWE3RrLXNob2Nrd2F2ZUB3ZWIuZGUwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJ
AoGBAMg4IXsINDZoD1rOvKsOxlh5+HOv+TwvVRclmVermVUViuP4JBJIXhk3G+6n
/Zo9gCG0McI/oOxWNCDTQ++b6Nl0orJKhTj18CE1aa2wSdAupw8lwnpIPiP3yyhL
A8567M33Y+sMD1RiO25ayqRX+qekYgDZ75Zut1VDurkEyFYZAgMBAAGjgeAwgd0w
LAYJYIZIAYb4QgEEBB8WHWh0dHBzOi8vdHJ1c3Qud2ViLmRlL3J2Q0EvP3M9MCMG
CWCGSAGG+EIBAgQWFhRodHRwczovL3RydXN0LndlYi5kZTAWBglghkgBhvhCAQME
CRYHL3J2Lz9zPTAWBglghkgBhvhCAQcECRYHL3JuLz9zPTAaBglghkgBhvhCAQgE
DRYLL0hpbGZlL0FHQi8wKQYJYIZIAYb4QgENBBwWGkZyZWVtYWlsIEVtYWlsIGNl
cnRpZmljYXRlMBEGCWCGSAGG+EIBAQQEAwIAsDANBgkqhkiG9w0BAQQFAAOCAQEA
qKB0cBp4MDMrBWKqEZ+xHq406LxR5tJxkDIHpIJ1PFVreFeO0HjN+MWLgW+XS/BJ
se07Db39h6egmAALvcrDZnJVs93ynAkBZCNU3zxACgViPGTO1ajxXqaLte0FbOfV
EOJH3f9BX931HqbbngXMd7PXhhUo9yUR5/knus4QYbMkBRPjb/Mb1XL++doqM9qg
Mh8goWSZfXwH0OZhVGqS4zjtkZpGR9Okg8wontgnuaCJeW0j8Tu5hNeHxg0NYe1f
hvH6mmx/HNhfufsZjMM/y9XKias0/Gincc/JLUYs5r9U+B4xbMShQT3FIpukN/5b
PcDcX74ocMSqgzQBKCdZvzGCAWwwggFoAgEBMIGpMIGgMQswCQYDVQQGEwJERTES
MBAGA1UEChMJV0VCLkRFIEFHMRUwEwYDVQQLEwxUcnVzdCBDZW50ZXIxGjAYBgNV
BAcTEUQtNzYyMjcgS2FybHNydWhlMS0wKwYDVQQDEyRXRUIuREUgVHJ1c3RDZW50
ZXIgRU1haWwtWmVydGlmaWthdGUxGzAZBgkqhkiG9w0BCQEWDHRydXN0QHdlYi5k
ZQIEAlpoPTAJBgUrDgMCGgUAMA0GCSqGSIb3DQEBAQUABIGAshTUUV9NDDxSa/cu
c6jfyxg5P4Gq7+pFJXaw/orK4yaTX61xXGBJP5744q2li/9br5TDaXKvJtRrHl1b
JJe553U6A9q2/GFc2WP76GjKQOgYSmk5I6v9zZyCntsiadhAPVV/JhN7x3Yz17Jh
ckpHSrX+L3KvyEEasPDfGty4aGmhGjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
-----SKER1089065209----

