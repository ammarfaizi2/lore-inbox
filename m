Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbUJYQqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbUJYQqH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 12:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbUJYQqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 12:46:06 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:16040 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S262037AbUJYQg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 12:36:28 -0400
From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Mon, 25 Oct 2004 18:35:56 +0200
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BK kernel workflow
Message-ID: <20041025163556.GE20664@kiste>
References: <41752E53.8060103@pobox.com> <20041019153126.GG18939@work.bitmover.com> <41753B99.5090003@pobox.com> <4d8e3fd304101914332979f86a@mail.gmail.com> <20041019213803.GA6994@havoc.gtf.org> <4d8e3fd3041019145469f03527@mail.gmail.com> <20041019232710.GA10841@kroah.com> <pan.2004.10.25.13.01.49.824742@smurf.noris.de> <417D203B.4030508@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UnaWdueM1EBWVRzC"
Content-Disposition: inline
In-Reply-To: <417D203B.4030508@pobox.com>
User-Agent: Mutt/1.5.6+20040722i
X-Smurf-Spam-Score: -2.8 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UnaWdueM1EBWVRzC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Jeff Garzik:
> Wrong on all counts.
>=20
I stand corrected.

> The right answer is, "bk-netdev conflicts with some other BK tree that's=
=20
> also not yet in upstream"
>=20
That sounds somewhat painful.

Personally I'd do the BK tree integration in a somewhat more
Bitkeeper-ish way, but that's (obviously) Andrew's call.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de

--UnaWdueM1EBWVRzC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBfSts8+hUANcKr/kRAkbZAJ9YtmvXQc9Vw1t1vBzaQ6258lnfNgCfY3WA
ztBfiR+TKECTkVhsLwrLoS0=
=fy+0
-----END PGP SIGNATURE-----

--UnaWdueM1EBWVRzC--
