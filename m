Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270190AbTGMJ0L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 05:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270192AbTGMJ0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 05:26:11 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:43278 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S270190AbTGMJ0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 05:26:09 -0400
Date: Sun, 13 Jul 2003 11:40:54 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Forking shell bombs
Message-ID: <20030713094053.GC14349@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3F0C2FCB.8060304@blue-labs.org> <BKEGKPICNAKILKJKMHCAOELCENAA.Riley@Williams.Name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline
In-Reply-To: <BKEGKPICNAKILKJKMHCAOELCENAA.Riley@Williams.Name>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-07-13 10:10:22 +0100, Riley Williams <Riley@Williams.Name>
wrote in message <BKEGKPICNAKILKJKMHCAOELCENAA.Riley@Williams.Name>:
> Hi all.
>=20
> It sounds like what is required is some way of basically saying
> "Don't permit new processes to be created if CPU usage > 75%"
> (where the 75% is configurable but less than 100%).

That won't allow a load > 0.75 .  Bad idea.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/ESklHb1edYOZ4bsRAuwrAJwMQ9HOnA6aOuIFKiq7YjHtKCkxywCaAkVT
l7FP1bY9tl4l7T3X1h9cKyY=
=0HPS
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--
