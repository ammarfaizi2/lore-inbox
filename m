Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbTLQSJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 13:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbTLQSJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 13:09:26 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:23178 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264500AbTLQSJY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 13:09:24 -0500
Subject: Re: no atapi cdrecord burning with 2.6.0-test11-bk10 / bk13
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Thomas Voegtle <thomas@voegtle-clan.de>
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0312171832120.32429-100000@needs-no.brain.uni-freiburg.de>
References: <Pine.LNX.4.21.0312171832120.32429-100000@needs-no.brain.uni-freiburg.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BeppC2za+Nh3x8fMOG1N"
Message-Id: <1071684685.11705.0.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Dec 2003 20:11:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BeppC2za+Nh3x8fMOG1N
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-12-17 at 19:35, Thomas Voegtle wrote:
> On Wed, 17 Dec 2003, Jens Axboe wrote:
>=20
> >=20
> > Apply this to test11-bkLATEST
> >=20
> > =3D=3D=3D=3D=3D drivers/block/scsi_ioctl.c 1.38 vs edited =3D=3D=3D=3D=
=3D
> > --- 1.38/drivers/block/scsi_ioctl.c	Thu Dec 11 18:55:17 2003
>=20
> Yes, this fixes the problem.
> I have now 2.6.0-test11-bk13 + patch.
>=20

Same this side, thanks.


--=20
Martin Schlemmer

--=-BeppC2za+Nh3x8fMOG1N
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/4JxNqburzKaJYLYRArZmAJ4ymKa9JMerYn9zM2cPyRnSBiR97ACfVEZo
ZhBr8Rlk7pmQsVjxJppU6jw=
=yB8o
-----END PGP SIGNATURE-----

--=-BeppC2za+Nh3x8fMOG1N--

