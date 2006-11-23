Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757096AbWKWA4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757096AbWKWA4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 19:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757102AbWKWA4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 19:56:30 -0500
Received: from smtp1.netcabo.pt ([212.113.174.28]:45378 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1757037AbWKWA43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 19:56:29 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAG6AZEVThFhodGdsb2JhbACBT4sBAQ
X-IronPort-AV: i="4.09,449,1157324400"; 
   d="p7s'?scan'208"; a="134835902:sNHT23929974"
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.128.90):SA:0(0.5/5.0):. Processed in 1.83742 secs Process 615)
Subject: Re: [OT] Re: bug? VFAT copy problem
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: DervishD <lkml@dervishd.net>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       The Peach <smartart@tiscali.it>, linux-kernel@vger.kernel.org
In-Reply-To: <20061122145344.GB18141@DervishD>
References: <20061120164209.04417252@localhost>
	 <877ixqhvlw.fsf@duaron.myhome.or.jp> <20061120184912.5e1b1cac@localhost>
	 <87mz6kajks.fsf@duaron.myhome.or.jp>
	 <1164204175.10427.1.camel@localhost.localdomain>
	 <20061122145344.GB18141@DervishD>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-3E9b8v7pWurd8lD7oMr3"
Date: Thu, 23 Nov 2006 00:56:25 +0000
Message-Id: <1164243385.3525.19.camel@monteirov>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
X-OriginalArrivalTime: 23 Nov 2006 00:56:27.0586 (UTC) FILETIME=[34BC5A20:01C70E9A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3E9b8v7pWurd8lD7oMr3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-11-22 at 15:53 +0100, DervishD wrote:
>     Hi S=E9rgio :)
>=20
>  * Sergio Monteiro Basto <sergio@sergiomb.no-ip.org> dixit:
> > Have vfat a limit of a file size when copy ?=20
>=20
>     2GB, if I recall correctly. FAT32 itself has a limit of 4GB-1 for
> file size, but Linux restricts it even more (don't ask me why).

May I say that FAT32 have a bigger limit (at least on last Windows).

The file in question have 4491771904 bytes, 4288 mega bytes , 4.2G or
4.5G if use powers of 1000.

I copy the file from one FAT32 to my computer (ext3), now I would like
to copy to other FAT32. But I just copy 4096 mega bytes (and terminate
with an error of limit file exceed) .

Have you a solution for the case ? Now I have the file in ext3 and I
couldn't copy to any vfat  :)
I have a solution with cifs or smbmount, but in same computer ? =20

Thanks,=20
>=20
>     Ra=FAl N=FA=F1ez de Arenas Coronado
>=20
--=20
S=E9rgio M.B.

--=-3E9b8v7pWurd8lD7oMr3
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGSTCCAwIw
ggJroAMCAQICAw/vkjANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDUxMTI4MjIyODU2WhcNMDYxMTI4MjIyODU2WjBLMR8wHQYDVQQD
ExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSgwJgYJKoZIhvcNAQkBFhlzZXJnaW9Ac2VyZ2lvbWIu
bm8taXAub3JnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApCNuKD3pz8GRKd1q+36r
m0z7z+TBsbTrVa45UQsEeh9OQGZIASJMH5erC0u6KbKJ+km97RLOdsgSlKG6+5xuzsk+aqU7A0Gp
kMjzIJT7UH/bbPnIFMQNnWJxluuYq1u+v8iIbfezQy1+SXyAyBv+OC7LnCOiOar/L9AD9zDy2fPX
EqEDlbO3CJsoaR4Va8sgtoV0NmKnAt7DA0iZ2dmlsw6Qh+4euI+FgZ2WHPBQnfJ7PfSH5GIWl/Nx
eUqnYpDaJafk/l94nX71UifdPXDMxJJlEOGqV9l4omhNlPmsZ/zrGXgLdBv9JuPjJ9mxhgwZsZbz
VBc8emB0i3A7E6D6rwIDAQABo1kwVzAOBgNVHQ8BAf8EBAMCBJAwEQYJYIZIAYb4QgEBBAQDAgUg
MCQGA1UdEQQdMBuBGXNlcmdpb0BzZXJnaW9tYi5uby1pcC5vcmcwDAYDVR0TAQH/BAIwADANBgkq
hkiG9w0BAQQFAAOBgQBIVheRn3oHTU5rgIFHcBRxkIhOYPQHKk/oX4KakCrDCxp33XAqTG3aIG/v
dsUT/OuFm5w0GlrUTrPaKYYxxfQ00+3d8y87aX22sUdj8oXJRYiPgQiE6lqu9no8axH6UXCCbKTi
8383JcxReoXyuP000eUggq3tWr6fE/QmONUARzCCAz8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEF
BQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUg
VG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24g
U2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTEr
MCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAw
MDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3Vs
dGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWlu
ZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me
7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r
1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCB
kTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhhd3Rl
LmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNVHREEIjAg
pB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQADgYEASIzRUIPq
Cy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6EsZkbAMUa
C4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpbNU1341YheILcIRk13iSx
0x1G/11fZU8xggHvMIIB6wIBATBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNz
dWluZyBDQQIDD++SMAkGBSsOAwIaBQCgXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0wNjExMjMwMDU2MThaMCMGCSqGSIb3DQEJBDEWBBTJuOgi1T+T0A2eugKG0Uq5
+3KZVTANBgkqhkiG9w0BAQEFAASCAQBT2CkxIyrQ/GuF+v1o6rUe7iDntlpOCkgNKc0vvRj0ezcl
vNyvUFvqp3OHas3E+wVlRMsTt1xHxK3XZlEPRJIxDmWOtWcDjEsD8/7g6bPAKntK7gMpogisK26j
gTBzPeSZ0XJYpRl37mfOq9VsXchZN1TFmMHMw1iDxDMzQ/QRdwFs1mnk1XmJNwpAHc2pR70oNbdO
E5KP0VDz1/gvWHQtD8wKh8cA5MSUlxNfO72gCdWcxVPcUgoW1Xh7AyKfmFoT2HMv2BUK1RnAPC31
anZHMcwfFQuhTrheEdBQfH5TYQ7P0EnvgHKjbJia25Bo5pHQRRoZOmzP4/+vCvk0InRrAAAAAAAA



--=-3E9b8v7pWurd8lD7oMr3--
