Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268553AbTCAOx3>; Sat, 1 Mar 2003 09:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268559AbTCAOx3>; Sat, 1 Mar 2003 09:53:29 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:7442 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S268553AbTCAOx1>;
	Sat, 1 Mar 2003 09:53:27 -0500
Date: Sat, 1 Mar 2003 16:03:50 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: syslog full of kernel BUGS, frequent intermittent instability
Message-ID: <20030301150350.GA27794@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030301082126.56c00418.coyote1@cytanet.com.cy> <200303011455.h21EtwhU000402@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <200303011455.h21EtwhU000402@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-03-01 14:55:58 +0000, John Bradford <john@grabjohn.com>
wrote in message <200303011455.h21EtwhU000402@81-2-122-30.bradfords.org.uk>:
> > It's the mandrake default AFAIK.  I don't know what all that stuff is,=
=20
> > so I don't mess with it.  My installation does "feel" bloated (very
> > unscientific opinion): it "feels" much less responsive in the GUI
>=20
> /dev/hda2	/	ext3	defaults		1  1
>=20
> which you can change to
>=20
> /dev/hda2	/	ext3	defaults, noatime	1  1
                          you loose -----^

> This is a bit off-topic, but in my experience is about the best way to
> increase performance on old, (and not so old), hardware, apart from
> compiling a custom kernel.  Without noatime, every time you read a
> file, the current date and time is written to the disk.  With noatime,
> it's only recorded for a write.  Almost no programs use the access
> time data.

Except some email clients...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+YMvWHb1edYOZ4bsRAkBfAJ0UPFXX5ITbn7zMEW9phyfdczzP1ACfUO4s
ZyKSsyFru6Ri1dgQHfVs4C4=
=40nt
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
