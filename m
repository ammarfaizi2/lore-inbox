Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318062AbSHQSM1>; Sat, 17 Aug 2002 14:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318064AbSHQSM0>; Sat, 17 Aug 2002 14:12:26 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:5643 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S318062AbSHQSM0>;
	Sat, 17 Aug 2002 14:12:26 -0400
Date: Sat, 17 Aug 2002 20:16:24 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE?
Message-ID: <20020817181624.GM10730@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.GSO.4.21.0208162057550.14493-100000@weyl.math.psu.edu> <Pine.LNX.4.44.0208161822130.1674-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z/kiM2A+9acXa48/"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208161822130.1674-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
x-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
x-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Z/kiM2A+9acXa48/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2002-08-16 18:35:29 -0700, Linus Torvalds <torvalds@transmeta.com>
wrote in message <Pine.LNX.4.44.0208161822130.1674-100000@home.transmeta.co=
m>:
> On Fri, 16 Aug 2002, Alexander Viro wrote:

>     - in particular, it would only bother with PCI (or better)=20
>       controllers, and with UDMA-only setups.
[...]
> And then in five years, in Linux-3.2, we might finally just drop support=
=20
> for the old IDE code with PIO etc. Inevitably some people will still use=
=20

That's bad. Then, you're nailed to use old kernels without having
possibilities of recent kernels only because you're working with eg. old
Alphas, PCMCIA-IDE things or so? Bad, bad, badhorribly bad. Even it's
sloooow, there'll always some need for PIO-only controller support...

MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--Z/kiM2A+9acXa48/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9XpL4Hb1edYOZ4bsRApB7AJ4pKacBxhIZpFCSdYh4fjNf6oOLXgCghRXE
Q4XBWDNzhvGo59BI4Z6mElc=
=Bp71
-----END PGP SIGNATURE-----

--Z/kiM2A+9acXa48/--
