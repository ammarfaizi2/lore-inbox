Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317283AbSHGHzK>; Wed, 7 Aug 2002 03:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317287AbSHGHzK>; Wed, 7 Aug 2002 03:55:10 -0400
Received: from fw.2d3d.co.za ([66.8.28.230]:46770 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S317283AbSHGHzJ>;
	Wed, 7 Aug 2002 03:55:09 -0400
Date: Wed, 7 Aug 2002 10:02:34 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ethtool documentation
Message-ID: <20020807100234.B9263@crystal.2d3d.co.za>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33L2.0208060834030.10089-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L2.0208060834030.10089-100000@dragon.pdx.osdl.net>; from rddunlap@osdl.org on Tue, Aug 06, 2002 at 08:41:13 -0700
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.17-pre4 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 9:37am  up 7 days, 14:53, 10 users,  load average: 0.05, 0.01, 0.00
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Randy!

> | Wouldn't it have been better to make this 'n character device which can
> | be read from / written to just like a normal file (/dev/nvram-like
> | interface) -
> | that way applications can actually use unused eeprom space.
>=20
> I wouldn't care for this.  There's nothing 'normal' about this
> EEPROM space, and apps generally won't know where there might be
> some 'unused eeprom space'.

That's not true. Sure, it may not be useful in your average setup, but there
are some cases where it might be useful, e.g. in embedded systems.

--=20

Regards
 Abraham

Faith is under the left nipple.
		-- Martin Luther

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Aintree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9UNQazNXhP0RCUqMRAt3oAJ9gop4dUI8fGZ9rvnC7fmkyM3x1awCeOU14
F4NOqNyMc2oDO6fC/663pT8=
=mMHW
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
