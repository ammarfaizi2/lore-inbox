Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310450AbSCBUtD>; Sat, 2 Mar 2002 15:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310452AbSCBUsy>; Sat, 2 Mar 2002 15:48:54 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:28853 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S310450AbSCBUsr>; Sat, 2 Mar 2002 15:48:47 -0500
Date: Sat, 2 Mar 2002 15:48:39 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: linux-kernel@vger.kernel.org
Cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Subject: Re: [PATCH] 3c509 Power Management (take 2)
Message-ID: <20020302204839.GA4958@ufies.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Zwane Mwaikambo <zwane@linux.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.44.0203010826180.26745-100000@netfinity.realnet.co.sz> <Pine.LNX.4.44.0203011222010.31530-100000@netfinity.realnet.co.sz> <20020301093317.I22608@lynx.adilger.int>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <20020301093317.I22608@lynx.adilger.int>
User-Agent: Mutt/1.3.27i
X-Operating-System: debian SID Gnu/Linux 2.4.18 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2002 at 09:33:17AM -0700, Andreas Dilger wrote:
> PS - any chance you can fix this for xirc2ps_cs?  I can test if you want,
>      as my current card always fails to word after APM suspend (needs a
>      "cardctl eject; cardctl insert" to work again.

It looks like there is a general problem concerning PM for pcmcia cards.
I have a similar problem with a 3c59x card (which is managed by hotplug)
and I am convinced that the problem is not in the driver code.

Christophe

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

People that hate cats will come back as mice in their next life.
--Faith Resnick

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8gTqnj0UvHtcstB4RAvgpAJ9S3fQvi3btjCDjinmu02ZzowPtugCdF+eX
kU2Af7Vll5z+puqHr4fATE0=
=IOhw
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
