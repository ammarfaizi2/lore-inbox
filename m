Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318119AbSGMHqM>; Sat, 13 Jul 2002 03:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318120AbSGMHqL>; Sat, 13 Jul 2002 03:46:11 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:33964 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S318119AbSGMHqK>; Sat, 13 Jul 2002 03:46:10 -0400
Date: Sat, 13 Jul 2002 10:43:54 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: compile the kernel with -Werror
Message-ID: <20020713104354.L739@alhambra.actcom.co.il>
References: <20020713102615.H739@alhambra.actcom.co.il> <Pine.LNX.4.44.0207131001460.3808-100000@linux-box.realnet.co.sz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="HBg0C3yr6HVa1ZCc"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207131001460.3808-100000@linux-box.realnet.co.sz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HBg0C3yr6HVa1ZCc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 13, 2002 at 10:02:19AM +0200, Zwane Mwaikambo wrote:
> On Sat, 13 Jul 2002, Muli Ben-Yehuda wrote:
>=20
> > stops. Compiling 2.5.25 with -Werror with my .config found only three
> > warnings (quite impressive, IMHO), and patches for those were sent to
> > trivial@rusty.
>=20
> You need to add more drivers to your config ;)

I'm doing something better - make allyesconfig, minus things like
intermezzo which are totally broken in 2.5.25.=20

Next up: -pedantic ;)
--=20
http://vipe.technion.ac.il/~mulix/
http://syscalltrack.sf.net/

--HBg0C3yr6HVa1ZCc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9L9o6KRs727/VN8sRAnoEAJ9+qUyvF45R6pSqSdVsz+mL1wT/SACcDTs6
evXR8bc70ZWjKOmDEVi/6D0=
=tNTH
-----END PGP SIGNATURE-----

--HBg0C3yr6HVa1ZCc--
