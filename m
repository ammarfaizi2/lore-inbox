Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265517AbSKSOsz>; Tue, 19 Nov 2002 09:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265657AbSKSOsy>; Tue, 19 Nov 2002 09:48:54 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:61102 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265517AbSKSOst>;
	Tue, 19 Nov 2002 09:48:49 -0500
Subject: Re: [LTP] Re: LTP - gettimeofday02 FAIL
From: Paul Larson <plars@linuxtestproject.org>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: jim.houston@attbi.com, lkml <linux-kernel@vger.kernel.org>,
       high-res-timers-discourse@lists.sourceforge.net,
       ltp-list@lists.sourceforge.net, jim.houston@ccur.com
In-Reply-To: <20021119140205.GA30120@suse.de>
References: <200211190127.gAJ1RWg11023@linux.local>
	<1037713044.24031.15.camel@plars>  <20021119140205.GA30120@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-g0ChaGCpt92dlHjgTOF6"
X-Mailer: Ximian Evolution 1.0.5 
Date: 19 Nov 2002 08:50:02 -0600
Message-Id: <1037717403.21246.21.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-g0ChaGCpt92dlHjgTOF6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-11-19 at 08:02, Dave Jones wrote:
> On Tue, Nov 19, 2002 at 07:37:23AM -0600, Paul Larson wrote:
>  > > I just tried gettimeofday02 on an old pentium-pro dual processor, an=
d yes
>  > > the time goes backwards with a 2.5.48 kernel.
>  > This has been noticed, I've posted to lkml about it.  The only person
>  > who replied to me seems to be suggesting it is a hardware issue, but I
>  > can't believe it is impossible to work around.
>=20
> Especially if earlier kernels got it right..
This is bug #100 in bugme if anyone wants to track it.=20
http://bugme.osdl.org/show_bug.cgi?id=3D100

-Paul Larson

--=-g0ChaGCpt92dlHjgTOF6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj3aT5oACgkQbkpggQiFDqe7wwCdFuDolrQneCdsdrp40wcpmmki
euIAniAwfsQcxiGCg6KGGJ3PyApvSnsK
=ZXpg
-----END PGP SIGNATURE-----

--=-g0ChaGCpt92dlHjgTOF6--

