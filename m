Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289377AbSBSULd>; Tue, 19 Feb 2002 15:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289783AbSBSULZ>; Tue, 19 Feb 2002 15:11:25 -0500
Received: from c207-202-243-179.sea1.cablespeed.com ([207.202.243.179]:53593
	"EHLO darklands.localhost.localdomain") by vger.kernel.org with ESMTP
	id <S289377AbSBSULH>; Tue, 19 Feb 2002 15:11:07 -0500
Date: Tue, 19 Feb 2002 12:09:51 -0800
From: Thomas Zimmerman <thomas@zimres.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Ess Solo-1 interrupt behaviour
Message-ID: <20020219200951.GA6615@darklands.zimres.net>
Reply-To: Thomas <thomas@zimres.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E16d8GI-0000CS-00@the-village.bc.nu> <200202191412.g1JECvV12317@ibe.miee.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <200202191412.g1JECvV12317@ibe.miee.ru>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux darklands 2.4.18-darklands 
X-Operating-Status: 10:03:23 up 2 days, 6 min,  1 user,  load average: 0.56, 0.16, 0.05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19-Feb 05:12, Samium Gromoff wrote:
> "  Alan Cox wrote:"
> >=20
> > > > Thats an esd bug. ESD tries to use ridiculously small fragment sizes
> > > >=20
> > >   Wait, wait, but my ISA Vibra 16 generates 20+ times less interrupts=
, with the
> > >   _same_ esd!=20
> >=20
> > Yes. It has diff fragment limits
> >=20
> 	So the point is we should fix esd, not the solo-1 driver, i presume?
> 	(esd_fixed -> irq_load_fixed -> disk_io_is_back)... sounds ok
>=20
> 	EOT
>=20
> regards, Samium Gromoff

It would be EOT, but there don't seem to _be_ any esd developers. I'd take a
look but my C skills max out at about "hello world", and there wouldn't be
anyone to make a new release (google couldn't find a esd homepage at least).
Maybe the gnome/ximian folks are taking bug reports/fixes in their packages.
Who knows? This has come up several times with nary a peep from a esd
developer.

Thomas
--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8crEPUHPW3p9PurIRAkHKAJ4zcwDwPswioyTXeEDJqwhhbHB6LQCfZfDl
t1eg077rLw69AG/Ce2HyIdc=
=PvIL
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
