Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317859AbSGaIqA>; Wed, 31 Jul 2002 04:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317860AbSGaIqA>; Wed, 31 Jul 2002 04:46:00 -0400
Received: from fw.2d3d.co.za ([66.8.28.230]:9604 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S317859AbSGaIp7>;
	Wed, 31 Jul 2002 04:45:59 -0400
Date: Wed, 31 Jul 2002 10:53:13 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Abraham vd Merwe <abraham@2d3d.co.za>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: questions about network device drivers
Message-ID: <20020731105313.A9376@crystal.2d3d.co.za>
Mail-Followup-To: Russell King <rmk@arm.linux.org.uk>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Abraham vd Merwe <abraham@2d3d.co.za>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <20020730161505.A23281@crystal.2d3d.co.za> <1028044126.6726.35.camel@irongate.swansea.linux.org.uk> <3D46A8AB.4030308@mandrakesoft.com> <20020730160450.A7677@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020730160450.A7677@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Tue, Jul 30, 2002 at 16:04:50 +0100
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.17-pre4 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 10:44am  up 16:00, 10 users,  load average: 0.09, 0.05, 0.01
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Russell!

> > (lots of useful information)
>=20
> Any chance of updating Documentation/networking/driver.txt to include
> this useful information (even if its just appending the email from Alan
> and yourself?)  I was looking for this information recently as well.

I'm putting together a few notes on this and other network driver related
things. Will post a patch soon...

--=20

Regards
 Abraham

Unprovided with original learning, unformed in the habits of thinking,
unskilled in the arts of composition, I resolved to write a book.
		-- Edward Gibbon

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Aintree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9R6V5zNXhP0RCUqMRAq6AAJsEW4SiQkrQAfKTgwQKmmojFwZv+QCfT5bc
vzrvIBy+utUZqNVt0+lwTB8=
=lGiL
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
