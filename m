Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262472AbSLOUb1>; Sun, 15 Dec 2002 15:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbSLOUb1>; Sun, 15 Dec 2002 15:31:27 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:6918 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S262472AbSLOUb0>;
	Sun, 15 Dec 2002 15:31:26 -0500
Date: Sun, 15 Dec 2002 21:39:20 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Machine Check Exception
Message-ID: <20021215203920.GO10774@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021215202227.GA7375@codeblau.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SlnaBQtdWG0gYnqZ"
Content-Disposition: inline
In-Reply-To: <20021215202227.GA7375@codeblau.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
x-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
x-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SlnaBQtdWG0gYnqZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2002-12-15 21:22:27 +0100, Felix von Leitner <felix-kernel@fefe.de>
wrote in message <20021215202227.GA7375@codeblau.de>:
> As soon as I start oggenc on my 2.5 kernel, I get this message:
>=20
>   CPU 0: Machine Check Exception: 0000000000000004
>   Bank 0: f60600000000135 at 000000001ea46db0
>   Kernel panic: CPU context corrupt
>=20
> This vc then hangs, but I could log in and write down the message on
> another vc.  Is this a hardware error?  Should I replace my CPU?  My
> memory?  Is my machine overheating?  I have had several strange and
> unexplained segfaults and reboots under 2.4 recently.

Probably you're suffering from bad RAM. Please create a memtest86 boot
floppy and try it in your own... Segfaults and reboots mostly are bad
CPU fans or bad RAM:-p

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet!
   Shell Script APT-Proxy: http://lug-owl.de/~jbglaw/software/ap2/

--SlnaBQtdWG0gYnqZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE9/Oh4Hb1edYOZ4bsRAu4DAJwLtaIfZGHQO63Q+SRfMDTeKxjdSACeNsmv
3b5hkVuOZd9xAe1g9e3RhyQ=
=j1p9
-----END PGP SIGNATURE-----

--SlnaBQtdWG0gYnqZ--
