Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261452AbSJQP1g>; Thu, 17 Oct 2002 11:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261455AbSJQP1g>; Thu, 17 Oct 2002 11:27:36 -0400
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:54109 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S261452AbSJQP1f>;
	Thu, 17 Oct 2002 11:27:35 -0400
Date: Thu, 17 Oct 2002 17:33:26 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@digeo.com>, Dave Hansen <haveblue@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: (2.5.43mm1) Unable to handle kernel paging request
Message-ID: <20021017173326.A16400@jaquet.dk>
References: <3DADCEFC.7C17B1CC@digeo.com> <Pine.LNX.4.44.0210170028360.1466-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210170028360.1466-100000@localhost.localdomain>; from hugh@veritas.com on Thu, Oct 17, 2002 at 12:33:15AM +0100
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2002 at 12:33:15AM +0100, Hugh Dickins wrote:
> > Does it happen on 2.5.43?
>=20
> Isn't this covered by Trond's patch below:

This fixed it. Thanks.

Rasmus

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9rthGlZJASZ6eJs4RAusXAJ9PkPpHxnvVR3dSEKAlFefPD1rmdACdF4j9
DuWojFaHMllYadViqBYQX0Y=
=3aw3
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
