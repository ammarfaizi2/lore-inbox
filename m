Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266298AbTABSZB>; Thu, 2 Jan 2003 13:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266316AbTABSZB>; Thu, 2 Jan 2003 13:25:01 -0500
Received: from c0ns0le.net.ttu.edu ([129.118.3.155]:3715 "EHLO
	c0ns0le.net.ttu.edu") by vger.kernel.org with ESMTP
	id <S266298AbTABSY7>; Thu, 2 Jan 2003 13:24:59 -0500
Subject: Re: vanilla 2.4.20/2.4.21 doesn't boot w/
	http://www.ecs.com.tw/products/pd_spec.asp?product_id=63  (L7VTARAID).
	vt8235 kt400(vt8377) pdc20265
From: NassDeFX <root@micr0s0ftsux.com>
To: Ron cooper <rcooper@jamesconeyisland.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200301021221.15538.rcooper@jamesconeyisland.com>
References: <200301021733.h02HXFwn013814@c0ns0le.net.ttu.edu>
	 <200301021221.15538.rcooper@jamesconeyisland.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-D/ZsTr6P3ejzp5ptMtq5"
Organization: micr0s0ftsux.com
Message-Id: <1041532330.14273.4.camel@c0ns0le.net.ttu.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1- 
Date: 02 Jan 2003 12:32:11 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-D/ZsTr6P3ejzp5ptMtq5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

ron,
	thanks for getting back . i have tried disabling the pdc26065 and that
does seem to fix things, but this doesn't resolve the issues of
pdc20265. if you have any suggestions i'd love to try em. this has been
kicking my butt for the last 2weeks. i've been working w/ several people
on getting a dist.kernel out for gentoo. again thanks

--=20
brandon.grace <root@micr0s0ftsux.com>
micr0s0ftsux.com

On Thu, 2003-01-02 at 12:21, Ron cooper wrote:
> It's probably the promise controller.  Did you try disabling the promise =
in=20
> the bios to see if everything else works correctly?
>=20
>=20
>=20
> On Thursday 02 January 2003 11:33 am, root@micr0s0ftsux.com wrote:
> > recently purchased the following mobo and have been trying multiple
> > combinations of kernels/patches to try and get this working correctly.
> > currently having to use a redhat 2.4.20-2.2.rpm to get the box to boot
> > correctly yet it lacks xfs support. i'm needing to know if anyone has b=
een
> > able to get this combination of devices working correctly. if you need =
more
> > info please reply directly as well as cc.. thanks
> >
> > http://www.ecs.com.tw/products/pd_spec.asp?product_id=3D63
> >
> > vanilla 2.4.20: system will detect the devices and halts after VP_IDE i=
de1
> > vanilla 2.4.21pre2: system will detect the devices and halts with
> > dma_proxy_timeout:dma_status=3D0x64
> >
> >
> > thanks in advance for any input.
> >
> > brandon


--=-D/ZsTr6P3ejzp5ptMtq5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+FIWqbUcc1uOghn0RAtGMAJ0UOveBaIwdSmTcOCS278uMSa0+DgCgmoYw
OeaEKyyeaEawg9VmtML4Yw8=
=UzuD
-----END PGP SIGNATURE-----

--=-D/ZsTr6P3ejzp5ptMtq5--
