Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265181AbTIDOzU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 10:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265208AbTIDOzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 10:55:19 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:2967 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265181AbTIDOzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 10:55:00 -0400
Date: Thu, 4 Sep 2003 16:54:57 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       campbell@torque.net
Subject: Re: 2.6.0-test4-mm5: SCSI imm driver doesn't compile
Message-ID: <20030904145457.GU14376@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
	campbell@torque.net
References: <20030902231812.03fae13f.akpm@osdl.org> <20030903170256.GA18025@fs.tum.de> <20030904133056.GA2411@conectiva.com.br> <20030904135256.GS14376@lug-owl.de> <20030904153023.A32549@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="REpkP7z4J/KxIT5U"
Content-Disposition: inline
In-Reply-To: <20030904153023.A32549@infradead.org>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--REpkP7z4J/KxIT5U
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-09-04 15:30:23 +0100, Christoph Hellwig <hch@infradead.org>
wrote in message <20030904153023.A32549@infradead.org>:
> On Thu, Sep 04, 2003 at 03:52:56PM +0200, Jan-Benedict Glaw wrote:
> > C99 style is
> >=20
> > 	.element =3D initializer,
> >=20
> > not
> > 	[element] =3D initializer,
> >=20
> > which is a GNU/GCCism.
>=20
> We're talking about arrays here..

*plonk* I stand corrected... I'm sorry...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--REpkP7z4J/KxIT5U
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/V1JBHb1edYOZ4bsRAl+nAKCGJ6NkVZ/HnCPIe001KCJjJOw8GgCdFIaW
y9ASpiNMGC4TlYwRUIhDpFk=
=D/RB
-----END PGP SIGNATURE-----

--REpkP7z4J/KxIT5U--
