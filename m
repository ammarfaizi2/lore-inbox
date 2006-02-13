Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbWBMApP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWBMApP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 19:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWBMApP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 19:45:15 -0500
Received: from 63.15.233.220.exetel.com.au ([220.233.15.63]:57489 "EHLO
	sydlxfw01.samad.com.au") by vger.kernel.org with ESMTP
	id S1751504AbWBMApO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 19:45:14 -0500
Date: Mon, 13 Feb 2006 11:44:37 +1100
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: dhazelton@enter.net, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060213004437.GJ26235@samad.com.au>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	dhazelton@enter.net, peter.read@gmail.com, mj@ucw.cz,
	matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
	jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
References: <20060208162828.GA17534@voodoo> <20060210114721.GB20093@merlin.emma.line.org> <43EC887B.nailISDGC9CP5@burner> <200602090757.13767.dhazelton@enter.net> <43EC8F22.nailISDL17DJF@burner>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XigHxYirkHk2Kxsx"
Content-Disposition: inline
In-Reply-To: <43EC8F22.nailISDL17DJF@burner>
User-Agent: Mutt/1.5.11
From: Alexander Samad <alex@samad.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XigHxYirkHk2Kxsx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2006 at 02:03:30PM +0100, Joerg Schilling wrote:
> "D. Hazelton" <dhazelton@enter.net> wrote:
>=20
> > And does cdrecord even need libscg anymore? From having actually gone t=
hrough=20
> > your code, Joerg, I can tell you that it does serve a larger purpose. B=
ut at=20
> > this point I have to ask - besides cdrecord and a few other _COMPACT_ _=
DISC_=20
> > writing programs, does _ANYONE_ use libscg? Is it ever used to access a=
ny=20
> > other devices that are either SCSI or use a SCSI command protocol (like=
=20
> > ATAPI)?  My point there is that you have a wonderful library, but despi=
te=20
> > your wishes, there is no proof that it is ever used for anything except=
=20
> > writing/ripping CD's.
>=20
> Name a single program (not using libscg) that implements user space SCSI =
and runs=20
> on as many platforms as cdrecord/libscg does.

Isnt this like saying why do we need windows server software when we
have Novell running most of the worlds server and again why do we need
linux when we have Microsoft running a majourity of the worlds servers.

Why cause we evolve we try to make things better, natural evolution


>=20
> J?rg
>=20
> --=20
>  EMail:joerg@schily.isdn.cs.tu-berlin.de (home) J?rg Schilling D-13353 Be=
rlin
>        js@cs.tu-berlin.de                (uni) =20
>        schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogs=
pot.com/
>  URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/s=
chily
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--XigHxYirkHk2Kxsx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD79Z1kZz88chpJ2MRAmJSAKCucgJf1phSPj9SEZcvi58UK2F37wCffIaR
bxa1/Gw6CMheAckJ0hlwn3g=
=Q9+t
-----END PGP SIGNATURE-----

--XigHxYirkHk2Kxsx--
