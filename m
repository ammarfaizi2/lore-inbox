Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272412AbTGZDw2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 23:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272414AbTGZDw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 23:52:28 -0400
Received: from adsl-67-121-153-186.dsl.pltn13.pacbell.net ([67.121.153.186]:9607
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S272412AbTGZDw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 23:52:27 -0400
Date: Fri, 25 Jul 2003 21:07:37 -0700
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] 2.4.21-ck3 in schedule
Message-ID: <20030726040737.GA17753@triplehelix.org>
References: <20030725051847.GA1778@triplehelix.org> <200307261306.45743.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <200307261306.45743.kernel@kolivas.org>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2003 at 01:06:45PM +1000, Con Kolivas wrote:
> I suspect it's the variable Hz that is exported as 100 but runs as 1000 i=
n=20
> 2.4-ck. I suggest you build without the variable Hz and tuning so it runs=
 at=20
> 100Hz and try again.

I only have patch-1000_O1_PE_LL_0306300059_2.4.21-ck3.bz2 applied, so
this is presumably not an issue.=20

-Josh

--=20
Using words to describe magic is like using a screwdriver to cut roast beef.
		-- Tom Robbins

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/If6JT2bz5yevw+4RApK2AJ9oXoV+zmXug6Uhzop4dITZ+HM9PQCeKnS/
Ecipp1Sy0yMpC2t1V04fuyw=
=Cp2G
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
