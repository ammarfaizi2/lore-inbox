Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262705AbVBYOTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbVBYOTz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 09:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbVBYOTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 09:19:55 -0500
Received: from smtp.gentoo.org ([156.56.111.197]:49809 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S262705AbVBYOTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 09:19:49 -0500
Subject: Re: [2.6 patch] i386 scx200.c: misc cleanups
From: Henrik Brix Andersen <brix@gentoo.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Christer Weinigel <christer@weinigel.se>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050224233732.GP8651@stusta.de>
References: <20050224233732.GP8651@stusta.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fpIPnpDajasWpllnyztC"
Organization: Gentoo Linux
Date: Fri, 25 Feb 2005 15:19:35 +0100
Message-Id: <1109341175.12351.10.camel@sponge.fungus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fpIPnpDajasWpllnyztC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-02-25 at 00:37 +0100, Adrian Bunk wrote:
> The patch below contains the following cleanups:
> - make some needlessly global code static
> - #if 0 the following unused global functions:
>   - scx200_gpio_dump
> - remove the following unneeded EXPORT_SYMBOL's:
>   - scx200_gpio_lock
>   - scx200_gpio_dump
>=20
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

I second those changes.

Signed-off-by: Henrik Brix Andersen <brix@gentoo.org>

./Brix
--=20
Henrik Brix Andersen <brix@gentoo.org>
Gentoo Linux

--=-fpIPnpDajasWpllnyztC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCHzP2v+Q4flTiePgRAmJRAJwO5FnIJM0TT17aItW/ZsksznwGLQCghZpZ
T5XcslKEnmHI82IQamny+/k=
=aaGf
-----END PGP SIGNATURE-----

--=-fpIPnpDajasWpllnyztC--

