Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbVH3Oas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVH3Oas (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 10:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVH3Oas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 10:30:48 -0400
Received: from ms-smtp-04-smtplb.tampabay.rr.com ([65.32.5.134]:61937 "EHLO
	ms-smtp-04.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S932155AbVH3Oar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 10:30:47 -0400
Subject: Re: Linux-2.6.13 : __check_region is deprecated
From: David Hollis <dhollis@davehollis.com>
To: Diego Calleja <diegocg@gmail.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, stephane.wirtel@belgacom.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050830015513.62ee2c0c.diegocg@gmail.com>
References: <20050829231417.GB2736@localhost.localdomain>
	 <20050830012813.7737f6f6.diegocg@gmail.com>
	 <9a8748490508291634416a18bc@mail.gmail.com>
	 <20050830015513.62ee2c0c.diegocg@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XcxZeWjr725S5q2FrR6H"
Date: Tue, 30 Aug 2005 10:28:37 -0400
Message-Id: <1125412117.4801.18.camel@dhollis-lnx.sunera.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 (2.3.7-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XcxZeWjr725S5q2FrR6H
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-08-30 at 01:55 +0200, Diego Calleja wrote:
> El Tue, 30 Aug 2005 01:34:25 +0200,
> Jesper Juhl <jesper.juhl@gmail.com> escribi=C3=B3:
>=20
> > I don't see why we should break a bunch of drivers by doing that.
> > Much better, in my oppinion, to fix the few remaining drivers still
> > using check_region and *then* kill it. Even unmaintained drivers may
>=20
> I'd usually agree with you, but check_region has been deprecated for so m=
any
> time; I was just wondering myself if people will bother to fix the remain=
ing
> drivers without some "incentive"=20

Shouldn't it be (or have been) added to the
Documentation/feature-removal-schedule.txt then so it could be
deprecated and removed through the proper mechanisms.

--=20
David Hollis <dhollis@davehollis.com>

--=-XcxZeWjr725S5q2FrR6H
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDFG0VxasLqOyGHncRAsGUAJkBmBSIXtJRrndHgCCsqO+8AHB0EgCePmq9
oExsuqK3+mihXI6e2PmwR+I=
=a+hv
-----END PGP SIGNATURE-----

--=-XcxZeWjr725S5q2FrR6H--

