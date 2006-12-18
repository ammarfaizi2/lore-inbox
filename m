Return-Path: <linux-kernel-owner+w=401wt.eu-S932074AbWLRA2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWLRA2Z (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 19:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWLRA2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 19:28:25 -0500
Received: from smtp4.netcabo.pt ([212.113.174.31]:51622 "EHLO
	exch01smtp11.hdi.tvcabo" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932074AbWLRA2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 19:28:24 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAOZuhUVThFhodGdsb2JhbACNbwE
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.129.93):SA:0(-1.4/5.0):. Processed in 2.898764 secs Process 13865)
Subject: Re: kernel-rt-15 give NETDEV WATCHDOG: eth1: transmit timed out
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-rt <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1166314848.11625.9.camel@monteirov>
References: <1166314848.11625.9.camel@monteirov>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-JDM4Y5LHfRVs5OJB4h2j"
Date: Mon, 18 Dec 2006 00:28:26 +0000
Message-Id: <1166401706.3575.5.camel@monteirov>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
X-OriginalArrivalTime: 18 Dec 2006 00:28:22.0276 (UTC) FILETIME=[6C8A3440:01C7223B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JDM4Y5LHfRVs5OJB4h2j
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

After many hours of stressing network I could reproduce once NETDEV
WATCHDOG: eth1: transmit timed out on rt-14, but is not so frequently as
on rt15. I just reproduce one time on rt14 with many many stress, on
rt15 is much more frequently.


On Sun, 2006-12-17 at 00:20 +0000, Sergio Monteiro Basto wrote:
> Hi,=20
> kernel-rt-14 rocks but wiht kernel-rt-15 I got kernel: NETDEV WATCHDOG:
> eth1: transmit timed out, I downgrade to kernel-rt-14 and that got this
> problem anymore.
>=20
> I not use my on-board via-rhine II Ethernet.=20
> This tests has been made with one external Ethernet card, one Realtek
> Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
>=20
> kernel-rt-14 without notsc option and boot clean, don't have any oops
> anymore.
>=20
> Thanks,
--=20
S=E9rgio M.B.

--=-JDM4Y5LHfRVs5OJB4h2j
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
SIb3DQEJBTEPFw0wNjEyMTgwMDI4MThaMCMGCSqGSIb3DQEJBDEWBBQ2cYnfgb8WdY2lrc25QMns
MZVvlTANBgkqhkiG9w0BAQEFAASCAQCZXDrL7Hjobz7G0sbsjr/QkRh8vVFLkCVbx7YccImWttsu
xARESL7m0tf7/XTByfuTbi8kK0ldrFHP280BKkFo8fLyiSxfF+EhdHBtV8BLD3Sl2l4GqfVPabSE
kGteHaDJlvrr18vNXxpHlklNV7cLXuNvtkbPfI8lleqw2Ovc3d8HrwIdBxzaOFvClnhMW/GfavdL
szCW3lMTG8CnGoRzMoaxIXD7x4hy5GSKRRu8xuIKXvnYnLftHA3OZ6IIsES16Sn2UXw2i51cVblj
HDQgG44sfOtWVtSNnpVn8Sh34b3BDfEyhzY763ONqGORlWVPQekdSr3FG0ndqKuQcE38AAAAAAAA



--=-JDM4Y5LHfRVs5OJB4h2j--
