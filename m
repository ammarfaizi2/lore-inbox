Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268445AbTCCQjs>; Mon, 3 Mar 2003 11:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268458AbTCCQjs>; Mon, 3 Mar 2003 11:39:48 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:521 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S268445AbTCCQjp>;
	Mon, 3 Mar 2003 11:39:45 -0500
Date: Mon, 3 Mar 2003 17:50:11 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Modules broken on alpha ?
Message-ID: <20030303165011.GE27794@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <wrp1y1p8srx.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vmttodhTwj0NAgWp"
Content-Disposition: inline
In-Reply-To: <wrp1y1p8srx.fsf@hina.wild-wind.fr.eu.org>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vmttodhTwj0NAgWp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-03-02 20:36:50 +0100, Marc Zyngier <mzyngier@freesurf.fr>
wrote in message <wrp1y1p8srx.fsf@hina.wild-wind.fr.eu.org>:
> Richard, Rusty,
>=20
> I've been trying to use modules on alpha without much success (at
> least on the latest 2.5.63-bk). Any non-trivial module fails to load
> with a relocation error :

> I'm using module-init-tools from Debian sid (0.9.10-1).

IIRC there was recently a quite small patch flyin' around on LKML.
<digging...> Ah, look for "[PATCH] alpha modutils update" as a
subject:-) That was ment to fix it.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--vmttodhTwj0NAgWp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD4DBQE+Y4fDHb1edYOZ4bsRAjLJAJ0QV6vx6qIrcEeIjjbI0qe7BYX9nwCY2ccL
+3opWlwWC2JQuVyyAa+9ZA==
=Ufrd
-----END PGP SIGNATURE-----

--vmttodhTwj0NAgWp--
