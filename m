Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267524AbTBLSif>; Wed, 12 Feb 2003 13:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267492AbTBLSif>; Wed, 12 Feb 2003 13:38:35 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:8418 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267524AbTBLSib>;
	Wed, 12 Feb 2003 13:38:31 -0500
Subject: Re: 2.5.60 cheerleading...
From: Paul Larson <plars@linuxtestproject.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3E4A6DBD.8050004@pobox.com>
References: <3E4A6DBD.8050004@pobox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-a6q52pdbVipl3BxPks+g"
X-Mailer: Ximian Evolution 1.0.5 
Date: 12 Feb 2003 12:43:34 -0600
Message-Id: <1045075415.22295.46.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-a6q52pdbVipl3BxPks+g
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This brings up an interesting point.  It seems like it's very common to
have a release that doesn't boot, or produces immediately obvious
problems.  I'm curious if you do any testing (LTP or otherwise) on the
kernels you intend to release.  If not, would it be possible for someone
to do this?  I know we could never catch every problem, but at least the
annoying, immediately noticeable problems could be caught and fixed
quickly.

If you wanted to do this, I think that would be great.  If you don't
have time, I understand but would you be ok with me or anyone else doing
at least a quick sniff test before release?  It doesn't have to be
anything fancy or time consuming.  I'm not looking to add delays, just a
small amount of extra testing before release so that hopefully more
people will be willing to try the releases on their systems.

Thanks,
Paul Larson

On Wed, 2003-02-12 at 09:52, Jeff Garzik wrote:
> Just to counteract all the 2.5.60 bug reports...
>=20
> After the akpm wave of compile fixes, I booted 2.5.60-BK on my Wal-Mart=20
> PC [via epia], and ran LTP on it, while also stressing it using=20
> fsx-linux in another window.  The LTP run showed a few minor failures,=20
> but overall 2.5.60-BK is surviving just fine, and with no corruption.
>=20
> So, it's working great for me :)
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20



--=-a6q52pdbVipl3BxPks+g
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj5KldYACgkQbkpggQiFDqc1GQCcDkYIR4p8TOZ5q0hDV54lMZCX
nm8An2hpPzWLCsKqlbWCOwTci1raa1gN
=T2SD
-----END PGP SIGNATURE-----

--=-a6q52pdbVipl3BxPks+g--

