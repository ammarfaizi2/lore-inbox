Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261186AbSKBOWF>; Sat, 2 Nov 2002 09:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261187AbSKBOWF>; Sat, 2 Nov 2002 09:22:05 -0500
Received: from coruscant.franken.de ([193.174.159.226]:35039 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S261186AbSKBOV7>; Sat, 2 Nov 2002 09:21:59 -0500
Date: Sat, 2 Nov 2002 15:25:43 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Stelian Pop <stelian.pop@fr.alcove.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netfilter-devel@lists.netfilter.org
Subject: Re: [PATCH 2.5.bk] make netfilter's ipt_TCPMSS compile again
Message-ID: <20021102152543.K8635@sunbeam.de.gnumonks.org>
References: <20021030141516.GG17103@tahoe.alcove-fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uMXS1e6ZLomxFVb/"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20021030141516.GG17103@tahoe.alcove-fr>; from stelian.pop@fr.alcove.com on Wed, Oct 30, 2002 at 03:15:16PM +0100
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.19-pre10-newnat-pptp
X-Date: Today is Pungenday, the 6th day of The Aftermath in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uMXS1e6ZLomxFVb/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2002 at 03:15:16PM +0100, Stelian Pop wrote:
> Hi,
>=20
> The attached patch is required to make ipt_TCPMSS.c compile again,
> due to the pmtu changes.

thanks, I will submit a fix for kernel inclusion.

> Stelian.
--=20
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"If this were a dictatorship, it'd be a heck of a lot easier, just so long
 as I'm the dictator."  --  George W. Bush Dec 18, 2000

--uMXS1e6ZLomxFVb/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9w+BnXaXGVTD0i/8RAjROAJ44YwN27loGVh+xmGvWG1csAe02ggCeN/Ya
zz4Ooqzsh7CLRVJuE7ZYWSI=
=rf3R
-----END PGP SIGNATURE-----

--uMXS1e6ZLomxFVb/--
