Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266669AbUGKSL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266669AbUGKSL1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 14:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266671AbUGKSL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 14:11:27 -0400
Received: from wblv-244-142.telkomadsl.co.za ([165.165.244.142]:34265 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S266669AbUGKSLW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 14:11:22 -0400
Subject: Re: [2.6.7+current cset] *bug* in scheduler...
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: =?iso-8859-2?Q?Pawe=B3?= Sikora <pluto@pld-linux.org>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <200407080102.31766.pluto@pld-linux.org>
References: <200407080102.31766.pluto@pld-linux.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IHtpDCuLaV8p9/qXXrTE"
Message-Id: <1089569473.8708.3.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 11 Jul 2004 20:11:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IHtpDCuLaV8p9/qXXrTE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-07-08 at 01:02, Pawe=C5=82 Sikora wrote:
> with cset-20040630_0514 everything works fine.
> with current cset xmms causing nice ooops ;)
>=20

Unfortunately you will have to try without the nVidia driver to get
somebody to have a look.  I have similar issues with latest nvidia
driver and when fbdev in use - vga=3Dnormal works fine.


Cheers,

--=20
Martin Schlemmer

--=-IHtpDCuLaV8p9/qXXrTE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA8YLBqburzKaJYLYRAvKxAKCHA7UNqPtPY9CBZgida7bQeTfmEwCeOJu/
pFFhje4yhRcdfFtH48jqAE8=
=n87+
-----END PGP SIGNATURE-----

--=-IHtpDCuLaV8p9/qXXrTE--

