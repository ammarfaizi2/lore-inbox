Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268045AbUIFOWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268045AbUIFOWm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 10:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268060AbUIFOWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 10:22:42 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:16288 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S268045AbUIFOWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 10:22:34 -0400
Subject: Re: [FYI] "kernel BUG at fs/nfs/inode.c:152!"
From: Ian Kumlien <pomac@vapor.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <413C73E1.8050808@sw.ru>
References: <1094478972.3318.397.camel@big>  <413C73E1.8050808@sw.ru>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xmelqU21aQBuyOhsiYID"
Message-Id: <1094480552.3318.400.camel@big>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 06 Sep 2004 16:22:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xmelqU21aQBuyOhsiYID
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-09-06 at 16:27, Kirill Korotaev wrote:
> Hello Ian,
>=20
> This looks very much like the problem in iget() I described today in=20
> LKML. Hope I'll post a patch here soon.

ahhhh, ok, Must have missed it etc, though i only read lkml trough
marc.theaimsgroup.com =3DP

I'm looking forward to seeing a patch included =3D)

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-xmelqU21aQBuyOhsiYID
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBPHKo7F3Euyc51N8RAh+3AJ9FTgcyyc6mif5ByiaZp0dDYLgcgACggQqu
BNuWNq+QI/5G9XpbllgDeOM=
=c+kc
-----END PGP SIGNATURE-----

--=-xmelqU21aQBuyOhsiYID--

