Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751031AbWHAVk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWHAVk1 (ORCPT <rfc822;akpm@zip.com.au>);
	Tue, 1 Aug 2006 17:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWHAVk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 17:40:27 -0400
Received: from smtp3.netcabo.pt ([212.113.174.30]:22400 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1750829AbWHAVk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 17:40:27 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AT0KALBlz0SBUodVgS8B
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(213.22.17.217):SA:1(10.3/5.0):. Processed in 1.981578 secs Process 21578)
Subject: Re: [discuss] Re: [PATCH for 2.6.18] [2/8] x86_64: On Intel
	systems when CPU has C3 don't use TSC
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200608011910.25110.ak@suse.de>
References: <44cbba2d.ejpOKfo7QfGElmoT%ak@suse.de>
	 <1154437483.3264.14.camel@localhost.localdomain>
	 <200608011910.25110.ak@suse.de>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-iQ9cZL7HDj70fVMYiPZI"
Date: Tue, 01 Aug 2006 22:40:20 +0100
Message-Id: <1154468420.2991.5.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
X-OriginalArrivalTime: 01 Aug 2006 21:40:25.0397 (UTC) FILETIME=[193EFE50:01C6B5B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iQ9cZL7HDj70fVMYiPZI
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-08-01 at 19:10 +0200, Andi Kleen wrote:
> > I had some faith in this patch , but this just enable boot parameter
> > notsc (which I already use). And "just" disable tsc don't solve all
> the
> > problems.
>=20
> What problems do you have?
>=20
Hi Andi ,
if I boot without notsc , I have many lost timer tickets.
if I boot with notsc , I have,at begging, a few lost timer ticket, and
after some stress usb modem I got=20
uhci_hcd 0000:00:10.1: host controller process error, something bad
happened!
uhci_hcd 0000:00:10.1: host controller halted, very bad!
uhci_hcd 0000:00:10.1: HC died; cleaning up
usb 3-2: USB disconnect, address 2


Thanks for your reply
--=20
S=E9rgio M. B.

--=-iQ9cZL7HDj70fVMYiPZI
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
SIb3DQEJBTEPFw0wNjA4MDEyMTQwMTdaMCMGCSqGSIb3DQEJBDEWBBSHO9ArosoCtvxS4wJIX6Uf
nF5kkjANBgkqhkiG9w0BAQEFAASCAQBazWoAZHNq0sPGRNUg67Xl6U7waQHtiSPrEkHk4sOzSxtN
UGOK1YS1OiaecYUNfJ89oDqhUvyOLZ+12U/5xeNBmX3ec10g4uHbn3AzZyWJxwM1dgxKSvkij1rP
/jx+KKbFfcpAtrNUodhZ56dtNVlKQ3/BxjfUaYhiQZVNbr7HWBav8v8kD+xzsSrfZazlGMKfdREL
LV4N+n2YvESDjywpQQaw5/0xrBdu3dKy2WkeSx9PXEKKLL4uG475FbANJOHozXW1Aj7lhdhz7Lul
fAGEQK8iRy9xU13Aodgch/r57oPLezWRMyVpAWve67U+Bms21IzzqPGED1OjWn+NS95rAAAAAAAA



--=-iQ9cZL7HDj70fVMYiPZI--
