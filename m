Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbTGHOag (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 10:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTGHOag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 10:30:36 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:2308 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263275AbTGHOae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 10:30:34 -0400
Date: Tue, 8 Jul 2003 16:45:10 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linksys gpl code [OT]
Message-ID: <20030708144509.GE20605@lug-owl.de>
Mail-Followup-To: Kernel <linux-kernel@vger.kernel.org>
References: <1057663858.3959.41.camel@miyazaki>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
Content-Disposition: inline
In-Reply-To: <1057663858.3959.41.camel@miyazaki>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-07-08 12:30:58 +0100, Matthew Hall <matt@ecsc.co.uk>
wrote in message <1057663858.3959.41.camel@miyazaki>:
> Hi lkml,
> 	I don't know if anyone's noticed, but Linksys have opened up and
> released their code.
>=20
> http://www.linksys.com/support/gpl.asp
>=20
> Don't know if it satisfies the gpl; i'm currently downloading the stuff
> to see what's different from the release sources.

I downloaded that kernel.tgz and diff'ed it out - it's a *hugh* patch
removing tons of comments and #if 0 ... #endif parts. That makes it
more complicated to find the "interesting" parts for us, but also it
will get hard for them to ever port that changes over to 2.4.current...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Ctj1Hb1edYOZ4bsRAmxSAJ9q3zWaLx0SObQEwie/RiJijosE+QCcDIjE
/fYvgcuc1t1tOs9YICQokSw=
=Duub
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--
