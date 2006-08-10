Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161124AbWHJHsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161124AbWHJHsm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 03:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161122AbWHJHsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 03:48:42 -0400
Received: from mga03.intel.com ([143.182.124.21]:31603 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1161125AbWHJHsl (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 03:48:41 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,109,1154934000"; 
   d="asc'?scan'208"; a="101211389:sNHT51252495"
Subject: Re: Announcing free software graphics drivers for Intel
	i965	chipset
From: Keith Packard <keith.packard@intel.com>
Reply-To: keith.packard@intel.com
To: Jeff Garzik <jeff@garzik.org>
Cc: keith.packard@intel.com, Linux-kernel@vger.kernel.org,
       Dirk Hohndel <dirk.hohndel@intel.com>,
       Imad Sousou <imad.sousou@intel.com>
In-Reply-To: <44DADF88.5060102@garzik.org>
References: <1155151903.11104.112.camel@neko.keithp.com>
	 <44DACD51.7080607@garzik.org> <1155194157.6386.14.camel@neko.keithp.com>
	 <44DADF88.5060102@garzik.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+5nXx+atTE8sgHkPn1eD"
Organization: Intel Corp
Date: Thu, 10 Aug 2006 00:48:18 -0700
Message-Id: <1155196098.6386.17.camel@neko.keithp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+5nXx+atTE8sgHkPn1eD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-08-10 at 03:26 -0400, Jeff Garzik wrote:

> > Yes, the 3D stuff is in the Mesa CVS repository, but you'll need the
> > X.org 2D driver and the DRM kernel bits to use it.
>=20
> So, the answer to "is the 3D stuff available from git?" is "no"?

Yeah, Mesa is still using CVS. Brian Paul has promised to switch to git
after the 6.5.1 release sometime later this month. Until then, have fun
using CVS to look at the code.

--=20
keith.packard@intel.com

--=-+5nXx+atTE8sgHkPn1eD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBE2uTCQp8BWwlsTdMRAn9+AJ9wuBFhm4DL4d/PI7k9JR803elZvwCgwp+O
0MGtALrgY+iFVuzEzuVKjEw=
=tW3E
-----END PGP SIGNATURE-----

--=-+5nXx+atTE8sgHkPn1eD--
