Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287907AbSATDo3>; Sat, 19 Jan 2002 22:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287865AbSATDoU>; Sat, 19 Jan 2002 22:44:20 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:29649 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S287881AbSATDoH>; Sat, 19 Jan 2002 22:44:07 -0500
Date: Sat, 19 Jan 2002 22:43:33 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rm-ing files with open file descriptors
Message-ID: <20020120034333.GA13588@online.fr>
Mail-Followup-To: Kai Henningsen <kaih@khms.westfalen.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020119041857.GA10795@storm.local> <87lmevjrep.fsf@localhost.localdomain> <20020119041857.GA10795@storm.local> <20020119145132.GA972@online.fr> <8HBE2ej1w-B@khms.westfalen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <8HBE2ej1w-B@khms.westfalen.de>
User-Agent: Mutt/1.3.25i
X-Operating-System: debian SID Gnu/Linux 2.4.17 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 19, 2002 at 08:01:00PM +0200, Kai Henningsen wrote:
> christophe.barbe.ml@online.fr (christophe barb?)  wrote on 19.01.02 in <2=
0020119145132.GA972@online.fr>:
>=20
> > On Sat, Jan 19, 2002 at 05:18:57AM +0100, Andreas Bombe wrote:
> > > Whether that was an intended or accidental feature only someone with
> > > more insight into Unix history can answer.  It's that feature that le=
ts
> > > us do live upgrades of distributions without rebooting (executables a=
nd
> > > libraries can be replaced without affecting the currently running
> > > processes), at the very least much easier than it would be without th=
is
> > > behaviour.
> >
> > I remember that previous debian release come with a patched kernel to
> > allow live upgrade. It was explained in the FAQ that the patch was
> > required for this purpose.
>=20
> Complete and utter bullshit. This was never true, and the FAQ never =20
> claimed this.
>=20
> >    7.2 Debian claims to be able to update a running program;
> >       how is this accomplished?
>=20
> ... under which was originally explained how running demons would be =20
> restarted, and later it was also mentioned that replacing in-use files is=
 =20
> possible under Unix. Nothing more. (Google groups will happily find those=
 =20
> versions, they were in use from 1996 to 2001 according to the archive.)
>=20
> > What was in this patch?
>=20
> The patch only exists in your fantasy.

Ok you are right. I've checked old versions of this FAQ and this patch
only exists in my fantasy.

I take your 'Complete and utter bullshit' comment as a debian compliment
and not as an insult.

Christophe

>=20
> MfG Kai
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

Ce que l'on con=E7oit bien s'=E9nonce clairement,
Et les mots pour le dire arrivent ais=E9ment.
   Nicolas Boileau, L'Art po=E9tique

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8Sjzkj0UvHtcstB4RAjx8AKCfhVa90W2Bxa9J47bgrHHprGeEBQCgjOi8
fGFTJYYJQ+wVY9onfFL/uhM=
=0zxr
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
