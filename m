Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268121AbTBMWff>; Thu, 13 Feb 2003 17:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268124AbTBMWff>; Thu, 13 Feb 2003 17:35:35 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:37039 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268121AbTBMWfd>;
	Thu, 13 Feb 2003 17:35:33 -0500
Subject: Re: 2.5.60 cheerleading...
From: Paul Larson <plars@linuxtestproject.org>
To: Valdis.Kletnieks@vt.edu
Cc: lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, edesio@task.com.br
In-Reply-To: <200302132220.h1DMKtFT011682@turing-police.cc.vt.edu>
References: <200302132154.h1DLs3ar012874@darkstar.example.net>
	<1045173477.28494.66.camel@plars> 
	<200302132220.h1DMKtFT011682@turing-police.cc.vt.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-Pw1O7Pf/SDNazpy1kc5A"
X-Mailer: Ximian Evolution 1.0.5 
Date: 13 Feb 2003 16:39:42 -0600
Message-Id: <1045175983.28493.74.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Pw1O7Pf/SDNazpy1kc5A
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-02-13 at 16:20, Valdis.Kletnieks@vt.edu wrote:
> What would help a lot of people (certainly me, at least), would be if
> somebody kept a well-publicized "already known errata" list along with
> (possibly unofficial) work-around patches.  Something along the line of:
>=20
> compile fails in drivers/widget/fooby.c with error:
> undefined structure member 'blat' in line 1149.
> To fix:   apply <this patch>
Good idea, I'd bet that might cut down on some of the duplicate bug
reports too (at least the annoying ones that occur days or even weeks
after the initial report).

I certainly wouldn't mind throwing something like this up on the LTP
website if people are interested.  If anyone wants to spam me with some
initial data for 2.5.60 feel free.

-Paul Larson

--=-Pw1O7Pf/SDNazpy1kc5A
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj5MHq0ACgkQbkpggQiFDqc//QCgkAmF4DWqyjgAH4KKy+rF5gYv
joIAn25x0b+IVaJWW98TbYnBSqHZ/k4K
=+n0x
-----END PGP SIGNATURE-----

--=-Pw1O7Pf/SDNazpy1kc5A--

