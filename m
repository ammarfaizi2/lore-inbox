Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262781AbVFVK0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbVFVK0o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 06:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbVFVKTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 06:19:33 -0400
Received: from [213.69.232.60] ([213.69.232.60]:36882 "HELO ei.schottelius.org")
	by vger.kernel.org with SMTP id S262755AbVFVKQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 06:16:12 -0400
Date: Wed, 22 Jun 2005 12:17:07 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Subject: UML problems / kernel panic
Message-ID: <20050622101707.GP2779@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aC33ObtQAkNdOZ6b"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.11.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aC33ObtQAkNdOZ6b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

Sometimes when I "boot" 2.6.11.11/um, I get the following error:

--------------------------------------------------------------
VFS: Mounted root (jfs filesystem) readonly.
cinit-0.1 booting...
Kernel panic - not syncing: write of switch_pipe failed, err =3D 9

EIP: 0073:[<a03858b2>] CPU: 0 Not tainted ESP: 007b:a0c676b4 EFLAGS: 000002=
86
    Not tainted
EAX: 00000000 EBX: 00000001 ECX: a0c67754 EDX: a0c676d4
ESI: 00000008 EDI: 0000000a EBP: a0c676bc DS: 007b ES: 007b
Call Trace:
a0c6fa30:  [<a004df6d>]
a0c6fa40:  [<a023c7f6>]
a0c6fa50:  [<a003b8c1>]
a0c6fa64:  [<a001b430>]
a0c6fa70:  [<a002156e>]
a0c6fab0:  [<a03c8d45>]
a0c6fb00:  [<a0055e3a>]
a0c6fb20:  [<a0051d95>]
a0c6fb30:  [<a001d74f>]
a0c6fb40:  [<a0371b40>]
a0c6fb7c:  [<a0038700>]
a0c6fb9c:  [<a0038700>]
a0c6fbc8:  [<a0051ae0>]
a0c6fbd0:  [<a0055bb5>]
a0c6fc04:  [<a0055af0>]
a0c6fc10:  [<a001aab8>]
a0c6fc1c:  [<a0385984>]
a0c6fc28:  [<a0055af0>]
a0c6fc38:  [<a001aa80>]
a0c6fcd4:  [<a0055af0>]
a0c6fce0:  [<a00217db>]
a0c6fce4:  [<a0055af0>]
a0c6fd20:  [<a0385858>]
a0c6fd60:  [<a03858b2>]

 sleeping process 8915 got unexpected signal : 11

--------------------------------------------------------------

I don't know why this happens, as it is not always happening.

Nico

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--aC33ObtQAkNdOZ6b
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQIVAwUBQrk6orOTBMvCUbrlAQIl0RAAoj3KV3GS7ZNzuC5viS4j+lR3QDI+gl9T
IREYNBNpSGjkgo7mehf1KBvJvhv2P1DYQsTq/arlDcnIoA0naXkC3zBEtm99ZuAP
PaDDO2CUSI4/n+m2JFlLw1jlqQ+FTtc2yjDyo33xoWeKOLVSZjPFC2CYzWYDkcLd
mN1OHkNU/latt3yBdmrJP4q66CvmwIrxI/G3/CZ3es+FmIvO3N+4O8RR5MbHXziT
CsBPllI8w691ST3KtqLaWEIF/eP7Yvnm+V46vSSRF4sGIR+zT02e0GW8aIsUVWro
MjaO3Pcp7KIUh86wT2oBcSkGjqasNoIIowXiUdnrAz7orCJOmqDFwYaYITg86Ll4
lQezF28GSsacoEH33iiyjYIAirH6kqxCDFsuAUnpxlztzozYNxbgEzVfY0THylzu
4v32co9qk3yt2LJ72xNECNqQCnhe4NOjI6cOm4zwYxt8MCObf5M4Nw7r9dW1Ji3W
LP4z7pZbMrWDATknYtgKLPM+M4DdwMOKs5oZB/h1dsrTfPJwx+kq1ZIf2nYGEKJJ
Z7edD5C3D7pLtF5CBKO+QoF3vHQN+vCMYkGdz28EjDnTiYca/YqkeUaAlGrpi2d1
YYK06BmPhamqvYnlRYPRPk408KFk3HVAdbfdha08usgO46gDmtrsAGxeui2a8Uvi
83fnQt/GmYE=
=3zz8
-----END PGP SIGNATURE-----

--aC33ObtQAkNdOZ6b--
