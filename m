Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267530AbTBQVTX>; Mon, 17 Feb 2003 16:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267536AbTBQVTX>; Mon, 17 Feb 2003 16:19:23 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:34316 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S267530AbTBQVTW>;
	Mon, 17 Feb 2003 16:19:22 -0500
Date: Mon, 17 Feb 2003 22:29:22 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.61 (Yes, there are still Alpha users out there. :-) )
Message-ID: <20030217212922.GD351@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <001501c2d677$4d5ce0e0$020b10ac@pitzeier.priv.at> <Pine.GSO.4.51.0302171039160.13696@mail2.sas.upenn.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kncZREqT6Wt3NQEl"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.51.0302171039160.13696@mail2.sas.upenn.edu>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kncZREqT6Wt3NQEl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-02-17 10:39:38 -0500, Fred K Ollinger <follinge@sas.upenn.edu>
wrote in message <Pine.GSO.4.51.0302171039160.13696@mail2.sas.upenn.edu>:
> > There were also some problems with make modules_install for me!
>=20
> How did you handle it?

I had nothing to handle - everything went out of the box.

> What version of modutils was installed?

For recent 2.5.x kernels, you don't any longer need modutils. There was
a major rewrite of all module related code which requires new tools.
These are called "module-init-tools", my distribution has got a package
for it (with the same name). If you cannot get that brand new software
from your distributor, look at
ftp://ftp.kernel.org/pub/linux/kernel/people/people/rusty/modules/ .

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet!
   Shell Script APT-Proxy: http://lug-owl.de/~jbglaw/software/ap2/

--kncZREqT6Wt3NQEl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+UVQxHb1edYOZ4bsRAj6nAJ4yck9ZzT35H8i/Cv2BT+mWAUd/zgCfa4MC
daqcXvlFGJush32TETO7I6c=
=r5Vj
-----END PGP SIGNATURE-----

--kncZREqT6Wt3NQEl--
