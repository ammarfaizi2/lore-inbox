Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbTE2TzZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 15:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbTE2TzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 15:55:25 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:36767 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262578AbTE2TzY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 15:55:24 -0400
Subject: RE: 2.5.70-mm2
From: Paul Larson <plars@linuxtestproject.org>
To: "Downing, Thomas" <Thomas.Downing@ipc.com>
Cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <170EBA504C3AD511A3FE00508BB89A920221E5FF@exnanycmbx4.ipc.com>
References: <170EBA504C3AD511A3FE00508BB89A920221E5FF@exnanycmbx4.ipc.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-a9BfjJW0rvRRhPLvGOew"
X-Mailer: Ximian Evolution 1.0.5 
Date: 29 May 2003 15:08:28 -0500
Message-Id: <1054238912.7864.2.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-a9BfjJW0rvRRhPLvGOew
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-05-29 at 11:48, Downing, Thomas wrote:=20
> -----Original Message-----
> From: Andrew Morton [mailto:akpm@digeo.com]
>=20
> >
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.=
70-
> mm2/
> [snip]
> >  Needs lots of testing.
> [snip]
>=20
> I for one would like to help in that testing, as might others.
> Could you point to/name some effective test tools/scripts/suites=20
> for testing your work?  As it is, my testing is just normal usage,
> lots of builds.
http://ltp.sourceforge.net
You can get several test suites from the Linux Test Project.  The main
one is LTP, but if you are more into database workload testing you may
want to give DOTS a try.  Compiling LTP on mm2 gave me a pretty severe
hang about 2 min. ago but past that I don't know anything until I reboot
and try to get some more information about what's going on.=20

-Paul Larson

--=-a9BfjJW0rvRRhPLvGOew
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj7WaLwACgkQbkpggQiFDqf0cgCaA+cV332ELaVGW5DjG/9ohHAZ
ZWsAnixPiuA+uTXdtyTJeVT6O9UFcRgR
=30oh
-----END PGP SIGNATURE-----

--=-a9BfjJW0rvRRhPLvGOew--

