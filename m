Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbULEMLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbULEMLr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 07:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbULEMLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 07:11:47 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:54500 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S261279AbULEMLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 07:11:45 -0500
Subject: Re: [PATCH] Fix ALSA resume
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
In-Reply-To: <41B2DDA5.20208@triplehelix.org>
References: <1102195391.1560.65.camel@tux.rsn.bth.se>
	 <20041204172855.350100d0.akpm@osdl.org>	<41B282F0.3020704@triplehelix.org>
	 <20041204235155.3b8ad3fc.akpm@osdl.org>  <41B2DDA5.20208@triplehelix.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HHUuHLKgGAfTZAWPS4FX"
Message-Id: <1102248700.1560.69.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 05 Dec 2004 13:11:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HHUuHLKgGAfTZAWPS4FX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-12-05 at 11:06, Joshua Kwan wrote:
> Andrew Morton wrote:
> > OK, suspend was failing, yes?
>=20
> Yes.
>=20
> > Can you please test Martin's patch?
>=20
> Works for me.

Works here as well.
This is the only problem I've had with ALSA and swsusp.
It even handles suspending in the middle of playing music and then
resuming and continuing where it was.

--=20
/Martin

--=-HHUuHLKgGAfTZAWPS4FX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBsvr7Wm2vlfa207ERAgliAJ0R31DlwbNSPQkimfo+EBd8q13qggCdG7Lx
lxL8pnj2HvLMAzBIPCPPD9I=
=jyRt
-----END PGP SIGNATURE-----

--=-HHUuHLKgGAfTZAWPS4FX--
