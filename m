Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267179AbUGVTm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267179AbUGVTm1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 15:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUGVTm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 15:42:27 -0400
Received: from wblv-254-37.telkomadsl.co.za ([165.165.254.37]:16842 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S267179AbUGVTmO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 15:42:14 -0400
Subject: Re: [PATCH] delete devfs
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Wichert Akkerman <wichert@wiggy.net>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040721222008.GG25218@wiggy.net>
References: <20040721141524.GA12564@kroah.com>
	 <E1BnIHx-0003Py-00@chiark.greenend.org.uk>
	 <20040721222008.GG25218@wiggy.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-diSHlnPpmTPEAZz9wJLl"
Message-Id: <1090525499.10205.19.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 22 Jul 2004 21:44:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-diSHlnPpmTPEAZz9wJLl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-07-22 at 00:20, Wichert Akkerman wrote:
> Previously Matthew Garrett wrote:
> > The new Debian installer requires devfs on several architectures, even
> > for 2.6 installs. That's unlikely to get changed before release.
>=20
> The Debian installer did not have a choice: until very recently udev was
> not quite up to the task and having all devices on a filesystem simply
> takes too much space. So for the next Debian release the installer will
> have to rely on devfs. But since it is based on 2.4 kernels anyway that
> isn't a problem.
>=20

IMHO, udev was realy since beginning March already - prob earlier.
Sure, some device drivers did not support it (and some still do not),
but there are others ways to get past that ...


--=20
Martin Schlemmer

--=-diSHlnPpmTPEAZz9wJLl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBABk7qburzKaJYLYRAkT4AJ4yulp5jBCSsbjViIsUptnPiR238ACeOYQu
kbpZFdB5lKGMF8rvUTeycCs=
=3nFs
-----END PGP SIGNATURE-----

--=-diSHlnPpmTPEAZz9wJLl--

