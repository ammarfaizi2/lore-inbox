Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276607AbRJCRjX>; Wed, 3 Oct 2001 13:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276601AbRJCRjN>; Wed, 3 Oct 2001 13:39:13 -0400
Received: from pscgate.progress.com ([192.77.186.1]:9195 "EHLO
	pscgate.progress.com") by vger.kernel.org with ESMTP
	id <S276607AbRJCRjD>; Wed, 3 Oct 2001 13:39:03 -0400
Subject: Re: [POT] Which journalised filesystem ?
From: "Sujal Shah" <sshah@progress.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20011003190315.G21866@emma1.emma.line.org>
In-Reply-To: <Pine.LNX.4.33L.0110030938130.4835-100000@imladris.rielhome.conectiva>
	<Pine.LNX.4.30.0110031448460.16788-100000@Appserv.suse.de> 
	<20011003190315.G21866@emma1.emma.line.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-rOTWRdgPaNdWsGf40jD5"
X-Mailer: Evolution/0.14.99+cvs.2001.09.30.08.08 (Preview Release)
Date: 03 Oct 2001 13:40:36 -0400
Message-Id: <1002130861.8159.64.camel@pcsshah>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rOTWRdgPaNdWsGf40jD5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2001-10-03 at 13:03, Matthias Andree wrote:
> On Wed, 03 Oct 2001, Dave Jones wrote:
>=20
> > Alan mentioned this was something to do with the IBM hard disk
> > having strange write-cache properties that confuse ext3.
>=20
> hdparm -W0 /dev/hda is your friend.

Dumb question: when would you want it to be -W1?

I mean, I can imagine maybe media recording or something where you might
*really* want the performance increase...  but generally speaking, I
want my data to be there in case things blow up.

does anyone know what the performance increase is?

Sujal

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
---- Sujal Shah ---- PSC Labs (Progress Software) ----=20

Now Playing: Ministry Of Sound - York - The Awakening

--=-rOTWRdgPaNdWsGf40jD5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA7u02UrdegDpOByoARAushAJ40Ri0qX0NcOzJ6wRl2OGP/68ckmACfVLaa
kT6BnsiPt0ztE8bE/3xCvUg=
=/bAs
-----END PGP SIGNATURE-----

--=-rOTWRdgPaNdWsGf40jD5--

