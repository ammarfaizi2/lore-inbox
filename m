Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261632AbTCTR70>; Thu, 20 Mar 2003 12:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261634AbTCTR70>; Thu, 20 Mar 2003 12:59:26 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:33297 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S261632AbTCTR7X>;
	Thu, 20 Mar 2003 12:59:23 -0500
Date: Thu, 20 Mar 2003 19:10:23 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Deprecating .gz format on kernel.org
Message-ID: <20030320181023.GI28454@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0303201138000.29061-100000@router.windsormachine.com> <3E79FFAD.3040904@inet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="je2i5r69C8+2chMc"
Content-Disposition: inline
In-Reply-To: <3E79FFAD.3040904@inet.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--je2i5r69C8+2chMc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-03-20 11:51:41 -0600, Eli Carter <eli.carter@inet.com>
wrote in message <3E79FFAD.3040904@inet.com>:
> Mike Dresser wrote:
> >On Thu, 20 Mar 2003, Jan-Benedict Glaw wrote:
> >
> >
> >>jbglaw@schnarchnase:/tmp$ cat /proc/cpuinfo
> >
> >
> >>bogomips        : 15.10
> >
> >
> >out of curiosity, how long does the machine take to compile a kernel?
> >
> >Do you use a stopwatch or a calendar?
>=20
> Well, going back to his original email,
>=20
> jbglaw@schnarchnase:/tmp$ uname -a
> Linux schnarchnase 2.5.65 #1 Thu Mar 20 07:39:11 CET 2003 i486 unknown=20
> unknown GNU/Linux
>=20
> And looking on kernel.org,
> Mar 17 22:29 linux-2.5.65.tar.gz
>=20
> It takes him less than a week anyway*... ;)  (Timezone conversions left=
=20
> as an exercise to the reader.)

Um, no. I compiled it on my Athlon (2x1.4GHz) and that's more like
5min... Letting the box compile a full 2.5.x (with mostly anything
useable choosen as a module), I think that would be at about 10..20 day.
So it's more like looking at a calendar than looking at a stopwatch:=3D

> So, who can beat his 15.10 bogomips?  Anyone run <1 bogomips?

No problem - start linux from within bochs:)
--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--je2i5r69C8+2chMc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+egQPHb1edYOZ4bsRAgfmAJoDUryuu11nlR9m5g6R4BV5wHYH6ACdHXCS
KcsgxJCSHifl/ssL3p1nITk=
=PbE0
-----END PGP SIGNATURE-----

--je2i5r69C8+2chMc--
