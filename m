Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263234AbTDLK6M (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 06:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263235AbTDLK6M (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 06:58:12 -0400
Received: from pfepc.post.tele.dk ([193.162.153.4]:43583 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S263234AbTDLK6L (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 06:58:11 -0400
Subject: Re: Booting Problems in the 2.5 series!
From: Mads Christensen <mfc@krycek.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1050144042.11736.4.camel@krycek>
References: <1050144042.11736.4.camel@krycek>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5n6tvX4l0HPlCaeCygke"
Organization: krycek.org
Message-Id: <1050145786.11735.7.camel@krycek>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Apr 2003 13:09:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5n6tvX4l0HPlCaeCygke
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hey I figured it out @ help from crimsum

I didn't have the CONFIG_VT=3Dy and CONFIG_INPUT=3Dy set=20
and i didn't have the new modutils for the 2.5 series installed!

Thx

On l=F8r, 2003-04-12 at 12:40, Mads Christensen wrote:
> Hello all!
>=20
> I was just wondering, do you have to do something magical to get the 2.5
> series booting, or is it just my debian thats fubar? :)
>=20
> I've tried 2.5.66 and 2.5.67 and they both halt on the initial line of
> booting - 'Booting Linux, Uncompressing something...' or something like
> that.
>=20
> My system is Debian SID
> Athlon 2800+
> 1gb mem and so forth and so forth although that shouldn't really matter
> that much
>=20
> Ohhh, and another question - Is it generally a good idea to use
> make-kpkg to compile the 2.5 series?
--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| Mads F. Christensen     || email:                                    |
| phone:  +45 27 47 58 66 || mfc@krycek.org                            |
| Webdesign Development   || www.krycek.org - personal data site       |
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


--=-5n6tvX4l0HPlCaeCygke
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+l/P644SvOSUXdFgRAoCkAKCwmRy1YHSrN0iUThLyOD0DMdlbcQCcDoyR
C2fGo7gmVHA0usM3Be4xKeY=
=Y5c9
-----END PGP SIGNATURE-----

--=-5n6tvX4l0HPlCaeCygke--

