Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267425AbUGNQCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267425AbUGNQCq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 12:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267431AbUGNQCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 12:02:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8899 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267425AbUGNQCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 12:02:44 -0400
Subject: Re: [Q] don't allow tmpfs to page out
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Michael Buesch <mbuesch@freenet.de>
Cc: William Stearns <wstearns@pobox.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200407141751.14292.mbuesch@freenet.de>
References: <200407141654.31817.mbuesch@freenet.de>
	 <Pine.LNX.4.58.0407141141350.6240@sparrow>
	 <200407141751.14292.mbuesch@freenet.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-W726DKyEyiDB72WxNx/3"
Organization: Red Hat UK
Message-Id: <1089820882.2806.7.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 14 Jul 2004 18:01:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-W726DKyEyiDB72WxNx/3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-07-14 at 17:51, Michael Buesch wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Quoting William Stearns <wstearns@pobox.com>:
> > Good afternoon, Michael,
>=20
> Hi William,
>=20
> > 	I suspect a regular ramdisk, as opposed to tmpfs, would do what=20
> > you want.
>=20
> No, since a regular ramdisk is static in size.

which is why there is ramfs .. :)

--=-W726DKyEyiDB72WxNx/3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA9VjSxULwo51rQBIRAtFBAJ9krb3FV0b/41FlROLsIMf4lRDcygCeKOV6
BEw7071WUhNh77sxZzncf5Y=
=k2FE
-----END PGP SIGNATURE-----

--=-W726DKyEyiDB72WxNx/3--

