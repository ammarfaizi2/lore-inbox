Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759021AbWLDCuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759021AbWLDCuA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 21:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759019AbWLDCuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 21:50:00 -0500
Received: from smtp2.netcabo.pt ([212.113.174.29]:22053 "EHLO
	exch01smtp09.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1758940AbWLDCt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 21:49:59 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAKcbc0VThFhodGdsb2JhbACBZosEAQ
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.128.87):SA:0(0.2/5.0):. Processed in 3.11258 secs Process 22727)
Subject: Re: linux 2.6.19 still crashing
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4571AFED.8060200@dungeon.inka.de>
References: <4571AFED.8060200@dungeon.inka.de>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-teuLQTA6dklgQd+Nu8Ln"
Date: Mon, 04 Dec 2006 02:49:48 +0000
Message-Id: <1165200588.9189.1.camel@monteirov>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
X-OriginalArrivalTime: 04 Dec 2006 02:49:57.0507 (UTC) FILETIME=[E24F1530:01C7174E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-teuLQTA6dklgQd+Nu8Ln
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,
1st you should put this information on http://bugzilla.kernel.org/
(choose enter a new bug, may choose Category ACPI with component
config-interrupts ) for better organization, instead make your own bug
documentation.

The documentation is very good  you should attach the same information
on bugzilla

your bug kept me the attention because on bad interrupts  you have :

21:     100000   IO-APIC-fasteoi   ohci1394

Exactly oops on 100000 interrupts, I had seen this before .
I have my bug on http://bugzilla.kernel.org/show_bug.cgi?id=3D6419
which one of the bugs looks like similar to yours.=20

So, You are saying with kernel 2.6.16.31 with xen 3.0.2, you don't have
this problem , I like to try it, how or where you build this Xenified
kernel ?=20

Thanks,=20


On Sat, 2006-12-02 at 17:55 +0100, Andreas Jellinghaus wrote:=20
> my msi s270 laptop. but all vanilla kernel I ever tried do
> that, also the debian and ubuntu kernel are instable too.

> But: xen 3.0.2 plus xen'ified linux 2.6.16.31 are rock solid.
> any idea what the issue could be? I'm running 64bit kernel,
> 64bit userland (plus some 32bit apps), and the cpu is a turion
> mt-40 (sempron users seem to not have this problem).
>=20

--=20
S=E9rgio M.B.

--=-teuLQTA6dklgQd+Nu8Ln
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
SIb3DQEJBTEPFw0wNjEyMDQwMjQ5NDNaMCMGCSqGSIb3DQEJBDEWBBTdShi4z3b43DM0ASoVR8VC
2UnwpjANBgkqhkiG9w0BAQEFAASCAQCRYjb0BkgyzPsGeWqoystvAGNNB9paXSNnaqBxiYKekes0
oZ0fyKJ6/A+tPem7C4C6HD5QfViG49aoynm4EY3ey7e41uKg3wDFNw7u4qdnWrEPRT1o+NZ/QBzc
6+PRQgRQEdzdm2KlIdnlRiKagNZpmrgb3KGi+PZ3NUBve/+TJMC7vRqQGOj5DeyPT/CNeCqg11zF
XCJyAA7rvgbC/bt6qicYgj7O73huB4NUHIaa3gu7chartcI0YHxL9X7+cl18lZVyA1k3+NIXdh+D
EjBicfmkf5tAlqH/NGvVBQAKXm+ZvHOwesYBb1e8SLqDVg8yCcNquYhWfZVbbOquw9EkAAAAAAAA



--=-teuLQTA6dklgQd+Nu8Ln--
