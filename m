Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265147AbRGANHM>; Sun, 1 Jul 2001 09:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265148AbRGANG7>; Sun, 1 Jul 2001 09:06:59 -0400
Received: from cdsl163.ptld.uswest.net ([209.180.170.163]:17270 "HELO
	knghtbrd.dyn.dhs.org") by vger.kernel.org with SMTP
	id <S265147AbRGANG3>; Sun, 1 Jul 2001 09:06:29 -0400
Date: Sun, 1 Jul 2001 06:07:38 -0700
From: Joseph Carter <knghtbrd@d2dc.net>
To: Guest section DW <dwguest@win.tue.nl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Mac USB keyboards (Was: USB Keyboard errors with 2.4.5-ac)
Message-ID: <20010701060738.A9682@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20010701132639.A27154@win.tue.nl>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux galen 2.4.3-ac12
X-No-Junk-Mail: Spam will solicit a hostile reaction, at the very least.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 01, 2001 at 01:26:39PM +0200, Guest section DW wrote:
> > > To understand the details of the code, trace the steps:
> > > (i)  The USB code can be found e.g. on
> > > 	http://www.win.tue.nl/~aeb/linux/kbd/scancodes-5.html
> > > We find that Power is 102 and that Keypad-=3D is 103.
> >=20
> > I find that KP =3D can also be 134, according to this.
>=20
> Yes. The USB spec says for this code: "used on AS/400 keyboards".

Probably not much chance this keyboard will be using it then.  Some AT
keyboards require some sort of magic enable string be sent to make them
use certain unusual keys in the manner you would expect.  Any chance of
that in the USB arena?  I'm just grasping at straws here, but I suppose
it's possible.

--=20
Joseph Carter <knghtbrd@d2dc.net>                   Free software developer

<Culus> OH MY GOD NOT A RANDOM QUOTE GENERATOR
<netgod> surely you didnt think that was static? how lame would that be?=20
         :-)


--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: 1024D/DCF9DAB3  20F6 2261 F185 7A3E 79FC  44F9 8FF7 D7A3 DCF9 DAB3

iEYEARECAAYFAjs/IJoACgkQj/fXo9z52rPa7wCaAy3r2ftGezVNbMzJGk1O99Yt
xuEAoKbd7KeXa/T8NwBe+b9gKSUbxZWe
=nrjT
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
