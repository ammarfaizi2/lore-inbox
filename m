Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283608AbRK3NRT>; Fri, 30 Nov 2001 08:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283612AbRK3NRJ>; Fri, 30 Nov 2001 08:17:09 -0500
Received: from adsl-64-109-200-233.dsl.milwwi.ameritech.net ([64.109.200.233]:43502
	"EHLO alphaflight.d6.dnsalias.org") by vger.kernel.org with ESMTP
	id <S283608AbRK3NRB>; Fri, 30 Nov 2001 08:17:01 -0500
Date: Fri, 30 Nov 2001 07:16:58 -0600
From: "M. R. Brown" <mrbrown@0xd6.org>
To: Wayne Scott <wscott@bitmover.com>
Cc: linux-kernel@vger.kernel.org, jmd@turbogeek.org
Subject: Re: Extraneous whitespace removal?
Message-ID: <20011130071658.A786@0xd6.org>
In-Reply-To: <20011129.094040.124092017.wscott@bitmover.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20011129.094040.124092017.wscott@bitmover.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Wayne Scott <wscott@bitmover.com> on Thu, Nov 29, 2001:

> From: Jeremy M. Dolan <jmd@turbogeek.org>
> > Pluses:
> >  - clean up messy whitespace
> >  - cut precious picoseconds off compile time
> >  - cut kernel tree by 200k (+/- alot)
> >
> > Minuses:
> >  - adds 3.8M bzip2 or 4.7M gzip to next diff
>=20
> As someone who has spend a lot of time working on version control and
> file merging, let be tell you the big minus you missed.=20
>=20
> After this patch go into the Linux kernel, everyone who is maintaining
> a set of patches in parallel with the main kernel has a lot of extra
> work resolving the conflicts caused by this change.  You have touched
> a huge number of lines and people will have to walk a list of merge
> conflicts everywhere they have made local changes and pick their side.
> And anytime people do a whole series of the same edits over and over
> they will miss that real conflict in the middle and lose some
> important change.
>=20

diff -w, diff -b, diff -B

M. R.

--huq684BweRXVnRxX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8B4bKaK6pP/GNw0URAlGZAJ4v4a06oo0cjy8JBx49w3p+VFyaNgCfSfTT
P59G0yh8n4bMRpIBXdaIV8E=
=bnSz
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
