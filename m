Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264286AbUGYTP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUGYTP6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 15:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbUGYTP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 15:15:58 -0400
Received: from irulan.endorphin.org ([212.13.208.107]:61189 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S264286AbUGYTP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 15:15:56 -0400
Subject: Re: [PATCH] Delete cryptoloop
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jari Ruusu <jariruusu@users.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1090782572.14951.47.camel@mindpipe>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>
	<1090672906.8587.66.camel@ghanima>
	<41039CAC.965AB0AA@users.sourceforge.net>
	<1090761870.10988.71.camel@ghanima>
	<4103ED18.FF2BC217@users.sourceforge.net>
	<1090778567.10988.375.camel@ghanima>
	<1090782572.14951.47.camel@mindpipe>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-f0xWXtBQ+abV/X635ByR"
Message-Id: <1090782953.10988.433.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 25 Jul 2004 21:15:53 +0200
From: Fruhwirth Clemens <clemens-dated-1091646955.2125@endorphin.org>
X-Delivery-Agent: TMDA/0.92 (Kauai King)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-f0xWXtBQ+abV/X635ByR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-07-25 at 21:09, Lee Revell wrote:
> On Sun, 2004-07-25 at 14:02, Fruhwirth Clemens wrote:
> > On Sun, 2004-07-25 at 19:25, Jari Ruusu wrote:
> > > > Where is the exploit?
> > >=20
> > > wget -O cryptoloop-exploit.tar.bz2 "http://marc.theaimsgroup.com/?l=
=3Dlinux-kernel&m=3D107719798631935&q=3Dp3"
> >=20
> > That's no exploit. Where is the exploit?
> > http://www.google.com/search?q=3Djargon%20exploit
> > When you're there, you can look up the term ``backdoor'' as well.=20
> >=20
>=20
> I am confused.  Are you suggesting it's not an exploit because it
> doesn't work remotely?  That would make it a local exploit.

I'm suggesting it doesn't work at all. The worst security problems have
been discussed in my first posting already:
http://lkml.org/lkml/2004/7/24/51

I vote for a change in the on-disk format, but not because of one of the
reasons, Jari has put forward.

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-f0xWXtBQ+abV/X635ByR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBBAbpW7sr9DEJLk4RAkqYAJ9lplBXNGPx0dHtFsbW7tPtL1jHJQCfeHht
GS+QBIU9VqCXgyqN0gWsQ/Q=
=W0R9
-----END PGP SIGNATURE-----

--=-f0xWXtBQ+abV/X635ByR--
