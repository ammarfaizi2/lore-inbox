Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311630AbSCTPBl>; Wed, 20 Mar 2002 10:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311631AbSCTPBb>; Wed, 20 Mar 2002 10:01:31 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:9124 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S311630AbSCTPBP>; Wed, 20 Mar 2002 10:01:15 -0500
Date: Wed, 20 Mar 2002 10:02:29 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: alternative linux configurator prototype v0.2
Message-ID: <20020320150228.GP29518@ufies.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020319202101.GM29518@ufies.org> <Pine.LNX.4.21.0203201327490.19384-100000@serv>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xb8pJpF45Qg/t7GZ"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: debian SID Gnu/Linux 2.4.18 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Xb8pJpF45Qg/t7GZ
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2002 at 01:35:21PM +0100, Roman Zippel wrote:
> > Don't expect from me (and others I guess) to install the qt2 libs to
> > configure my kernel.
>=20
> I'm curious, is python+tk any better/worse?

Definetely worse but because of python but you know that already.
I have had a look at libqt2 which is 2MB.
It's not a problem if you provide a menuconfig like functionnality.

> > Is there a clear separation between GUI and other code ?
>=20
> Yes, although the interface needs some cleanup (and documentation).

Ok I understand that you are at the prototype stage

> > Do you provide a oldconfig-like functionnality ?
>=20
> Yes, and it's in plain C.

Cool.

Do you take into account in your design that 2.6 will be (perhaps) a
kernel with everything in module ?

Christophe

>=20
> bye, Roman
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

L'experience, c'est une connerie par jour mais jamais la m=EAme.

--Xb8pJpF45Qg/t7GZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8mKSEj0UvHtcstB4RAj1oAKCbd428hEI2x5AX+scmekQ1gd9N6ACfcu3U
IWqdIduxI1Lg17ePsPsahiM=
=5CxT
-----END PGP SIGNATURE-----

--Xb8pJpF45Qg/t7GZ--
