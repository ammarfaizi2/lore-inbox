Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319494AbSILV1Q>; Thu, 12 Sep 2002 17:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319497AbSILV1Q>; Thu, 12 Sep 2002 17:27:16 -0400
Received: from bg77.anu.edu.au ([150.203.223.77]:7121 "EHLO lassus.himi.org")
	by vger.kernel.org with ESMTP id <S319494AbSILV1M>;
	Thu, 12 Sep 2002 17:27:12 -0400
Date: Fri, 13 Sep 2002 07:32:01 +1000
To: Andi Kleen <ak@suse.de>
Cc: Allan Duncan <allan.d@bigpond.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre4 & ff. blows away Xwindows with Matrox G400 and agpgart
Message-ID: <20020912213201.GA9168@himi.org>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	Allan Duncan <allan.d@bigpond.com>, linux-kernel@vger.kernel.org
References: <3D7FF444.87980B8E@bigpond.com.suse.lists.linux.kernel> <p73ptvjpmec.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <p73ptvjpmec.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.3.28i
From: simon@himi.org (Simon Fowler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2002 at 11:50:19AM +0200, Andi Kleen wrote:
> Allan Duncan <allan.d@bigpond.com> writes:
> >=20
> > Any suggestions of how to improve the error messages around the failure=
 point
> > are welcome.  Nothing is written into dmesg at the time of failure.
>=20
> You're booting with mem=3Dnopentium right ? It should go away when you tu=
rn
> that off. I'm working on a fix. You can safely turn it off for now, the=
=20
> old problems that it worked around are fixed.
>=20
The problem goes away without mem=3Dnopentium - I've just booted into
2.4.20-pre5aa2 and fired up X.

Simon

--=20
PGP public key Id 0x144A991C, or ftp://bg77.anu.edu.au/pub/himi/himi.asc
(crappy) Homepage: http://bg77.anu.edu.au
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://bg77.anu.edu.au/pub/mirrors/css/=20

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9gQfQQPlfmRRKmRwRAk30AKCxJA5mpQCIrrj/m4s+v0zFraZr2wCbB/A0
7/23O4vl8kMISe8QhhtTobQ=
=84Rq
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
