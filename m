Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313564AbSDLMiy>; Fri, 12 Apr 2002 08:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313565AbSDLMix>; Fri, 12 Apr 2002 08:38:53 -0400
Received: from mail.2d3d.co.za ([196.14.185.200]:441 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S313564AbSDLMiq>;
	Fri, 12 Apr 2002 08:38:46 -0400
Date: Fri, 12 Apr 2002 14:39:09 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Josh Fryman <fryman@cc.gatech.edu>
Cc: linux@aerythmic.be, linux-kernel@vger.kernel.org
Subject: Re: Stolen Memory <- i830M video chip
Message-ID: <20020412143909.A17660@crystal.2d3d.co.za>
Mail-Followup-To: Josh Fryman <fryman@cc.gatech.edu>, linux@aerythmic.be,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204112244480.4745-100000@LiSa> <20020412094323.B8997@crystal.2d3d.co.za> <20020412073136.53e533ed.fryman@cc.gatech.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.17-pre4 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 2:35pm  up 16 days,  4:51, 12 users,  load average: 2.01, 0.71, 0.25
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Josh!

> > It is therefore a OEM BIOS problem. Dell was notified about this a long=
 time
> > ago - I thought they fixed it in the mean time. Try moaning about this =
to
> > Asus as well...
>=20
> this isn't fixed in the new dell C400 laptops (still).  however, i argue =
that
> BIOS problem or no, a solution _does_ exist.  there is a 3rd party that
> sells commercial X server drop-ins for new chipsets.  one of the guys here
> bought their X server for $40 or so, and now has full-color & -resolution=
=20
> without getting a BIOS update.
>=20
> so if it's a BIOS problem that can only be fixed by Dell, how were these =
guys
> able to do the fix?  and why can't the open source guys (XFree or Linux k=
ernel)=20
> seem to do the same?

*sigh* You're not listening to me. The _BIOS_ is the problem. If you don't
use the _BIOS_, you don't have a problem. We (2d3D, Inc. the people who
wrote the driver) are paid to use the BIOS. We have a non-bios setmode, but
were not using it because I'm not allowed to release that source.

I've told people before: If you want it to work, write a non-BIOS setmode.
I'll even give you tips if you try, but that is all I can do. Sorry, life is
tough.

--=20

Regards
 Abraham

Rules for Academic Deans:
	(1)  HIDE!!!!
	(2)  If they find you, LIE!!!!
		-- Father Damian C. Fandal

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Aintree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8ttVtzNXhP0RCUqMRAktJAJ9IoB9aBlRpjlUnTSldrtyvfG5Y6QCeMNy2
IwYu3F2ntZ73UTgfoDIqBdk=
=FVGB
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
