Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268683AbUHTT1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268683AbUHTT1J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 15:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268688AbUHTT0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 15:26:00 -0400
Received: from ctb-mesg1.saix.net ([196.25.240.73]:21178 "EHLO
	ctb-mesg1.saix.net") by vger.kernel.org with ESMTP id S268681AbUHTTZa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 15:25:30 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       kernel@wildsau.enemy.org, fsteiner-mail@bio.ifi.lmu.de,
       diablod3@gmail.com, B.Zolnierkiewicz@elka.pw.edu.pl
In-Reply-To: <4125FFA2.nail8LD61HFT4@burner>
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
	 <4124BA10.6060602@bio.ifi.lmu.de>
	 <1092925942.28353.5.camel@localhost.localdomain>
	 <200408191800.56581.bzolnier@elka.pw.edu.pl>
	 <4124D042.nail85A1E3BQ6@burner>
	 <1092938348.28370.19.camel@localhost.localdomain>
	 <4125FFA2.nail8LD61HFT4@burner>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-z1ToBhg6HWg0nqhYPXBW"
Message-Id: <1093030136.8998.72.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 21:28:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-z1ToBhg6HWg0nqhYPXBW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-08-20 at 15:41, Joerg Schilling wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>=20
> > On Iau, 2004-08-19 at 17:07, Joerg Schilling wrote:
> > > Cdrtools is is code freeze state. This is why I say the best idea is =
to remove=20
> > > this interface change from the current Linux kernel and wait until th=
ere will
> > > be new cdrtools alpha for 2.02 releases. These alpha could get suppor=
t for uid
> > > switching. If Linux then would again switch the changes on, it makes =
sense.
> >
> > While Sun did spend a year refusing to fix security holes I found -  fo=
r
> > "compatibility reasons" - long ago back when I was a sysadmin at NTL,
> > the Linux world does not work that way.
>=20
> Unless you tell us what kind of "security holes" you found _and_ when thi=
s has=20
> been, it looks like a meaningless remark.
>=20

But this is the same kind of remarks you make - statements without
proof (the ones you also did not explain, and explicitly refuse to
explain or give a pointer to) - so I assume we should also consider
them as meaningless ?


--=20
Martin Schlemmer

--=-z1ToBhg6HWg0nqhYPXBW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBJlD4qburzKaJYLYRAoysAJ9+g5I2Piq2PrIDKpm9G6qk7ioZMQCdGx05
j7944444Chk8BazMIZk3J7c=
=JcZ9
-----END PGP SIGNATURE-----

--=-z1ToBhg6HWg0nqhYPXBW--

