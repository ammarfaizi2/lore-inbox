Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266813AbUIOQiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266813AbUIOQiy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 12:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266622AbUIOQKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 12:10:42 -0400
Received: from null.rsn.bth.se ([194.47.142.3]:35525 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S266643AbUIOQH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 12:07:57 -0400
Subject: Re: pdc202xx_new + software raid0 freezes on array writes
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <pan.2004.09.15.06.18.23.771355@nn7.de>
References: <20040914160530.GA729@evilgeek.net>
	 <pan.2004.09.15.06.18.23.771355@nn7.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Tlrr4PraHCvRnzFjRg0r"
Message-Id: <1095264474.1143.29.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 15 Sep 2004 18:07:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Tlrr4PraHCvRnzFjRg0r
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-09-15 at 08:18, Soeren Sonnenburg wrote:

> I had the very same problems with the pdc20268 and also reported them
> (that was 1-2 years ago)... I threw them away now and replaced them with
> some hpt370 controllers... then also the problems went away...

Same here, also reported to lkml. Also replaced with hpt370, havn't had
a single problem that we could pinpoint to the hpt370 controllers since.

--=20
/Martin

--=-Tlrr4PraHCvRnzFjRg0r
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBSGjaWm2vlfa207ERAoEsAJ0Tjm/P5BY6OpNYQdvGFP5hYmrVEQCeKf/7
A5D5GHKCRZ9sx7J7yadI7sw=
=an9c
-----END PGP SIGNATURE-----

--=-Tlrr4PraHCvRnzFjRg0r--
