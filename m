Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262976AbTCWInu>; Sun, 23 Mar 2003 03:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262977AbTCWInu>; Sun, 23 Mar 2003 03:43:50 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:25101 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S262976AbTCWIns>;
	Sun, 23 Mar 2003 03:43:48 -0500
Date: Sun, 23 Mar 2003 09:54:53 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Cc: meyers_j@freeshell1.65535.net
Subject: Re: sound card
Message-ID: <20030323085453.GN22528@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	meyers_j@freeshell1.65535.net
References: <Pine.LNX.4.44.0303230840001.25376-100000@rimmer.65535.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MdEjg5WkSuUg8x46"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303230840001.25376-100000@rimmer.65535.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MdEjg5WkSuUg8x46
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-03-23 08:43:40 +0000, meyers_j@freeshell1.65535.net <meyers_j@=
freeshell1.65535.net>
wrote in message <Pine.LNX.4.44.0303230840001.25376-100000@rimmer.65535.net=
>:
> I don't know exactly which  card is on my friends board

Oh, come on. Is it onboard? Is it an add-on card? What does "lspci" tell
you? What mainboard is it? Please, if there's no other way, take a
screwdriver and have a look. If you fail to guess (looking at your
friend's machine), how can you expect us to correctly guess? And guess -
your question is most probably also off-topic...

> i thought it is soundblaster and tried ioport=3D0x220 which i found on the
> net.But it didn't work.SO is there any way of finding the address ?
> or any list to guess 0x230 etc

Just out of the courious, if that's a "modern" (read: inexpensive
mass-marked) computer, then it's most probable a SB Live (emu10k) or an
AC97 based codec. Google for that, but first look at "lspci" output.
It's most probably there...

> pnpdump shows

Are you *sure* this sound card is an ISA add-on card or ISA-based
connected to your friend's box? Most probably not...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--MdEjg5WkSuUg8x46
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+fXZcHb1edYOZ4bsRAlaWAJ0aHjBRHR0nwWw7k0fswHETzXcWtgCgkt9H
+Z7fKWBuXUOyctd3w+Q+lR8=
=BhQm
-----END PGP SIGNATURE-----

--MdEjg5WkSuUg8x46--
