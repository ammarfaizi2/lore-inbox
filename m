Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267647AbTGLQQF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 12:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266205AbTGLQPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 12:15:24 -0400
Received: from maild.telia.com ([194.22.190.101]:25827 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id S267647AbTGLQOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 12:14:17 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] SCHED_ISO for interactivity
From: Christian Axelsson <smiler@lanil.mine.nu>
Reply-To: smiler@lanil.mine.nu
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, phillips@arcor.de
In-Reply-To: <200307130139.45477.kernel@kolivas.org>
References: <200307112053.55880.kernel@kolivas.org>
	 <1057966657.4326.6.camel@sm-wks1.lan.irkk.nu>
	 <200307121013.14347.kernel@kolivas.org>
	 <200307130139.45477.kernel@kolivas.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ayPAze00ldgbKpHXU29c"
Organization: LANIL
Message-Id: <1058027317.4363.8.camel@sm-wks1.lan.irkk.nu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 12 Jul 2003 18:28:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ayPAze00ldgbKpHXU29c
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-07-12 at 17:39, Con Kolivas wrote:
> On Sat, 12 Jul 2003 10:13, Con Kolivas wrote:
> > On Sat, 12 Jul 2003 09:37, Christian Axelsson wrote:
> > > On Fri, 2003-07-11 at 16:30, Con Kolivas wrote:
> > > > On Fri, 11 Jul 2003 22:48, Christian Axelsson wrote:
> snip snip snip
>=20
> Mike G suggested expiring tasks which use up too much cpu
> time like in Davide's softrr patch which is a much better=20
> solution to the forever reinserted into the active array concern.
>=20
> patch-SI-0307130021 is also available at=20
> http://kernel.kolivas.org/2.5

Problem seems to be gone (cant be 100% sure as I aint really sure WHAT
trigged this behavior).

--=20
Christian Axelsson
smiler@lanil.mine.nu

--=-ayPAze00ldgbKpHXU29c
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/EDc1yqbmAWw8VdkRAlo9AJ9tT3StIKv2+/FAu/Z/wqA/KHNCSQCgqxk8
AC0Q8FH9VTh7l7f2+pDhVo8=
=4og4
-----END PGP SIGNATURE-----

--=-ayPAze00ldgbKpHXU29c--

