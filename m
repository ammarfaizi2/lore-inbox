Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbVHNAWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbVHNAWu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 20:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVHNAWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 20:22:50 -0400
Received: from smtp.gentoo.org ([134.68.220.30]:11918 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S932173AbVHNAWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 20:22:49 -0400
Subject: Re: [PATCH] Watchdog device node name unification
From: Henrik Brix Andersen <brix@gentoo.org>
To: Olaf Hering <olh@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
In-Reply-To: <20050813234322.GA30563@suse.de>
References: <1123969015.13656.13.camel@sponge.fungus>
	 <20050813232519.GA20256@infradead.org>  <20050813234322.GA30563@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WJdVmhCrcoG0jwTgqY37"
Organization: Gentoo Metadistribution
Date: Sun, 14 Aug 2005 02:22:41 +0200
Message-Id: <1123978962.13656.21.camel@sponge.fungus>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WJdVmhCrcoG0jwTgqY37
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-08-14 at 01:43 +0200, Olaf Hering wrote:
>  On Sun, Aug 14, Christoph Hellwig wrote:
> > Please don't.  misdevice.name is a description of the device, and doesn=
't
> > have any relation with the name of the device node.
>=20
> It is used for /class/misc/$name/dev

... and for udev-enabled systems, it's the name of the device node to be
created.

./Brix
--=20
Henrik Brix Andersen <brix@gentoo.org>
Gentoo Metadistribution | Mobile computing herd

--=-WJdVmhCrcoG0jwTgqY37
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC/o7Rv+Q4flTiePgRAkdoAKCGvOr+qOvBXAaG66kDpjg7NgoHOgCgia89
rGCu3y60sOsVNUh5kK4zlXU=
=Nih4
-----END PGP SIGNATURE-----

--=-WJdVmhCrcoG0jwTgqY37--

