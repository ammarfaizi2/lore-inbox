Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265691AbUFSNbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbUFSNbs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 09:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265722AbUFSNbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 09:31:48 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:52380 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S265691AbUFSNbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 09:31:45 -0400
Subject: Re: [sundance] Known problems?
From: Ian Kumlien <pomac@vapor.com>
To: Andre Tomt <andre@tomt.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40D43E26.7060207@tomt.net>
References: <1087650302.2971.44.camel@big>  <40D43E26.7060207@tomt.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-I8WaAEqcb0TtAnJoBr0h"
Message-Id: <1087651887.2971.47.camel@big>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 19 Jun 2004 15:31:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-I8WaAEqcb0TtAnJoBr0h
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-06-19 at 15:22, Andre Tomt wrote:
> Ian Kumlien wrote:
>=20
> > Hi,
> >=20
> > I changed my networking card back to my dlink DFE-580tx (one of those 4
> > port 100mbit cards that uses the alta chipset). And now the watchdog
> > keep killing the connection.
> >=20
> > The max bw that is being used is aprox 5.5 megabyte/s (to avoid
> > confusion). Has there been any work done with this recently or during
> > 2.5/6 development? Afair i had no problems with it in 2.4.x when my
> > firewall used it.
> >=20
> > CC, I'm not subscribed.
>=20
> FYI;
>=20
> Other than beeing a slow card with mmio-bugs, the only problems I have=20
> had with that card was when having a kernel patched with the now defunct=20
> and buggy IMQ. Problems were identical.

Yeah i know about the MMIO bit, but i never had this problem before...
Even when loading it with full 100mbit bw (but that was on 2.4).

Can't it be to paranoid watchdog timings?
(Btw, what is IMO, I'd think it meant 'in my opinion' but, heh =3D))

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-I8WaAEqcb0TtAnJoBr0h
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA1EAv7F3Euyc51N8RAkRSAJ4uc09TLCOhES7atYi1GFXER0s3CACfavGJ
FJl4pxV7N1q9d0n60/tgSi4=
=B5Cb
-----END PGP SIGNATURE-----

--=-I8WaAEqcb0TtAnJoBr0h--

