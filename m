Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317845AbSFNI5r>; Fri, 14 Jun 2002 04:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317857AbSFNI5q>; Fri, 14 Jun 2002 04:57:46 -0400
Received: from fw.2d3d.co.za ([66.8.28.230]:5317 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S317845AbSFNI5o>;
	Fri, 14 Jun 2002 04:57:44 -0400
Date: Fri, 14 Jun 2002 10:59:19 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Nick Evgeniev <nick@octet.spb.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.19-preX IDE bugs
Message-ID: <20020614105919.A18127@crystal.2d3d.co.za>
Mail-Followup-To: Andre Hedrick <andre@linux-ide.org>,
	Vojtech Pavlik <vojtech@suse.cz>, Nick Evgeniev <nick@octet.spb.ru>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020614103746.A324@ucw.cz> <Pine.LNX.4.10.10206140140040.21513-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.17-pre4 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 10:56am  up 6 days, 22:49, 10 users,  load average: 0.01, 0.02, 0.00
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andre!

> > > http://www.tecchannel.de/hardware/817/index.html
> > >=20
> > > Read about the JUNK hardware base you are working with.
> > > This is one of the reasons people avoid VIA.
> >=20
> > Hmm, I don't want to interfere in this nicely-growing flamethrowing, but
> > Andre, you might have noticed, that Nick is saying that it actually
> > *works* on the VIA controller and doesn't on the Promise one. Plus older
> > kernels do work on the Promise controller. That's clearly a software
> > problem.
>=20
> Well if you have not read, I offered to export the changes to the kernel
> he states works as a way to isolate the driver from other changes.
> We have Promise adding their two cents, also.
>=20
> How about you rewriting the driver an take my name out of it too.
> Then you can have all the credit be yours.

Maybe I shouldn't stick my nose into this, but Andre, you've really got to
work on that attitude man. Sarcastic responses are only amusing for so
long...

--=20

Regards
 Abraham

The reason they're called wisdom teeth is that the experience makes you wis=
e.

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Aintree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--huq684BweRXVnRxX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9CbBnzNXhP0RCUqMRArvpAKCMy0cDvTFIDszfpQvoG0aQzzqNrgCfe2zz
KgZsby1FMiBdQDlPDB3qRcY=
=/Tw5
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
