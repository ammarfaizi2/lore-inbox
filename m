Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261595AbTCGOBi>; Fri, 7 Mar 2003 09:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261596AbTCGOBi>; Fri, 7 Mar 2003 09:01:38 -0500
Received: from smtp4.clb.oleane.net ([213.56.31.20]:56716 "EHLO
	smtp4.clb.oleane.net") by vger.kernel.org with ESMTP
	id <S261595AbTCGOBg>; Fri, 7 Mar 2003 09:01:36 -0500
Subject: Re: 2.5.64p5 No USB support when APIC mode enabled
From: Nicolas Mailhot <Nicolas.Mailhot@one2team.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mMU5X8EQ4ndWvmOKCutH"
Organization: One2team
Message-Id: <1047046315.7172.8.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 07 Mar 2003 15:11:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mMU5X8EQ4ndWvmOKCutH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

|Alan Cox wrote :
|
|You need at least 2.4.21-pre5-ac, or 2.5.64-ac (I just sent Linus the
|relevant changes) to use APIC on the VIA chipset systems. You also need
|a BIOS with correct tables, which can also be a little tricky to find
|in uniprocessordom

Well, if it's the same bug as=20
http://bugzilla.kernel.org/show_bug.cgi?id=3D15,=20
I'm certainly seeing it also with 2.5.64-ac1. Old 2.4.-ac kernels used to b=
e
fine, I fear they have nowe been "fixed" to match 2.5.

Maybe you should be cc'd on this bug ?

|And Meino Christian Cramer replied :
|
| Therefore it seems that APIC is working with my VIA board without USB.
| But I cannot live without USB ... my mouse is USBish and X without a
| mouse is a little ... hmmm senseless.

Lucky you. I'm on a 100% hid input setup (mouse *and* keyboard), the=20
hardware is great on the kernels that support it, but is seems good
Linux support is not here yet:(.

Regards,

--=20
Nicolas Mailhot

--=-mMU5X8EQ4ndWvmOKCutH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+aKirmsj7VFSyrYsRAkPOAJ9GdPYavCl6oSKr3oam85OO3ZZDnQCcCXrN
n/DMMEvgiHvyw7EmtoT+Oeg=
=08U2
-----END PGP SIGNATURE-----

--=-mMU5X8EQ4ndWvmOKCutH--

