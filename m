Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbTEIGxz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 02:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTEIGxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 02:53:55 -0400
Received: from [194.196.110.14] ([194.196.110.14]:36719 "EHLO tor.trudheim.com")
	by vger.kernel.org with ESMTP id S262303AbTEIGxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 02:53:53 -0400
Subject: Re: Linux 2.4.21-rc2
From: Anders Karlsson <anders@trudheim.com>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030509065510.GA21381@ulima.unil.ch>
References: <fa.m0c9ksl.1ijqph1@ifi.uio.no>
	 <20030509065510.GA21381@ulima.unil.ch>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7dtcNCf/Mn96iqIyIWJp"
Organization: Trudheim Technology Limited
Message-Id: <1052463975.3458.2.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4Rubber Turnip 
Date: 09 May 2003 08:06:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7dtcNCf/Mn96iqIyIWJp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Morning,

On Fri, 2003-05-09 at 07:55, Gregoire Favre wrote:
> Hello,
>=20
> does it "only" correct the aic7xxx probolems, or does it also include
> some other changes?

The answer there is yes, there are plenty of other changes in there.
patch-2.4.21.log details them.

> My main interest is the XFS merge that is in 2.4.21-rc1-ac3 ;-)

Just checked the log, AFAICT there is no XFS fixes in the delta between
-rc1 and -rc2.

HTH,

/Anders

--=-7dtcNCf/Mn96iqIyIWJp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+u1NnLYywqksgYBoRAnnOAJ9qRxPPokHlA9pbYgHYD86dTGptYQCgj3G/
tt8ex1MB7LZRP/ZsW/MwJ7M=
=50s/
-----END PGP SIGNATURE-----

--=-7dtcNCf/Mn96iqIyIWJp--

