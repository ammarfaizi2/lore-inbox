Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266971AbTBCTAJ>; Mon, 3 Feb 2003 14:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266976AbTBCTAJ>; Mon, 3 Feb 2003 14:00:09 -0500
Received: from mh57-mps.martin.mh57.de ([213.68.114.153]:6294 "EHLO
	mh57-mps.martin.mh57.de") by vger.kernel.org with ESMTP
	id <S266971AbTBCTAI>; Mon, 3 Feb 2003 14:00:08 -0500
Date: Mon, 3 Feb 2003 20:09:20 +0100
From: Martin Hermanowski <martin@martin.mh57.de>
To: Valdis.Kletnieks@vt.edu
Cc: John Bradford <john@grabjohn.com>, Seamus <assembly@gofree.indigo.ie>,
       linux-kernel@vger.kernel.org
Subject: Re: CPU throttling??
Message-ID: <20030203190920.GO1472@martin.mh57.de>
References: <200302031713.h13HD2K8000181@darkstar.example.net> <200302031857.h13IvHa0025735@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PpAOPzA3dXsRhoo+"
Content-Disposition: inline
In-Reply-To: <200302031857.h13IvHa0025735@turing-police.cc.vt.edu>
User-Agent: Mutt/1.3.28i
X-Authenticated-ID: martin
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PpAOPzA3dXsRhoo+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2003 at 01:57:17PM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 03 Feb 2003 17:13:02 GMT, John Bradford said:
>=20
> > Incidently, Linux has always halted the processor, rather than spun in
> > an idle loop, which saves power.
>=20
> It's conceivable that a CPU halted at 1.2Gz takes less power than one
> at 1.6Gz - anybody have any actual data on this?  Alternately phrased,
> does CPU throttling save power over and above what the halt does?

If I slow down my 1GHz CPU to 732MHz, I get 15min more (195min total).
So it is not much, but noticeable.

Regards,
Martin

--PpAOPzA3dXsRhoo+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+Pr5gV3BRtc7IW1wRAuuIAJoCnk1VAATNE4XpmlQFTzNzombCnwCfUaPw
yfKBHJN+2YfRt8vzVOxQAqw=
=pj4X
-----END PGP SIGNATURE-----

--PpAOPzA3dXsRhoo+--
