Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272130AbRHVV0y>; Wed, 22 Aug 2001 17:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272129AbRHVV0f>; Wed, 22 Aug 2001 17:26:35 -0400
Received: from c1608841-a.fallon1.nv.home.com ([65.5.95.44]:36248 "EHLO
	tarot.internal.aom.geek") by vger.kernel.org with ESMTP
	id <S272121AbRHVV0d>; Wed, 22 Aug 2001 17:26:33 -0400
Date: Wed, 22 Aug 2001 14:26:36 -0700
To: Wakko Warner <wakko@animx.eu.org>
Cc: Luca Montecchiani <m.luca@iname.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [FAQ?] More ram=less performance (maximum cacheable RAM)
Message-ID: <20010822142636.B6809@ferret.dyndns.org>
In-Reply-To: <3B82B988.50DE308A@iname.com> <200108211957.f7LJvEt20846@vindaloo.ras.ucalgary.ca> <998430817.3139.41.camel@phantasy> <3B8350D3.CDE749E1@iname.com> <20010822071213.A9273@animx.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
In-Reply-To: <20010822071213.A9273@animx.eu.org>
User-Agent: Mutt/1.3.18i
From: idalton@ferret.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 22, 2001 at 07:12:13AM -0400, Wakko Warner wrote:
> > >=20
> > > It also has nothing to do with Linux.  Some motherboard's TAG RAM do =
not
> > > allow for caching more than xMB.
> >=20
> > I'm just proposing to update the FAQ to help people like me=20
> > that thinking to gain speed doubling the system ram have seen
> > a severe performance drop for certain task like compiling the=20
> > kernel .
> >=20
> > Answer :=20
> > It has nothing to do with Linux, maybe your motherboard's TAG Ram
> > do not allow for caching more than xMB.
>=20
> The bios has something to do with that as well.  I have a dual pentium
> machine at work that was really slow.  I looked in the bios and it has an
> option to cache 64mb or 512mb.  speed up my kernel compiles (2.2.x) by ab=
out
> 12 minutes.  (took 20, after the change, it took about 8)

Mine has this option, but kernel OOPSes with the option set to 512MB.
It's a TMC TD5TH. I've posted the OOPS before. I can post if anyone
wants to see it.

--=20
Ferret

I will be switching my email addresses from @ferret.dyndns.org to
@mail.aom.geek on or after September 1, 2001, but not until after
Debian's servers include support. 'geek' is an OpenNIC TLD. See
http://www.opennic.unrated.net for details about adding OpenNIC
support to your computer, or ask your provider to add support to
their name servers.

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7hCOMe0DNEkH06HMRAvE/AJ0dks5qCttLAuiouCcEoM1QQldT8QCeN1gi
0tXjhe96WLXDYfmJf+d/Udg=
=ONoF
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
