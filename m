Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274225AbRISWU7>; Wed, 19 Sep 2001 18:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274226AbRISWUu>; Wed, 19 Sep 2001 18:20:50 -0400
Received: from mail.direcpc.com ([198.77.116.30]:15298 "EHLO
	postoffice2.direcpc.com") by vger.kernel.org with ESMTP
	id <S274225AbRISWUj>; Wed, 19 Sep 2001 18:20:39 -0400
Subject: Re: 2.4 Success story
From: Jeffrey Ingber <jhingber@ix.netcom.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20010919193341.B527@dardhal.mired.net>
In-Reply-To: <20010918192003.5C326783ED@mail.clouddancer.com> 
	<20010919193341.B527@dardhal.mired.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-AFo6WoBAQYsVFXWbHK+6"
X-Mailer: Evolution/0.13.99+cvs.2001.09.18.07.08 (Preview Release)
Date: 19 Sep 2001 18:23:49 -0400
Message-Id: <1000938233.2152.10.camel@DESK-2>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AFo6WoBAQYsVFXWbHK+6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I agree.  This is a fantastic kernel - so good infact, it'll probably be
awhile before I try out a new one unless some other issue(s) comes up.=20
I had a nagging problem with XF864 dying with Sig'11 on SMP and this has
completely cleared it up. =20

There's probably several issues with this kernel, but as the saying goes
'It works for me.'.  Excellent work.

Jeffrey H. Ingber (jhingber _at_ ix.netcom.com)


On Wed, 2001-09-19 at 15:33, Jos=E9 Luis Domingo L=F3pez wrote:
> On Tuesday, 18 September 2001, at 12:20:03 -0700,
> Colonel wrote:
>=20
> > A brief note of _thanks_ to all that create the linux kernel.
> > [...]
> > This particular gem of a kernel is:
> >=20
> > 2.4.9-ac10 #1 SMP Tue Sep 11 21:47:15 PDT 2001 i686
> >=20
> >From my particular experience with a couple of very low-end computers
> moderately loaded (mainly used as workstations) I can say that in _my_ ow=
n
> setup and hardware, memory management in 2.4.9-ac10 feels much better tha=
n
> 2.4.9's. In 2.4.9-ac10 I've been using:
> echo "1" > /proc/sys/vm/page_aging_tactic
>=20
> and the result is a much better behavior of the system. Now, with the sam=
e
> applications loaded, daily cron doesn't force all of my appliactions into
> swap (something 2.4.9 did). Now swap usage is much lower, the system seem=
s
> to have a faster response to user interaction than before and "swapoff" i=
s
> _much_ (maybe x10) faster than in 2.4.9.
>=20
> It seems that we are getting closer to a production-quality kernel :)
>=20
> --=20
> Jos=E9 Luis Domingo L=F3pez
> Linux Registered User #189436     Debian GNU/Linux Potato (P166 64 MB RAM=
)
> =20
> jdomingo EN internautas PUNTO org  =3D> =BF Spam ? Atente a las consecuen=
cias
> jdomingo AT internautas DOT   org  =3D> Spam at your own risk
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


--=-AFo6WoBAQYsVFXWbHK+6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA7qRr1aMTzuMuv5OERAk37AJ47PnUqU/g7WClDcazq9c0x2mzokACg9UWw
IQ9hUOc1qerL+0fmuMbEJfM=
=pPtf
-----END PGP SIGNATURE-----

--=-AFo6WoBAQYsVFXWbHK+6--

