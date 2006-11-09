Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423981AbWKIBSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423981AbWKIBSZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 20:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423993AbWKIBSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 20:18:25 -0500
Received: from smtp3.netcabo.pt ([212.113.174.30]:7200 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1423981AbWKIBSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 20:18:24 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAKQPUkVThFhodGdsb2JhbACMSwE
X-IronPort-AV: i="4.09,401,1157324400"; 
   d="p7s'?scan'208"; a="125049346:sNHT25656597"
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.181.60):SA:0(-1.3/5.0):. Processed in 2.321235 secs Process 5720)
Subject: Re: [PATCH] pci quirks: Sort out the VIA mess once and for
	all	(hopefully)
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Daniel Drake <dsd@gentoo.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
In-Reply-To: <1163018356.23956.88.camel@localhost.localdomain>
References: <1163003156.23956.40.camel@localhost.localdomain>
	 <45523848.7010709@gentoo.org>
	 <1163018356.23956.88.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-pdHth8gGXK7b2ellht2k"
Date: Thu, 09 Nov 2006 01:18:13 +0000
Message-Id: <1163035093.13988.9.camel@monteirov>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
X-OriginalArrivalTime: 09 Nov 2006 01:18:22.0205 (UTC) FILETIME=[F286CAD0:01C7039C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pdHth8gGXK7b2ellht2k
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

First a salute to subject :) I hope so!

I will try the patch on my old laptop, which need the quirks, soon as
possible but I don't know if can be in this month.

On Wed, 2006-11-08 at 20:39 +0000, Alan Cox wrote:
> I think your patch is going to break stuff, without the patch will
> break more,=20

My point of view is: The stuff was already breaked in kernels before
2.6.16. And the patch is a improvement from kernel 2.6.16. Not perfect,
we now.

> and hopefully this patch will not break anything - but there is risk.
> I think it's up to Linus what he wants to do for .19=20

yap, it a risk because, drivers team tend to workaround the problems and
when we change IRQ routing, in this case correctly, workaround may blow
it.

Thanks,
--=20
S=E9rgio M.B.

--=-pdHth8gGXK7b2ellht2k
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
SIb3DQEJBTEPFw0wNjExMDkwMTE4MDhaMCMGCSqGSIb3DQEJBDEWBBTMbGY2a0AGM19RpA/L1xB/
t3psQTANBgkqhkiG9w0BAQEFAASCAQBwMA4VGQuayTV3ne5ycD7NbD6WHUAKBZBt3WMFf/uTDPh0
eoIPyAdjFIhxlVc6a2EtCFwCKi1CHIJSfH01R4zxgDHhEjo1FNDKHes3AhP9rchT3rbsHOftx+AI
4CbpCOixXd6mqEpZYHezNYsHOiotOfueGWxoARXtdqyId3YTpcqKR5THaTP3da3lBt1PSnn9eNrP
JXrIAtBJBfT+Fd/EQFfxwn2T+RXQwjq3pBYy7/d683yHeWS6esIUalrxIlE2O9nfbIzRQhSHojrh
x4FO810AiHfsYjbznOO2r/NZeHJNoJ37VQBr7nNDgvUc+qxsSD0Jj0eIbkYCJikKF86iAAAAAAAA



--=-pdHth8gGXK7b2ellht2k--
