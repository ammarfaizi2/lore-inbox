Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbTLGOyi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 09:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264436AbTLGOyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 09:54:36 -0500
Received: from c-130372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.19]:52894
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S264434AbTLGOye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 09:54:34 -0500
Subject: Re: Catching NForce2 lockup with NMI watchdog - found?
From: Ian Kumlien <pomac@vapor.com>
To: Craig Bradney <cbradney@zip.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1070793169.2079.10.camel@athlonxp.bradney.info>
References: <1070739194.1985.4.camel@big.pomac.com>
	 <1070756427.2093.2.camel@athlonxp.bradney.info>
	 <1070756987.1987.7.camel@big.pomac.com>
	 <1070793169.2079.10.camel@athlonxp.bradney.info>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-runmvJ+Vpyxv3BlO0Eg9"
Message-Id: <1070808872.3213.10.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 07 Dec 2003 15:54:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-runmvJ+Vpyxv3BlO0Eg9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-12-07 at 11:32, Craig Bradney wrote:
> On Sun, 2003-12-07 at 01:29, Ian Kumlien wrote:
> > On Sun, 2003-12-07 at 01:20, Craig Bradney wrote:
> > > Correction? how so? code looks the same, although the line numbers ar=
e
> > > completely different for mpparse.c and at that location there is
> > > different code. (Havent checked the disconnect)
> >=20
> > this is for 2.4.23 =3D)
>=20
> duh.. ok :)

Since none of my 2.6 running computers can read from the cdrom i have
decided to leave this last one on 2.4 =3D)
=20
> > > Why do you think the disconnect is also related? (given some are just
> > > running the APIC patch and having (less/)no issues?
> >=20
> > Since i had issues with just the apic patch, as stated in my mail.
>=20
> oic.. sorry.. must have missed that.

Ok, i only got 2h uptime. But now i'm breaking the record with every
second that passes...
=20
> > > > Although i would prefer a not so workaroundish approach =3D)
> > >=20
> > > 23 hrs now..=20
> >=20
> > I'm at 5:06 and thats a record for it running with apic.
>=20
> 1d 9h here now..

19h 33m

> I remembered I also dont have preempt still, but I am happy with it if
> it stays like this. The next time I need to reboot (or get a hang), I'll
> recompile with preempt it and try again.

I'm more interested about getting NMI to work with io-apic right now, if
possible...

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-runmvJ+Vpyxv3BlO0Eg9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/0z8o7F3Euyc51N8RAuNyAKCcnTjGAI4z6Hjdl4GxLecBiKmCQACeOUd/
Ugh8xbsjoYePrUEMhQbSPGc=
=8Z7L
-----END PGP SIGNATURE-----

--=-runmvJ+Vpyxv3BlO0Eg9--

