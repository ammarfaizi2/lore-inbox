Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262453AbSI2MHD>; Sun, 29 Sep 2002 08:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262454AbSI2MHD>; Sun, 29 Sep 2002 08:07:03 -0400
Received: from bg77.anu.edu.au ([150.203.223.77]:62356 "EHLO lassus.himi.org")
	by vger.kernel.org with ESMTP id <S262453AbSI2MHB>;
	Sun, 29 Sep 2002 08:07:01 -0400
Date: Sun, 29 Sep 2002 22:12:22 +1000
To: linux-kernel@vger.kernel.org
Subject: Re: System very unstable
Message-ID: <20020929121222.GB15961@himi.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200209281155.32668.felix.seeger@gmx.de> <20020928.025900.58828001.davem@redhat.com> <200209281233.21897.felix.seeger@gmx.de> <20020928.033510.40857147.davem@redhat.com> <3D958EF5.7080300@metaparadigm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
In-Reply-To: <3D958EF5.7080300@metaparadigm.com>
User-Agent: Mutt/1.3.28i
From: simon@himi.org (Simon Fowler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 28, 2002 at 07:13:57PM +0800, Michael Clark wrote:
> On 09/28/02 18:35, David S. Miller wrote:
> >   From: Felix Seeger <felix.seeger@gmx.de>
> >   Date: Sat, 28 Sep 2002 12:33:21 +0200
> >  =20
> >   What card is good (performance for games and=20
> >   a acceptable licenze for kernel developers)?
> >
> >ATI Radeon is pretty fast and all except the very latest chips have
> >opensource drivers.
>=20
> Radeon 7500 is currently the fastest board with an opensource
> driver that supports 3D. 8500 XFree support is currently 2D only,
> although apparently work on the opensource GL driver is underway.
>=20
> You can get 3D support for the 8500 if you get a commercial
> binary only X server ( http://www.xig.com/ ) - although I
> guess this is almost as bad as having a binary kernel module
> due to the type of hardware access the X server needs to do.
>=20
There's also 3D support for the r200 chip (that drives the 8500) in
the DRI cvs tree (see http://dri.sf.net): I haven't tried it, since
I don't have an 8500, but it's there, and under active development,
and seem to work fairly well.

Simon

--=20
PGP public key Id 0x144A991C, or http://himi.org/stuff/himi.asc
(crappy) Homepage: http://himi.org
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://himi.org/pub/mirrors/css/=20

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9lu4lQPlfmRRKmRwRAjbkAKCSpKLg2fjOwRb5NMpa3E8OrLdwlwCfaZHw
0KmKDoaIc4GrWYv5BUY0jYA=
=Pu4c
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
