Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265323AbTGAAtx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 20:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265757AbTGAAtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 20:49:53 -0400
Received: from adsl-67-124-159-170.dsl.pltn13.pacbell.net ([67.124.159.170]:3552
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S265323AbTGAAtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 20:49:52 -0400
Date: Mon, 30 Jun 2003 18:04:13 -0700
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O1int 0307010922 for 2.5.73 interactivity
Message-ID: <20030701010412.GA21496@triplehelix.org>
References: <200307010944.46971.kernel@kolivas.org> <200307010952.26595.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <200307010952.26595.kernel@kolivas.org>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Jul 2003 09:44, Con Kolivas wrote:
> Here is an evolution of the O1int design to minimise audio skips/smooth X.
> I've been forced to work with even less sleep than usual because of this
> but I'm getting quite happy with it now.
[snip]
> More thrashing please. I know these had been coming out frequently but I
> needed to assess every small increment. I hope not to need to do too much
> from here.

Well, this doesn't quite work. It initially seemed to prevent audio
skips, but now I can't launch a new Eterm (with translucency) with the
music not skipping, no change from stock -mm. It seems to work better
under heavy load (extracting a chroot tarball for example) than when
nothing is happening, which kind of puzzles me. In both cases I launch
a new Eterm while music is playing.

Inexplicably, it sometimes prevents skipping entirely.

I'm on a P4 2.0GHz with 256MB of SDRAM.

Regards
Josh

--=20
A man may be so much of everything that he is nothing of anything.
        -- Samuel Johnson


--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/AN4MT2bz5yevw+4RAhsoAJ91pkH9iZyR+Mc6ebgTeZZcs/qBlACaAz/L
g2jXUc8iAddIrKlwti20GnM=
=mO3w
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
