Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268155AbTAMUIa>; Mon, 13 Jan 2003 15:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268171AbTAMUIa>; Mon, 13 Jan 2003 15:08:30 -0500
Received: from dhcp31180135.columbus.rr.com ([24.31.180.135]:48017 "EHLO
	caphernaum.rivenstone.net") by vger.kernel.org with ESMTP
	id <S268155AbTAMUI3>; Mon, 13 Jan 2003 15:08:29 -0500
Date: Mon, 13 Jan 2003 13:59:59 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.57
Message-ID: <20030113185958.GA17866@caphernaum.rivenstone.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0301131039050.13791-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301131039050.13791-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

    Antonio Daplas' patch to make intel_agp_init() in
drivers/char/agp/intel_agp.c non-static somehow got clobbered.
Removing the static keyword makes i810fb compile again.

    bkbits.net isn't working for me or I could have at least provided
a link to the changeset.

--=20
Joseph Fannin
jhf@rivenstone.net

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+IwyuWv4KsgKfSVgRAsVKAJsHVkYy0QrmTrteijq6Jh63gjH/4ACgms0U
bDMsJVs+voIMFLSwtakKQ9g=
=oFaK
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
