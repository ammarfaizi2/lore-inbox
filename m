Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264652AbUFSUHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264652AbUFSUHA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 16:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbUFSUFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 16:05:51 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:53123 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S264627AbUFSUFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 16:05:33 -0400
Date: Sat, 19 Jun 2004 22:05:32 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/11] New set of input patches
Message-ID: <20040619200532.GB20632@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040618203340.45436.qmail@web81301.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bzibOeouBB0RgR3s"
Content-Disposition: inline
In-Reply-To: <20040618203340.45436.qmail@web81301.mail.yahoo.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bzibOeouBB0RgR3s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-06-18 13:33:40 -0700, Dmitry Torokhov <dtor_core@ameritech.net>
wrote in message <20040618203340.45436.qmail@web81301.mail.yahoo.com>:
> > However, they won't apply onto Linus' tree and cause rejects in a good
> > number of "interesting" files.
>=20
> Well, I do not consider it tested enough to be ready for Linus yet :)
> I am thinking about publushing my input-sysfs bk tree... Will there
> be an interest in it or you just want a patch against the vanilla 2.6.7?
> I can do a wholesale patch but splitting my changes from other stuff in
> Vojtech's tree does not sound very appealing...=20

As I said, I'd love to see a -linus based patch, simply because I
basically work with exactly this as my base. However, I can also try to
get another base to start from.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--bzibOeouBB0RgR3s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA1JyLHb1edYOZ4bsRAsmoAJ9o4O8OoMQOtz3uEsah8RYY+QtjRwCfcfH6
dc9NK3Sa3yJpUFsQUkGaXNE=
=qBy4
-----END PGP SIGNATURE-----

--bzibOeouBB0RgR3s--
