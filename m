Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261751AbTCQPrx>; Mon, 17 Mar 2003 10:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261754AbTCQPrx>; Mon, 17 Mar 2003 10:47:53 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:15114 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S261751AbTCQPrv>;
	Mon, 17 Mar 2003 10:47:51 -0500
Date: Mon, 17 Mar 2003 16:58:45 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: BK->CVS is live
Message-ID: <20030317155845.GH17073@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200303171552.h2HFqK907234@work.bitmover.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5uhzMJlTksuFv+PE"
Content-Disposition: inline
In-Reply-To: <200303171552.h2HFqK907234@work.bitmover.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5uhzMJlTksuFv+PE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-03-17 07:52:20 -0800, Larry McVoy <lm@bitmover.com>
wrote in message <200303171552.h2HFqK907234@work.bitmover.com>:
> I think those repositories are stable enough you can start to count on
> them.  Sam and others have looked over their changes and think that=20
> the CVS tree has accurate data.
>=20
> The CVS repository is at
>=20
>     cvs -d:pserver:anonymous@kernel.bkbits.net:/home/cvs
>=20
> and it has two top level directories, linux-2.4 and linux-2.5.

jbglaw@mirror:~$ rsync kernel.bkbits.net::
rsync: failed to connect to kernel.bkbits.net: Connection refused
rsync error: error in socket IO (code 10) at clientserver.c(83)

:-(

Allowing rsync on the repository could help people on slow links (modem)
esp. as CVS isn't exactly known to be fast and evvective. I'd love to
have it rsyncable (as we have it for mips-linux:-)

MfG, JBG


--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--5uhzMJlTksuFv+PE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+dfC1Hb1edYOZ4bsRAkGSAJ4uY3x091Qi7QaEbFplHYXT7N2vkwCffLRY
xiKE33oxFnZVNrwcszfDixc=
=Wm5m
-----END PGP SIGNATURE-----

--5uhzMJlTksuFv+PE--
