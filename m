Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265966AbTGAEep (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 00:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265963AbTGAEep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 00:34:45 -0400
Received: from adsl-67-124-159-170.dsl.pltn13.pacbell.net ([67.124.159.170]:3552
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S265966AbTGAEds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 00:33:48 -0400
From: Joshua Kwan <joshk@triplehelix.org>
Date: Mon, 30 Jun 2003 21:41:15 -0700
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] O1int 0307010922 for 2.5.73 interactivity
Message-ID: <20030701044115.GA22902@triplehelix.org>
References: <20030701010412.GA21496@triplehelix.org> <200307011210.31612.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <200307011210.31612.kernel@kolivas.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 01, 2003 at 12:10:31PM +1000, Con Kolivas wrote:
> Well we're on the way. Sing with me... a tweaking we will go..
> Here is a tweaked patch with small changes otherwise which should help.
>=20
> P.S. Were you running 100Hz?
> Con

Yes, and with this patch coupled with reversing andrew's 100hz patch,
makes the skips largely disappear.

Or could it be that 1000hz alone fixes everything? Who knows...

-Josh

--=20
A man may be so much of everything that he is nothing of anything.
        -- Samuel Johnson


--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/ARDqT2bz5yevw+4RAm/1AJ4nQq7uokKLZoW4pCxedqX2NHtkdwCgwLS7
5mdzY8SFQruxbv0aiBt6WSM=
=895q
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
