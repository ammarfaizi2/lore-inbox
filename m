Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945931AbWGOALI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945931AbWGOALI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 20:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945932AbWGOALI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 20:11:08 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:8668 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1945931AbWGOALF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 20:11:05 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AcwMAMXNt0SBUIc0gTIB
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:1(127.0.0.1):. Processed in 1.455995 secs Process 19686)
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060714161305.GA23918@tuatara.stupidest.org>
References: <20060714095233.5678A8B6253@zog.reactivated.net>
	 <44B77B1A.6060502@garzik.org> <44B78294.1070308@gentoo.org>
	 <44B78538.6030909@garzik.org> <20060714074305.1248b98e.akpm@osdl.org>
	 <1152891980.3205.15.camel@localhost.localdomain>
	 <20060714161305.GA23918@tuatara.stupidest.org>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-lrZy1Z9XdfITbfsFbrvi"
Date: Sat, 15 Jul 2006 01:10:58 +0100
Message-Id: <1152922258.18820.2.camel@bastov.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
X-OriginalArrivalTime: 15 Jul 2006 00:11:04.0074 (UTC) FILETIME=[294826A0:01C6A7A3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lrZy1Z9XdfITbfsFbrvi
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-07-14 at 09:13 -0700, Chris Wedgwood wrote:
> i have a patch (that takes a command line argument to override this)
> that more-or-less does that, by default it will frob all VIA devices
> if no IO-APIC or is present or you can pass an argument to always do
> everything or do nothing
>=20
> i was hoping we could figure out something smarter than just looking
> to see if an IO-APIC was found though, maybe someting like checking if
> ACPI actually did something sane, but i know zilch about the ACPI side
> of things
>=20
> i can refresh that against, -git and -mm if people want it=20

Of course, I like to see and test the patch, refresh or not.

Thanks,
--=20
S=E9rgio M.B.

--=-lrZy1Z9XdfITbfsFbrvi
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
SIb3DQEJBTEPFw0wNjA3MTUwMDEwNTJaMCMGCSqGSIb3DQEJBDEWBBRzbrwp7QSB9oHmvoTWjHR8
OdFjWTANBgkqhkiG9w0BAQEFAASCAQCXb94yhrmKtKzq2dNOnhIN3ec6W6M1NredDHb12acQbd5R
ZRGlwky9PaMFMYqWwEgixKebai1b2S424hcgTHO/Ae42HKp2aU01OwY6JESFLKWuUl+ctPn8bgZz
0JHxeF/87QzALIP2fBPDSZayf0MqbUXF2N2OY7AdPdy6m3D1nkYTaHT19hIiVMVRy9q/nD2DcfKm
G0tktWMYEK10uyzJ0MG/x+JwdAcN1JYRJ62crMzpNEPMDxJPBge0HuEaHpJ9OtRWHrp6botPQ0gV
+jHiQ0qOQmrw2VUZCTPEq2SXRIPBrz5RYTsFYI3nx/+uOMx48v9JzvTR9v+cnzLIo5+JAAAAAAAA



--=-lrZy1Z9XdfITbfsFbrvi--
