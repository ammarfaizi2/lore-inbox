Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264469AbTLQRVc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 12:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbTLQRVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 12:21:32 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:21642 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264469AbTLQRVa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 12:21:30 -0500
Subject: Re: no atapi cdrecord burning with 2.6.0-test11-bk10 / bk13
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <yw1xd6anjwt6.fsf@kth.se>
References: <Pine.LNX.4.21.0312171604390.32339-100000@needs-no.brain.uni-freiburg.de>
	 <yw1xd6anjwt6.fsf@kth.se>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-P/FuN/mmRqWGdaleXV2y"
Message-Id: <1071681810.5067.14.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Dec 2003 19:23:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-P/FuN/mmRqWGdaleXV2y
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-12-17 at 17:20, M=E5ns Rullg=E5rd wrote:
> Thomas Voegtle <thomas@voegtle-clan.de> writes:
>=20
> > cdrecord -dev=3DATAPI -scanbus  with 2.6.0-test11-bk10 and bk13 shows t=
his:
>=20
> cdrecord dev=3D/dev/cdrom -scanbus  is the recommended way, whatever
> cdrecord tries to make you believe.

Well, it might be related to my problem of k3b not being able
to detect any devices since bk9 at least.


--=20
Martin Schlemmer

--=-P/FuN/mmRqWGdaleXV2y
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/4JESqburzKaJYLYRAl9FAJ43Jj8VIkVwfu4B6RnDY3CqD07Q/QCfWXho
VzHWCf75yZFM/MqrygB7IZo=
=nMpe
-----END PGP SIGNATURE-----

--=-P/FuN/mmRqWGdaleXV2y--

