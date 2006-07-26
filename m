Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWGZM0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWGZM0i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 08:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWGZM0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 08:26:38 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:12372 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1750808AbWGZM0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 08:26:37 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AY8CAN37xkSBT4h5AQE
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:1(127.0.0.1):. Processed in 0.310696 secs Process 24787)
Subject: Re: VIA x86-64 bootlogs needed
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Andi Kleen <ak@suse.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200607251824.30504.ak@suse.de>
References: <200607251824.30504.ak@suse.de>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-WkzQPnahXwJRfcihQ6rp"
Date: Wed, 26 Jul 2006 13:26:26 +0100
Message-Id: <1153916787.29975.12.camel@bastov.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
X-OriginalArrivalTime: 26 Jul 2006 12:26:36.0395 (UTC) FILETIME=[BCBD2BB0:01C6B0AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WkzQPnahXwJRfcihQ6rp
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

This APIC rework have the goal of resolve problem with lost tickets ?=20

On Tue, 2006-07-25 at 18:24 +0200, Andi Kleen wrote:
> Hi,
>=20
> For some APIC code rework I would like to collect some statistics on
> VIA APIC setups.
>=20
> If you have a system with VIA chipset running a recent (2.6.16+) x86-64 k=
ernel=20
> please boot the system with apic=3Dverbose on the kernel command and send=
 me
>=20
> - boot output (/var/log/boot.msg or dmesg -s100000000 output after boot)
> - dmidecode output
> - lspci  -v output
>=20
> Thanks,
>=20
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
S=E9rgio M.B.

--=-WkzQPnahXwJRfcihQ6rp
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
SIb3DQEJBTEPFw0wNjA3MjYxMjI2MjZaMCMGCSqGSIb3DQEJBDEWBBRvAcS+kthwe7HUxPcZKVhQ
HXULRTANBgkqhkiG9w0BAQEFAASCAQCd6vlwS8kynPXSdkfplEDq7U/9/fmE1t9PWjMNLz/pj/S/
TXEpTegFBSDazDLrO3c/RREB6npLWhY68bHnEYfT73kE2XUfWw8gwECTIRvPq3zfR2LHdTiKb4LW
6RZvixLxPLr5H1zePTzhOHqcUlsjcCuT9eoiJKd1tJFpSMAlIc07zGSpQxcY1y2UcqtPhjncKCPQ
au01YBPcR5YmKu7ZySuYE9mbnhag4fFGw4LtOUZAR0Wh6w4zbnbwbh8FaFYqKqAGuJk+hJo469fP
DNNGyAh2XbSP8gXQ2wlMEFwr0/TwyyRh+K4opIfPU0iTtOWjAorwznjfBjsCv2+u2af7AAAAAAAA



--=-WkzQPnahXwJRfcihQ6rp--
