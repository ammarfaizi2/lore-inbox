Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288925AbSAYEkS>; Thu, 24 Jan 2002 23:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290548AbSAYEkJ>; Thu, 24 Jan 2002 23:40:09 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:32398 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S288925AbSAYEj4>; Thu, 24 Jan 2002 23:39:56 -0500
Date: Thu, 24 Jan 2002 23:39:50 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: usb or video4linux problem
Message-ID: <20020125043949.GC671@online.fr>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020125032857.GA671@online.fr> <20020125041226.GA22366@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline
In-Reply-To: <20020125041226.GA22366@kroah.com>
User-Agent: Mutt/1.3.26i
X-Operating-System: debian SID Gnu/Linux 2.4.17 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2002 at 08:12:26PM -0800, Greg KH wrote:
> On Thu, Jan 24, 2002 at 10:28:57PM -0500, christophe barb=E9 wrote:
> >=20
> > I'm convinced that it's a problem with OHCI.
> > I think it's a soft problem because I can trigger it with cpu/io
> > activity.
>=20
> Does the kernel log show any USB errors, or any USB messages at all?

No message at all and the usb debug kernel option is on.

> What kernel version are you using?

2.4.17

>=20
> thanks,

Remember that I see a (I believe related) problem with the usb mouse.
Suddenly I can't use it. Switching on the console and then back to X
give me the mouse back.

Christophe

> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

Thousands of years ago, cats were worshipped as gods.
Cats have never forgotten this. --Anonymous

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8UOGVj0UvHtcstB4RAubMAKCJo6QQHE+mHScjmxp65lvZSGaA0ACgljcH
chhqPtM32i5MimSzsbf723E=
=taVF
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
