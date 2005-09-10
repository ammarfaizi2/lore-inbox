Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVIJJsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVIJJsG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 05:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbVIJJsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 05:48:06 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:19427 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S1750731AbVIJJsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 05:48:05 -0400
Subject: Re: [ACPI] Re: [PATCH] [2.6.13-mm2] set IBM ThinkPad extras to
	default n in Kconfig
From: Erik Slagter <erik@slagter.name>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, "Brown, Len" <len.brown@intel.com>,
       Andi Kleen <ak@suse.de>, akpm@osdl.org,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050910094259.GA16051@gollum.tnic>
References: <F7DC2337C7631D4386A2DF6E8FB22B30048FA292@hdsmsx401.amr.corp.intel.com>
	 <Pine.LNX.4.61.0509091817220.3743@scrub.home>
	 <20050910094259.GA16051@gollum.tnic>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-YU9GlqSHEzGP9hX2CZHr"
Date: Sat, 10 Sep 2005 11:47:25 +0200
Message-Id: <1126345645.4766.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-1.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YU9GlqSHEzGP9hX2CZHr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-09-10 at 11:42 +0200, Borislav Petkov wrote:
> On Fri, Sep 09, 2005 at 06:25:00PM +0200, Roman Zippel wrote:
> =20
> > The best would be to avoid using defaults completely, unless the result=
ing=20
> > kernel is non-functional (e.g. it doesn't compile or boot).
> > So far it's still the responsibility of the user to explicitly turn=20
> > everything on he needs (at least until we have a functional autoconfig)=
.
> > BTW distros are not the only users, from them I would expect how to=20
> > configure a kernel.
>=20
> Actually, this sounds pretty sane and IMHO is somehow the biggest common
> denominator concerning linux users and their kernel configuration
> recreational activities :); but seriously, going all over the menus of Kb=
uild
> and turning everything off is a lot of work compared to turning on the
> several things I need on my system. "default m" is also not a good thing
> since compiling of unnecessary modules is simply dumb for a system
> that's just not going to use them.

Not to mention the bugs you get for free while you don't even (actively)
use the offending module/piece of code.

--=-YU9GlqSHEzGP9hX2CZHr
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGFjCCAs8w
ggI4oAMCAQICAw9TczANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDUwODE4MTE1NDA1WhcNMDYwODE4MTE1NDA1WjBDMR8wHQYDVQQD
ExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSAwHgYJKoZIhvcNAQkBFhFlcmlrQHNsYWd0ZXIubmFt
ZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANAMKW15OgreNb+Wd++Xcw6uNJUXXIfX
56u1rtTObMmbbDY2wNc4Iqwbuwaysvox3z+YElXBibE8BAyV1iMjhee4mOfAy38dGHtWDxhOGke8
VpkyY8DSWgMN5p4egTiT6YNdHW75iiQ+Vh5zMHju1UXnIqgf5zkUGkNuxYp15jLZvRDbfA5H+Sil
jbZGB2fiPOJHpyI61ZidcMgdow31qm70/oe6vXxhSZLzo7OLvExE+mQHwbCSIJMN/hPTK1z0lmQ1
kkaEjHrefqIgoF9Dk/WfOtulzvR3xBzDL50GZ32BxT/OhXYe1SHEJpSM1S/aq8TBQJYwjzREWyDh
0OYsmr0CAwEAAaMuMCwwHAYDVR0RBBUwE4ERZXJpa0BzbGFndGVyLm5hbWUwDAYDVR0TAQH/BAIw
ADANBgkqhkiG9w0BAQQFAAOBgQCCpzoneRQIKsUO8zSnwQ7yhJTrS/EaDibiIVrkkCbzXwCiHFAi
7nmTRF0DlLVF3Ssf97ITWT/RSdkj9Xke0OHH7724PJdfpA6OglMnx2i7IcJLzPgPjB+fOmfR0nYX
UYKuzGxTOXmshLmPcwKdpFuRLLk7n+vrTAwJYJI++crhJzCCAz8wggKooAMCAQICAQ0wDQYJKoZI
hvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcT
CUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmlj
YXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFp
bCBDQTErMCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3
MTcwMDAwMDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUg
Q29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwg
SXNzdWluZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRw
nd/p/6Me7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+R
NiQqE88r1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEA
AaOBlDCBkTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwu
dGhhd3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNV
HREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQADgYEA
SIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6E
sZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpbNU1341YheILc
IRk13iSx0x1G/11fZU8xggHvMIIB6wIBATBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3
dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1h
aWwgSXNzdWluZyBDQQIDD1NzMAkGBSsOAwIaBQCgXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0wNTA5MTAwOTQ3MjVaMCMGCSqGSIb3DQEJBDEWBBS6C3DgAm9+QIV9
z1Uyi219Equ4BTANBgkqhkiG9w0BAQEFAASCAQBWF5Zj1IwZ8Cs+KQd3BL+yv2m9QOGZ2HQoiiI3
OlP0H44DExPxzVeBKRg72ceQP8Ld3qQQWnGCPKLPvmaF2mmjYYXyS5cVoe8j1+jcCSTnD8xtl9zk
pAhd/O/xuNIm80HK69WC24j7ffabR0co1dkVjI7+tgGTTRy6IMQvf8rsV9/7umLG2gw7s3/+6xnM
1y379/nDvr5sIg3SWdyUGNRvbqt2b0HOErzYgww/v+rcfmDP8emmcRi2yf84CJwFhZmLNwx0IDFh
MaR4A/9XNSBLU1z8QxXLM1rUhamjUakXpKh/rNtHbq3nRPn8CJwzBJnTl8KydYwhuBrnYPR7FBeW
AAAAAAAA


--=-YU9GlqSHEzGP9hX2CZHr--
