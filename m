Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161416AbWJKWbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161416AbWJKWbK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 18:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161245AbWJKWbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 18:31:10 -0400
Received: from cattelan-host202.dsl.visi.com ([208.42.117.202]:34556 "EHLO
	slurp.thebarn.com") by vger.kernel.org with ESMTP id S1161416AbWJKWbG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 18:31:06 -0400
Subject: Re: GRIO in Linux XFS?
From: Russell Cattelan <cattelan@thebarn.com>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Phetteplace, Thad (GE Healthcare, consultant)" 
	<Thad.Phetteplace@ge.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
In-Reply-To: <452D5F49.70808@sandeen.net>
References: <CAEAF2308EEED149B26C2C164DFB20F4DDE78B@ALPMLVEM06.e2k.ad.ge.com>
	 <Pine.LNX.4.61.0610112129060.9822@yvahk01.tjqt.qr>
	 <452D5F49.70808@sandeen.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rUgm4z/onJn8nYmw2vy1"
Date: Wed, 11 Oct 2006 17:29:55 -0500
Message-Id: <1160605795.5723.5.camel@xenon.msp.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rUgm4z/onJn8nYmw2vy1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-10-11 at 16:16 -0500, Eric Sandeen wrote:
> Jan Engelhardt wrote:
> >> what is the status of GRIO support in the Linux port of XFS?
> >=20
> > Called realtime volume.
> > (http://en.wikipedia.org/wiki/XFS section 2.11)
>=20
> Well, not really.  realtime was a part of the old griov1 setup on Irix,
> but realtime !=3D GRIO.

the realtime allocator really should be renamed bitmap.

griov1 relied on an fs allocator that would return in bounded time=20
so it could satisfy irix realtime requirements thus it was
called "realtime".




> -Eric
>=20
--=20
Russell Cattelan <cattelan@thebarn.com>

--=-rUgm4z/onJn8nYmw2vy1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFLXBiNRmM+OaGhBgRAnbxAJ98+dCC9c/n0ot67PX+JWsvf4IligCfcVN7
kx1fmBgydgnlWB1luXh4Tp8=
=jtpP
-----END PGP SIGNATURE-----

--=-rUgm4z/onJn8nYmw2vy1--

