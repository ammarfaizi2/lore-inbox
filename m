Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbUKFPK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbUKFPK1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 10:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbUKFPK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 10:10:27 -0500
Received: from [68.144.35.155] ([68.144.35.155]:34216 "HELO
	tantra.cosmic-cow.net") by vger.kernel.org with SMTP
	id S261202AbUKFPKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 10:10:19 -0500
Subject: Lost versioning from last build -- How to recover?
From: Chad Christopher Giffin <typo@shaw.ca>
Reply-To: typo@shaw.ca
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IOyVyzw3yH4oeUa3BeNh"
Organization: T-Net Information System
Date: Sat, 06 Nov 2004 08:10:38 -0700
Message-Id: <1099753839.21664.5.camel@tantra.cosmic-cow.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IOyVyzw3yH4oeUa3BeNh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Could someone explain to me, please, what I need to do?

An accidental build in the kernel source tree has changed my struct
modules version # and I need to restore it to match the currently
running system.

Rebuilding the kernel and restarting the system is an option but I
prefer not to restart the machine.

uname -a output:=20
Linux tantra 2.6.10-rc1-bk12 #8 Thu Nov 4 08:27:45 MST 2004 i686
Intel(R) Celeron(R) CPU 1.80GHz GenuineIntel GNU/Linux

# strings ax25.ko | grep srcversion
srcversion=3D4AA459CA4F655956DE1DFC3

Thanks in advance for any help you can provide.


--=20
Chad Christopher Giffin
mailto:typo@shaw.ca

-
There are 10 kinds of people in this world, those who understand binary
and those who do not.
                         -- Anonymous

--=-IOyVyzw3yH4oeUa3BeNh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBjOluYyoIa/Kpy+cRAoJ8AKD1fEwIVW6WMjrxhZjSu+bL466CBQCgjw6c
MGChyuoMasPiNRdfn8atFcQ=
=uWHO
-----END PGP SIGNATURE-----

--=-IOyVyzw3yH4oeUa3BeNh--
