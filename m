Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262522AbVAJTzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbVAJTzQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 14:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbVAJTzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 14:55:02 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:48293 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262522AbVAJTxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 14:53:19 -0500
Subject: Re: [2.6 patch] remove SPF-using wbsd lists from MAINTAINERS
From: Stephen Pollei <stephen_pollei@comcast.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, postmaster@list.drzeus.cx,
       postmaster@stusta.mhn.de, spf discuss <spf-discuss@v2.listbox.com>
In-Reply-To: <20050110184307.GB2903@stusta.de>
References: <20050110184307.GB2903@stusta.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-nw3HzEkannKaB6TqR03g"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Jan 2005 11:55:09 -0800
Message-Id: <1105386915.980.10.camel@fury>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nw3HzEkannKaB6TqR03g
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-01-10 at 10:43, Adrian Bunk wrote:

Perhaps a better approach might be to try and resolve why your emails
got rejected. Are there invalid spf records involved? Is something at
list.drzeus.cx misconfigured ?

> <wbsd-devel@list.drzeus.cx>:
> Connected to 213.115.189.212 but sender was rejected.
> Remote host said: 417 SPF error mailout.stusta.mhn.de: Address does not=20
> pass the
> +Sender Policy Framework
> I'm not going to try again; this message has been in the queue too long.
>=20
> <drzeus-wbsd@drzeus.cx>:
> Connected to 213.115.189.212 but sender was rejected.
> Remote host said: 417 SPF error mailout.stusta.mhn.de: Address does not=20
> pass the
> +Sender Policy Framework
> I'm not going to try again; this message has been in the queue too long.
>=20
> <--  snip  -->
>=20
>=20
>=20
> IMHO lists rejecting emails based on some non-standard extension don't=20
> belong into MAINTAINERS.
>=20
>=20
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>=20
> --- linux-2.6.10-mm2-full/MAINTAINERS.old	2005-01-10 19:20:32.000000000 +=
0100
> +++ linux-2.6.10-mm2-full/MAINTAINERS	2005-01-10 19:26:24.000000000 +0100
> @@ -2539,8 +2539,6 @@
> =20
>  W83L51xD SD/MMC CARD INTERFACE DRIVER
>  P:	Pierre Ossman
> -M:	drzeus-wbsd@drzeus.cx
> -L:	wbsd-devel@list.drzeus.cx
>  W:	http://projects.drzeus.cx/wbsd
>  S:	Maintained


--=20
http://dmoz.org/profiles/pollei.html
http://sourceforge.net/users/stephen_pollei/
http://www.orkut.com/Profile.aspx?uid=3D2455954990164098214
http://stephen_pollei.home.comcast.net/
GPG Key fingerprint =3D EF6F 1486 EC27 B5E7 E6E1  3C01 910F 6BB5 4A7D 9677

--=-nw3HzEkannKaB6TqR03g
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQBB4t2ckQ9rtUp9lncRArgNAJ9f0ZO0Lm1ks4ciQSDK2bo0H8FOKwCfeF4f
u5daZTZVfkvvtlzW9Bp8b0I=
=ymAh
-----END PGP SIGNATURE-----

--=-nw3HzEkannKaB6TqR03g--

