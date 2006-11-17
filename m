Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424619AbWKQAG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424619AbWKQAG3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 19:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424617AbWKQAG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 19:06:29 -0500
Received: from smtp3.netcabo.pt ([212.113.174.30]:22435 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1424619AbWKQAG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 19:06:28 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAE+LXEVThFhodGdsb2JhbACBSYsAAQ
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.128.127):SA:0(-1.4/5.0):. Processed in 7.355871 secs Process 13665)
Subject: Re: 2.6.19-rc6-rt0, -rt YUM repository
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20061116153553.GA12583@elte.hu>
References: <20061116153553.GA12583@elte.hu>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-rycoCh77iE1VH/Gq8NJp"
Date: Fri, 17 Nov 2006 00:06:12 +0000
Message-Id: <1163721972.3109.6.camel@monteirov>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
X-OriginalArrivalTime: 17 Nov 2006 00:06:26.0995 (UTC) FILETIME=[39C40030:01C709DC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rycoCh77iE1VH/Gq8NJp
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-11-16 at 16:35 +0100, Ingo Molnar wrote:
>    cd /etc/yum.repos.d
>    wget http://people.redhat.com/~mingo/realtime-preempt/rt.repo
>    yum update kernel=20

I follow the instructions on my x86_64 with FC6, that you already know
(http://bugzilla.kernel.org/show_bug.cgi?id=3D6419#c47),
hangs on boot with or without notsc.

I would like try just the part of tglx (hrtimers dyntick)
cause PREEMPT part never works well on my computer (with spontaneous
reboots)=20


Thanks,
--=20
S=E9rgio M.B.

--=-rycoCh77iE1VH/Gq8NJp
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
SIb3DQEJBTEPFw0wNjExMTcwMDA2MDlaMCMGCSqGSIb3DQEJBDEWBBQbqX0N4J+ge9ijonYrc1Rd
3o0pEjANBgkqhkiG9w0BAQEFAASCAQCgAYoqoy4GLp5QyLo1x5cLm/UTLxYvV3WkkIpdVNadCf7K
n0S5Mij0+VPLrFKpy2LNhpllkWJ6iku0IturW28eZSL1rRXfhhdf3ljlwt5rnEExYPt+WvMAy7gz
pav7RyUc0AGmXO7/S3WKumG5Xgl+3seZdhE6KvoOFUs98Kwq3RXnae3j7fiesH2bG0fkQnXJ9yER
VlGeyooApmLBlmjPoljBQRPtNY6AdEJXXn97UNMrDAcihZJdeR84LgJm6IAS8ig551gIvJ61vE2E
WTl14q5mzY0hO6p5qGowJnt1Zk3P61YNw0OaDns4iXDYTX/XoG7iKhd2S4/jjyvrCBBqAAAAAAAA



--=-rycoCh77iE1VH/Gq8NJp--
