Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbULMVJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbULMVJg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 16:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbULMVJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 16:09:05 -0500
Received: from smtp09.auna.com ([62.81.186.19]:33764 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S261181AbULMVIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 16:08:46 -0500
Date: Mon, 13 Dec 2004 21:08:45 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: What if?
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
References: <41AE5BF8.3040100@gmail.com> <20041202044034.GA8602@thunk.org>
	<1101976424l.5095l.0l@werewolf.able.es>
	<1101984361.28965.10.camel@tara.firmix.at>
	<cpkc5i$84f$1@terminus.zytor.com>
In-Reply-To: <cpkc5i$84f$1@terminus.zytor.com> (from hpa@zytor.com on Mon
	Dec 13 16:23:30 2004)
X-Mailer: Balsa 2.2.6
Message-Id: <1102972125l.7475l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-/p1NiJRJ2PziA+j4mPJj"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-/p1NiJRJ2PziA+j4mPJj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 2004.12.13, H. Peter Anvin wrote:
> Followup to:  <1101984361.28965.10.camel@tara.firmix.at>
> By author:    Bernd Petrovitsch <bernd@firmix.at>
> In newsgroup: linux.dev.kernel
> >=20
> > The unanswered question is: What does it actually buy?
> >=20
>=20
> Type-safe linkage, mainly.  That actually would be a nice thing.
>=20

And let the compiler do all what now is done by hand wrt driver methods,
inheritance, specialized methods and so on, with a 1000% increase in securi=
ty
because compiler does not forget to do thinks, like we do ;)

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-rc2-jam4 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-1mdk)) #4


--=-/p1NiJRJ2PziA+j4mPJj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBvgTdRlIHNEGnKMMRAgpZAJ0SeGeRDuuvm/XNf/dPccgXFDJkUwCdGqaU
Y13vaKwJyAO2B93pJY1dtdM=
=abIV
-----END PGP SIGNATURE-----

--=-/p1NiJRJ2PziA+j4mPJj--

