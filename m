Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263977AbTBSTpl>; Wed, 19 Feb 2003 14:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263991AbTBSTpl>; Wed, 19 Feb 2003 14:45:41 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:4114 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S263977AbTBSTpk>;
	Wed, 19 Feb 2003 14:45:40 -0500
Date: Wed, 19 Feb 2003 20:55:43 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.61 (Yes, there are still Alpha users out there. :-) )
Message-ID: <20030219195543.GW351@lug-owl.de>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	linux-kernel@vger.kernel.org
References: <20030217212922.GD351@lug-owl.de> <Pine.LNX.3.96.1030219123109.10611A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4n3ekn15JG+S0x0c"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030219123109.10611A-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4n3ekn15JG+S0x0c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-02-19 13:00:39 -0500, Bill Davidsen <davidsen@tmr.com>
wrote in message <Pine.LNX.3.96.1030219123109.10611A-100000@gatekeeper.tmr.=
com>:
> On Mon, 17 Feb 2003, Jan-Benedict Glaw wrote:
> > On Mon, 2003-02-17 10:39:38 -0500, Fred K Ollinger <follinge@sas.upenn.=
edu>
> > wrote in message <Pine.GSO.4.51.0302171039160.13696@mail2.sas.upenn.edu=
>:
> > > What version of modutils was installed?
> >=20
> > For recent 2.5.x kernels, you don't any longer need modutils. There was
> > a major rewrite of all module related code which requires new tools.
> > These are called "module-init-tools", my distribution has got a package
> > for it (with the same name). If you cannot get that brand new software
> > from your distributor, look at
> > ftp://ftp.kernel.org/pub/linux/kernel/people/people/rusty/modules/ .
>=20
> Be aware that for Redhat and SuSE distributions (and mandrake??) "make
> install" will fail because mkinitrd doesn't know about the new modules
> format.
>=20
> So you can give up using modules for anything you want to use to boot,

Which is what I prefer - I personally don't like initrd and I don't use
it.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet!
   Shell Script APT-Proxy: http://lug-owl.de/~jbglaw/software/ap2/

--4n3ekn15JG+S0x0c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+U+E/Hb1edYOZ4bsRApLjAKCLzlycl7nNcNAjjZFfFkhxOhF5JACghKjs
CfWKXe7MLOyT0tXjozQyeOE=
=nW1T
-----END PGP SIGNATURE-----

--4n3ekn15JG+S0x0c--
