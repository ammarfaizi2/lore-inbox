Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267689AbUBTCXT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 21:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267691AbUBTCXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 21:23:19 -0500
Received: from caffeine.cafuego.net ([210.8.121.71]:35456 "EHLO
	caffeine.cc.com.au") by vger.kernel.org with ESMTP id S267689AbUBTCXQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 21:23:16 -0500
Subject: Re: 2.6.2 PPC ALSA snd-powermac
From: Peter Lieverdink <peter@cc.com.au>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20040215133946.GT1308@fs.tum.de>
References: <1076483508.13791.6.camel@kahlua> <s5hr7x1bzvr.wl@alsa2.suse.de>
	 <1076540202.13791.19.camel@kahlua> <20040214164707.GL1308@fs.tum.de>
	 <1076794515.30208.0.camel@kahlua>  <20040215133946.GT1308@fs.tum.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UiXHTHsL2MkGNuFG5IWf"
Organization: Creative Contingencies Pty. Ltd.
Message-Id: <1077243790.29312.12.camel@kahlua>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 20 Feb 2004 13:23:10 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UiXHTHsL2MkGNuFG5IWf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Problem solved on 2.6.3

- Peter.

On Mon, 2004-02-16 at 00:39, Adrian Bunk wrote:
> On Sun, Feb 15, 2004 at 08:35:15AM +1100, Peter Lieverdink wrote:
>=20
> > No prob, here you go...
>=20
> Thanks.
>=20
> Now I do understand the problem.
>=20
> Short version:
> It should work if you try 2.6.3-rc3 instead.
>=20
> Long version:
> arch/ppc/Kconfig didn't use drivers/Kconfig in 2.6.2 and didn't inclide=20
> drivers/i2c/Kconfig.
> In 2.6.3-rc3, arch/ppc/Kconfig uses drivers/Kconfig.
>=20
> > - Peter.
> >...
>=20
> cu
> Adrian
--=20
Peter Lieverdink <peter@cc.com.au>
Creative Contingencies Pty. Ltd.

--=-UiXHTHsL2MkGNuFG5IWf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBANW+Of34AjKyA6C4RAoK+AKCztJmQixk3MF7tAuKj6soOJtcUvwCfZNuC
b4pKnuxxC2zOUgZl4yhLOoo=
=qJJO
-----END PGP SIGNATURE-----

--=-UiXHTHsL2MkGNuFG5IWf--

