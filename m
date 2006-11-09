Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423952AbWKIAqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423952AbWKIAqe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 19:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423960AbWKIAqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 19:46:34 -0500
Received: from smtp4.netcabo.pt ([212.113.174.31]:12132 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1423952AbWKIAqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 19:46:33 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAKoIUkVThFhodGdsb2JhbACMSwE
X-IronPort-AV: i="4.09,401,1157324400"; 
   d="p7s'?scan'208"; a="125034829:sNHT26719605"
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.181.60):SA:0(-1.3/5.0):. Processed in 4.191371 secs Process 5177)
Subject: Re: AMD X2 unsynced TSC fix?
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: tglx@linutronix.de
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, Andi Kleen <ak@suse.de>,
       Lee Revell <rlrevell@joe-job.com>, Chris Friesen <cfriesen@nortel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, len.brown@intel.com,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <1163015628.8335.52.camel@localhost.localdomain>
References: <1161969308.27225.120.camel@mindpipe>
	 <1162009373.26022.22.camel@localhost.localdomain>
	 <1162177848.2914.13.camel@localhost.portugal>
	 <200610301623.14535.ak@suse.de>
	 <1162253008.2999.9.camel@localhost.portugal>
	 <20061030184155.A3790@unix-os.sc.intel.com>
	 <1162345608.2961.7.camel@localhost.portugal>
	 <20061031184411.E3790@unix-os.sc.intel.com>
	 <1162945339.4455.12.camel@monteirov>
	 <1163015628.8335.52.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-2THkMhSvKFCQAbbl63s2"
Date: Thu, 09 Nov 2006 00:39:40 +0000
Message-Id: <1163032780.19484.4.camel@monteirov>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
X-OriginalArrivalTime: 09 Nov 2006 00:46:31.0697 (UTC) FILETIME=[7FC66810:01C70398]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2THkMhSvKFCQAbbl63s2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-11-08 at 20:53 +0100, Thomas Gleixner wrote:
> This one is a lock dependency problem, which is fixed in -rc5-mm1

yes, oops fixed w/ and w/o notsc option.
Other question, hrtimer in 2.6.18 found acpi_pm clocksource and use it.
With 2.6.19-rcx can't get acpi_pm clocksource even trying force at boot
kernel with clocksource=3Dacpi_pm, any idea ?
because with this clocksource my lost ticket disappears=20

Thanks,
--=20
S=E9rgio M.B.

--=-2THkMhSvKFCQAbbl63s2
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
SIb3DQEJBTEPFw0wNjExMDkwMDM5MzZaMCMGCSqGSIb3DQEJBDEWBBRo5a9BIhk0QGyUEc6Ghifs
wWqxfjANBgkqhkiG9w0BAQEFAASCAQCE8B1HFcxJqB2Hq4K3vNxkAz6n6icbmu/l651aEJ3d/66Q
Pf01O+t41SQAM5fm+O7/y+5ZsV7T8WiGwDyefMC+ibYD7RTl0wORV3zBz748+EZ2kPjK2NM/Ckgk
9cSDNZLYoMhWleuKnCBAPhTQvxnnp8+P9e5eV0pWsGrGejEDyDnpVzazYqTk0ZaPTXPOFxAQQ7E7
fgK7E0SalCiX3ldvAJ9/kur+WeibRO3Jhottluz7sfHrLFxs1S8kvWF1DB4EPZa9VRz9HvXWsyBV
VToTrc1b7b5W9VtDYDVChuapmedWdBMeF27Kefzrgwpou1Zp2cHCHRNL2hOWIxKIRfjBAAAAAAAA



--=-2THkMhSvKFCQAbbl63s2--
