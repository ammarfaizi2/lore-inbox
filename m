Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWITAtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWITAtR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 20:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWITAtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 20:49:17 -0400
Received: from a83-132-128-147.cpe.netcabo.pt ([83.132.128.147]:5313 "EHLO
	localhost.portugal") by vger.kernel.org with ESMTP id S1750772AbWITAtQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 20:49:16 -0400
Subject: Re: Math-emu kills the kernel on Athlon64 X2
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       billm@melbpc.org.au, billm@suburbia.net
In-Reply-To: <m3fyeof3c7.fsf@defiant.localdomain>
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
	 <1158623391.13821.4.camel@localhost.portugal>
	 <m3fyeof3c7.fsf@defiant.localdomain>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-BXRSNryns0KGoH3z8FhX"
Date: Wed, 20 Sep 2006 01:48:40 +0100
Message-Id: <1158713320.3098.15.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BXRSNryns0KGoH3z8FhX
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-09-19 at 14:28 +0200, Krzysztof Halasa wrote:
> Sergio Monteiro Basto <sergio@sergiomb.no-ip.org> writes:
> > I think, math emulation is for 486 and older. 486 DX2 was the first one
> > who have math co processor, on earlier processor it should be disable .
>=20
> Actually, 486 DX had built-in FPU as well. It was missing from 486SX
> (486SX + optional 487 FPU =3D 486DX).
>=20
> For 386(DX|SX) there were 387(DX|SX) (386SX used 16-bit bus).
>=20
> Many 32-bit motherboards had a socket for Weitek (3167 for 386DX or 4167
> for 486). I think I remember a board with 386DX and 287 socket as well.
>=20
> 486DX2 meant the external clock was half the internal.

Fine :),  My (12 year old) 486DX2 already don't need Math-emu. I just
don't see how in a computer like that will be installed a kernel 2.6 .
So why code of math-emu isn't dropped ?=20

Btw I try install a kernel 2.4 in my DX2 and works but very very slow .
I think in this type of computer should be install a kernel 2.2 .=20

Thanks,
--=20
S=E9rgio M.B.

--=-BXRSNryns0KGoH3z8FhX
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
SIb3DQEJBTEPFw0wNjA5MjAwMDQ4MzZaMCMGCSqGSIb3DQEJBDEWBBRjkFGEvt3EWytKc2pNVlm8
FoSdRDANBgkqhkiG9w0BAQEFAASCAQCKkYq6qAwlB8gakaHSb5+G14A+VVYX25907Xoer2J6mPCe
buxE9z+2walEoxhXWRCMBqw3DPBIai6Smyr9e9TJD0L4symjyX2kbe1c3jxLhDE/Ru+ld+6c1fYn
uEtT2Fa3vneHEqJLnRjCqpZJgvVeqHJxu2+5hVRIxH6sZOZwMuV12XHkXGGUX6Fc1mp3f9DAS3wK
Oj9j8ZBKme2t6S+FIQgHELP5GdIyHkX6J9aQ2RDXTH3tk71d5KIM+MTXIoCfWZYJN/dUlCWiFkGD
Z78WsJ4HoW0+f+yajdpCTLA4E/OT/bv6kyUZjzx8D4YnSjwVtRYYPIqqJgjqsplV5UvNAAAAAAAA



--=-BXRSNryns0KGoH3z8FhX--

