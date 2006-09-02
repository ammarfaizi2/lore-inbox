Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWIBB1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWIBB1f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 21:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWIBB1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 21:27:35 -0400
Received: from hentges.net ([81.169.178.128]:12764 "EHLO
	h6563.serverkompetenz.net") by vger.kernel.org with ESMTP
	id S1750731AbWIBB1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 21:27:34 -0400
Subject: Re: sky2 hangs on me again: This time 200 kb/s IPv4 traffic, not
	easily reproducable
From: Matthias Hentges <oe@hentges.net>
To: shogunx <shogunx@sleekfreak.ath.cx>
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       Stephen Hemminger <shemminger@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0609012057230.8350-100000@sleekfreak.ath.cx>
References: <Pine.LNX.4.44.0609012057230.8350-100000@sleekfreak.ath.cx>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pWwTHEuLo1lbNF/+kuSe"
Date: Sat, 02 Sep 2006 03:28:25 +0200
Message-Id: <1157160505.20509.12.camel@mhcln03>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pWwTHEuLo1lbNF/+kuSe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Freitag, den 01.09.2006, 20:57 -0400 schrieb shogunx:
> On Sat, 2 Sep 2006, Matthias Hentges wrote:
>=20
> > Am Freitag, den 01.09.2006, 20:41 +0200 schrieb Thomas Glanzmann:
> > > Hello,
> > > my sky2 network card in my intel mac mini just stopped working again =
on
> > > me. After a reboot it worked again. This time there is no dmesg outpu=
t
> > > related to the problem. :-( Am I the only one who sees that?
> >
> > Nope, same here on an Asus P5W DH Deluxe mainboard. The sky2 NIC just
> > silently dies after some time. Rmmod + modprobe sky2 used to re-enable
> > the NIC IIRC. Since this bug makes the driver practically unusable I
> > have since switched to a PCI NIC (which is a shame considering the 2
> > gigabit sky2 NICs on the mainboard...).
>=20
> Has this not been fixed in the 2.6.18 git?

Good question. I'll try 2.6.18-rc4-mm3 and report back.
--=20
Matthias 'CoreDump' Hentges=20

Webmaster of hentges.net and OpenZaurus developer.
You can reach me in #openzaurus on Freenode.

My OS: Debian SID. Geek by Nature, Linux by Choice

--=-pWwTHEuLo1lbNF/+kuSe
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBE+N45Aq2P5eLUP5IRAgoOAKDOT4V+yaYh1Z9vZMquw8tVrXO4dgCfS8Kn
2pIRNaUTteFsZm9QUMni3pQ=
=uCre
-----END PGP SIGNATURE-----

--=-pWwTHEuLo1lbNF/+kuSe--


-- 
VGER BF report: H 0
