Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279783AbRKIJqq>; Fri, 9 Nov 2001 04:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279787AbRKIJqh>; Fri, 9 Nov 2001 04:46:37 -0500
Received: from f05s15.cac.psu.edu ([128.118.141.58]:53732 "EHLO
	f05n15.cac.psu.edu") by vger.kernel.org with ESMTP
	id <S279785AbRKIJqd>; Fri, 9 Nov 2001 04:46:33 -0500
Subject: bonding driver - linux kernel
From: Phil Sorber <aafes@psu.edu>
To: tadavis@lbl.gov
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        tkeiser@psu.edu
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-WJfM/OW4Coz+VfTrBudt"
X-Mailer: Evolution/0.16 (Preview Release)
Date: 09 Nov 2001 04:46:31 -0500
Message-Id: <1005299191.5985.32.camel@praetorian>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WJfM/OW4Coz+VfTrBudt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

hello,

i have an HP Procurve 4000M and a linux box with an Intel Pro/100 Dual
Port Server Adapter (eepro.c). we have the switch set to do cicso
etherchannel, which the procurve supports. but it seems not to work in
this mode. we have to back down to trunking mode, giving us 200Mbit
upstream, but only 100Mbit down stream.

I was curious if it had been tested with any HP switches, or any non
cisco switches for that matter that support cisco etherchannel. i was
also wondering if this is not the case if anyone has written a patch, or
is planning to write one to correct this.

if not, me and my colleague and i are willing to take a crack at it.
however we have limited experience at something like this, but are eager
to get into it.

any help or direction is apreciated. thanx.

--=20
Phil Sorber
AIM: PSUdaemon
IRC: irc.openprojects.net #psulug PSUdaemon
GnuPG: keyserver - pgp.mit.edu

--=-WJfM/OW4Coz+VfTrBudt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA766X3Xm6Gwek+iaQRAj+sAJ4iurYbpQYCLeoqK77cQbn8Qu0jSQCghzVg
IoXN1aAupfPl0aw409RgJS8=
=TwOc
-----END PGP SIGNATURE-----

--=-WJfM/OW4Coz+VfTrBudt--

