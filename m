Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289191AbSBZXjL>; Tue, 26 Feb 2002 18:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289099AbSBZXi5>; Tue, 26 Feb 2002 18:38:57 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:61062 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S289191AbSBZXiq>; Tue, 26 Feb 2002 18:38:46 -0500
Date: Tue, 26 Feb 2002 18:38:33 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 3c59x and cardbus
Message-ID: <20020226233832.GK803@ufies.org>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020226173038.GD803@ufies.org> <3C7BC897.8D607D08@zip.com.au> <20020226175819.GE803@ufies.org> <20020226181510.GF803@ufies.org> <3C7BD91C.3B758704@zip.com.au> <20020226185907.GG803@ufies.org> <20020226230010.GI803@ufies.org> <3C7C1B07.92F9B8E0@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="++alDQ2ROsODg1x+"
Content-Disposition: inline
In-Reply-To: <3C7C1B07.92F9B8E0@zip.com.au>
User-Agent: Mutt/1.3.27i
X-Operating-System: debian SID Gnu/Linux 2.4.18 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--++alDQ2ROsODg1x+
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2002 at 03:32:23PM -0800, Andrew Morton wrote:
> christophe barb=E9 wrote:
> >=20
> > Now that the forget_option bug is solved I have the following :
> >=20
> > Each time I suspend, the card resume in a bad state but return in a good
> > state after that :
> >=20
> > NETDEV WATCHDOG: eth0: transmit timed out
>=20
> The transceiver didn't power up, or came up in silly
> mode.  I'll see if I can reproduce any of this.
> What NIC are you using?
>=20

My card is a 3com Megahertz 10/100 model 3CCFE575CT

Could you give me a hint of where to look in the source or/and in the
output from my previous mail ? I would like to understand the problem.

Thanks,
Christophe

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

Dogs believe they are human. Cats believe they are God.

--++alDQ2ROsODg1x+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8fBx4j0UvHtcstB4RAtInAJwNPbvc4+gV1CyMxazDow2Gy4WpTwCeKBdS
z7sQvOWrl337p+QVyvLrqrM=
=IrtO
-----END PGP SIGNATURE-----

--++alDQ2ROsODg1x+--
