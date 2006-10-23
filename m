Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWJWU0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWJWU0J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 16:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWJWU0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 16:26:08 -0400
Received: from smtp3.netcabo.pt ([212.113.174.30]:17124 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1750945AbWJWU0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 16:26:05 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAGS/PEVThFhodGdsb2JhbACBTIkkgTI
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.129.202):SA:0(0.6/5.0):. Processed in 2.643455 secs Process 17273)
Subject: Re: -rt7 announcement? (was Re: 2.6.18-rt6)
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: tglx@linutronix.de
Cc: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Mike Galbraith <efault@gmx.de>,
       Daniel Walker <dwalker@mvista.com>,
       Manish Lachwani <mlachwani@mvista.com>, bastien.dugue@bull.net
In-Reply-To: <1161628539.22373.36.camel@localhost.localdomain>
References: <20061018083921.GA10993@elte.hu>
	 <1161356444.15860.327.camel@mindpipe>  <1161621286.2835.3.camel@mindpipe>
	 <1161628539.22373.36.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-85AXFEIuaZsqFgYbkRv6"
Date: Mon, 23 Oct 2006 21:26:01 +0100
Message-Id: <1161635161.2948.12.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
X-OriginalArrivalTime: 23 Oct 2006 20:26:03.0423 (UTC) FILETIME=[75FD0AF0:01C6F6E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-85AXFEIuaZsqFgYbkRv6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-10-23 at 20:35 +0200, Thomas Gleixner wrote:
> On Mon, 2006-10-23 at 12:34 -0400, Lee Revell wrote:
> > On Fri, 2006-10-20 at 11:00 -0400, Lee Revell wrote:
> > > On Wed, 2006-10-18 at 10:39 +0200, Ingo Molnar wrote:
> > > > i've released the 2.6.18-rt6 tree, which can be downloaded from the=
=20
> > > > usual place:
> > > >=20
> > > >   http://redhat.com/~mingo/realtime-preempt/
> > >=20
> > > This does not work here.  It boots but then wants to fsck my disks, a=
nd
> > > dies with a sig 11 in fsck.ext3.  This is 100% reproducible and booti=
ng
> > > 2.6.18-rt5 works and does not want to fsck the disks.=20
> >=20
> > I see that -rt7 is posted.  The patch is a huge diff from -rt6.  Where
> > are the release notes?
>=20
> Basically we merged the latest hrt-dyntick queue into -rt.


rt7 should be to be applied on 2.6.18.1=20
still for 2.6.18=20

--=20
S=E9rgio M.B.

--=-85AXFEIuaZsqFgYbkRv6
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
SIb3DQEJBTEPFw0wNjEwMjMyMDI1NTdaMCMGCSqGSIb3DQEJBDEWBBSa2zU5RODkSj2VQLm8+e6p
WUly7jANBgkqhkiG9w0BAQEFAASCAQBBCaTH8aN3nwTsqdNiZNOE1vKq1WSBYgcc6/A5NZOz5deI
a/4/cMzFkBvgMwgC7q4BhfHKg/CAXYApSpM0hz2ikRzIUgYTsHgBzTM5YRtrlEzdVONu6wknNkHH
MTbrKdIbHeahV/2uKjVU0icKQM2N7TJbqgnWvmB/RP4+OoSqUlv42RM620XRW302c7VY1chOnSQm
/lGUroYp4EHX0AcWCtat4a8suV/MFyTM8aOzgM3nDEguk0OqhIEpALHbngH32U0aiUJY9dR3roV1
f3yGtU0jd5c1Rqenb1UEKGLSEowKbCJy33EVUB3MCmw6GwY2B3gsWghs9RIaFNMKhdgcAAAAAAAA



--=-85AXFEIuaZsqFgYbkRv6--
