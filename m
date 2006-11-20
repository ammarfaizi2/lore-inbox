Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933853AbWKTCJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933853AbWKTCJc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 21:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933855AbWKTCJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 21:09:32 -0500
Received: from smtp3.netcabo.pt ([212.113.174.30]:4543 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S933853AbWKTCJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 21:09:31 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAM6cYEVThFhodGdsb2JhbACBRosBAQ
X-IronPort-AV: i="4.09,439,1157324400"; 
   d="p7s'?scan'208"; a="132583069:sNHT24608781"
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.128.113):SA:0(-1.4/5.0):. Processed in 3.762407 secs Process 17879)
Subject: Re: 2.6.19-rc6-rt0, -rt YUM repository
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20061117092249.GA11102@elte.hu>
References: <20061116153553.GA12583@elte.hu>
	 <1163721972.3109.6.camel@monteirov>  <20061117092249.GA11102@elte.hu>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-8P44lOmU6MkBDmqaPS9t"
Date: Mon, 20 Nov 2006 02:09:26 +0000
Message-Id: <1163988566.3435.5.camel@monteirov>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
X-OriginalArrivalTime: 20 Nov 2006 02:09:29.0746 (UTC) FILETIME=[E977A720:01C70C48]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8P44lOmU6MkBDmqaPS9t
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-11-17 at 10:22 +0100, Ingo Molnar wrote:
> * Sergio Monteiro Basto <sergio@sergiomb.no-ip.org> wrote:
>=20
> > On Thu, 2006-11-16 at 16:35 +0100, Ingo Molnar wrote:
> > >    cd /etc/yum.repos.d
> > >    wget http://people.redhat.com/~mingo/realtime-preempt/rt.repo
> > >    yum update kernel=20
> >=20
> > I follow the instructions on my x86_64 with FC6, that you already know
> > (http://bugzilla.kernel.org/show_bug.cgi?id=3D6419#c47),
> > hangs on boot with or without notsc.
>=20
> hm - could you try the -rt1 package i just uploaded? It fixes a boot=20
> crash, amongst other bugfixes.

2.6.18-1.0003.fc7rt4 boots without lost tickets in dmesg because use as
clocksource: acpi_pm , but boot without notsc option still hangs on
boot, with a long oops.

Thanks,
--=20
S=E9rgio M.B.

--=-8P44lOmU6MkBDmqaPS9t
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
SIb3DQEJBTEPFw0wNjExMjAwMjA5MDlaMCMGCSqGSIb3DQEJBDEWBBRonahXiqNV0KffRhMLL4Wt
hoRBsTANBgkqhkiG9w0BAQEFAASCAQA8w1I04reGHFSkXnba9WIFlruK9O1Rcbh/vuKL8ZkweNHQ
lT34ZTSfIMolcSPDbh8hCrB1zDxTKN+QdHRZPupF0WAK8OFzaBvibDjevYUeHwJu7cMQQQRrtkeI
ljBV/8e8wWLsNNSi/P0JXErh+aJIRNnM28yKbg6BcCrl+F8UPgLkkJ1En3UsgNpoyuqfZ8qTNOTK
GDV2Wlb9neC5Qia5fLqz6mSKQy7jH+Zml8fdNev22dnRiKns54XwZawPx9TGoJuBkI2VV63zCdkr
mbJk2naZmFhLrb8lZwTZd4rDlzJ//3FenpHnFR4OqBIGoKiAdsClbw+Oj1FQ5uVSKyTLAAAAAAAA



--=-8P44lOmU6MkBDmqaPS9t--
