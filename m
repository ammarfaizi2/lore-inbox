Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263614AbUFSA0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbUFSA0Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 20:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbUFSAXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 20:23:21 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:43226 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263770AbUFRUwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:52:37 -0400
Date: Fri, 18 Jun 2004 22:52:36 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/11] New set of input patches
Message-ID: <20040618205236.GO20632@lug-owl.de>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org
References: <20040618203340.45436.qmail@web81301.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vLVdERQ9AA/9cwMm"
Content-Disposition: inline
In-Reply-To: <20040618203340.45436.qmail@web81301.mail.yahoo.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vLVdERQ9AA/9cwMm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-06-18 13:33:40 -0700, Dmitry Torokhov <dtor_core@ameritech.net>
wrote in message <20040618203340.45436.qmail@web81301.mail.yahoo.com>:
> > > The patches are against Vojtech's tree and should apply to -mm as wel=
l.
> > However, they won't apply onto Linus' tree and cause rejects in a good
> > number of "interesting" files.
>=20
> I am thinking about publushing my input-sysfs bk tree... Will there
> be an interest in it or you just want a patch against the vanilla 2.6.7?

I'd (personally) prefer a patch to Linus' tree, but really a patch. I
don't use bk (various reasons, don't flame, asbestos already prepared).

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--vLVdERQ9AA/9cwMm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA01YUHb1edYOZ4bsRAkGXAJ0QXj7RhRgFGi6BboiTyqI9Gx0gbwCfRUMp
8NFb2X9KrxYgDjvSFCZ5tIs=
=h5el
-----END PGP SIGNATURE-----

--vLVdERQ9AA/9cwMm--
