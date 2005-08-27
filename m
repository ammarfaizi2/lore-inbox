Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbVH0VoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbVH0VoO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 17:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVH0VoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 17:44:14 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:65190 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1750804AbVH0VoN (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 17:44:13 -0400
Subject: [OOPS] ANSI/IEEE 802.2 LLC type 2 Support
From: Ian Kumlien <pomac@vapor.com>
Reply-To: pomac@vapor.com
To: Linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6/d67Zlo8WApmzGerlqi"
Date: Sat, 27 Aug 2005 23:45:12 +0200
Message-Id: <1125179112.24161.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6/d67Zlo8WApmzGerlqi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,=20

Today my firewall just up and oopsed after about a month of uptime.

It has to be something new that was introduced to my lan or so since
it's the local interface that oopsed... I generally don't care about
this part but i thought that it might be good to inform you guys.

The option mentioned in the subject is the only thing my other boxes
don't have (ie all other boxes has just about the same kernel config)
and judging from the Call trace i assumed it was that.

The oops message was captured using a digital camera (and yes that
monitor is dirty =3D))
http://pomac.netswarm.net/misc/kernel-panic.jpg

PS. I could recreate the oops severaltimes until i put eth1 down, but i
haven't been able to since then (switched to rc7 without the LLC
option).
DS.
--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-6/d67Zlo8WApmzGerlqi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iD8DBQBDEN7o7F3Euyc51N8RAjSAAJ4+0/i39KP2pM1m60nbBs8dbi4s8wCgocc8
xpWJN2hDEDKI9JTrNWKyPBM=
=N94M
-----END PGP SIGNATURE-----

--=-6/d67Zlo8WApmzGerlqi--

