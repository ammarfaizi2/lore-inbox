Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbVHMKTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbVHMKTV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 06:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVHMKTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 06:19:21 -0400
Received: from lug-owl.de ([195.71.106.12]:14729 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751154AbVHMKTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 06:19:20 -0400
Date: Sat, 13 Aug 2005 12:19:15 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Cc: "P.Manohar" <pmanohar@lantana.cs.iitm.ernet.in>
Subject: Re: starting a user defined daemon at linux startup.
Message-ID: <20050813101914.GD2382@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	"P.Manohar" <pmanohar@lantana.cs.iitm.ernet.in>
References: <Pine.LNX.4.60.0508041317360.5451@lantana.cs.iitm.ernet.in> <7d15175e05080403145a151b79@mail.gmail.com> <Pine.LNX.4.60.0508131537410.14649@lantana.cs.iitm.ernet.in>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0508131537410.14649@lantana.cs.iitm.ernet.in>
X-Operating-System: Linux mail 2.6.12.3lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-08-13 15:42:37 +0530, P.Manohar <pmanohar@lantana.cs.iitm.erne=
t.in> wrote:
> Hai
>   I want to start a daemon at startup in linux.
> I came to know that we need to put a script into /etc/rc.d/init.d/
> similar to sshd or atd. Do we need to write a script to run my daemon?

This isn't exactly a Linux kernel-related question, but to answer it
anyways: that's the way to go.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC/ckiHb1edYOZ4bsRAi50AJ4k6Z8PP7WHROqbyIt0GkMLss/0uACbBHwX
zn0kZqY3lIrG0EGaCEY5uNE=
=W+BZ
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
