Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268298AbTAMU2T>; Mon, 13 Jan 2003 15:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268299AbTAMU2T>; Mon, 13 Jan 2003 15:28:19 -0500
Received: from dhcp31180135.columbus.rr.com ([24.31.180.135]:3986 "EHLO
	caphernaum.rivenstone.net") by vger.kernel.org with ESMTP
	id <S268298AbTAMU2S>; Mon, 13 Jan 2003 15:28:18 -0500
Date: Mon, 13 Jan 2003 14:19:58 -0500
To: Larry McVoy <lm@work.bitmover.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.57
Message-ID: <20030113191958.GA21734@caphernaum.rivenstone.net>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0301131039050.13791-100000@penguin.transmeta.com> <20030113185958.GA17866@caphernaum.rivenstone.net> <20030113202034.GF16181@work.bitmover.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <20030113202034.GF16181@work.bitmover.com>
User-Agent: Mutt/1.4i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2003 at 12:20:34PM -0800, Larry McVoy wrote:
> >     bkbits.net isn't working for me or I could have at least provided
> > a link to the changeset.
>=20
> We've upgrade to patch a security hole, we're sorting out some permissions
> problems.   Should have it fixed in an hour or so.

    Thanks for the quick response.

    Anyway, it looks like I somehow botched up when patching up to
2.5.57 so I was really looking at 2.5.54 -- the fix for
intel_agp_init() is properly in 2.5.57.  Sorry.

--=20
Joseph Fannin
jhf@rivenstone.net

"That's all I have to say about that." -- Forrest Gump.

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+IxFeWv4KsgKfSVgRAoP/AJ9JJsH4amG58UrgxrA38VBbKUzNyQCfYlul
HekdDSQg85XPhQgZYokutOw=
=aEat
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
