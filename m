Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbTDKU41 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 16:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbTDKU41 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 16:56:27 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:37130 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S261651AbTDKU4Z (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 16:56:25 -0400
Date: Fri, 11 Apr 2003 23:08:09 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel hcking
Message-ID: <20030411210808.GT5242@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030411170709.A33459@freebsdcluster.dk> <200304111524.h3BFObYL001454@81-2-122-30.bradfords.org.uk> <20030411153711.GE25862@wind.cocodriloo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mW9eGbZzDIYYWqGs"
Content-Disposition: inline
In-Reply-To: <20030411153711.GE25862@wind.cocodriloo.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mW9eGbZzDIYYWqGs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-04-11 17:37:11 +0200, Antonio Vargas <wind@cocodriloo.com>
wrote in message <20030411153711.GE25862@wind.cocodriloo.com>:
> On Fri, Apr 11, 2003 at 04:24:37PM +0100, John Bradford wrote:
> > > Also every time you makes changes in the kernel it must be hell to
> > > recompile the whole thing
> >=20
> > If you are testing kernels on a separate machine to the one you are
> > compiling on, and therefore not rebooting, it's not much of a problem
> > - with enough RAM, most or all of the kernel source will be cached,
> > and you can compile a kernel in three to five minutes on a fast
> > machine.
>=20
> John, you mean a "make clean && make bzImage" takes you only about 4
> minutes??? I would like to know more details about .config, machine
> specs, compiler and so on :)

Um, take 1.5GB RAM and one of those dual athlon boards and you'll even
do a full compile in <5min...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--mW9eGbZzDIYYWqGs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+ly64Hb1edYOZ4bsRAlT6AJ9+RReOxV/+58hH989pIuyl565fBwCdH67q
OX6LtvZqruIw+f2w1ZuFNcQ=
=kkBF
-----END PGP SIGNATURE-----

--mW9eGbZzDIYYWqGs--
