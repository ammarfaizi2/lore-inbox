Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266938AbTCDXRS>; Tue, 4 Mar 2003 18:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266952AbTCDXRS>; Tue, 4 Mar 2003 18:17:18 -0500
Received: from coruscant.franken.de ([193.174.159.226]:18896 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S266938AbTCDXRQ>; Tue, 4 Mar 2003 18:17:16 -0500
Date: Wed, 5 Mar 2003 00:27:38 +0100
From: Harald Welte <laforge@netfilter.org>
To: Dominik Kubla <dominik@kubla.de>
Cc: David =?iso-8859-1?Q?Lagani=E8re?= <spanska@securinet.qc.ca>,
       linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: A suggestion for the netfilter part of the sources
Message-ID: <20030304232738.GS4880@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Dominik Kubla <dominik@kubla.de>,
	David =?iso-8859-1?Q?Lagani=E8re?= <spanska@securinet.qc.ca>,
	linux-kernel@vger.kernel.org,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>
References: <3E64E1C8.9040309@securinet.qc.ca> <20030304182006.GI4880@sunbeam.de.gnumonks.org> <200303042356.56722.dominik@kubla.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IoFIGPN1N3g1Ryqz"
Content-Disposition: inline
In-Reply-To: <200303042356.56722.dominik@kubla.de>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux sunbeam 2.4.20-nfpom
X-Date: Today is Pungenday, the 63rd day of Chaos in the YOLD 3169
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IoFIGPN1N3g1Ryqz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2003 at 11:56:42PM +0100, Dominik Kubla wrote:
=20
> Since this is meant to be tunable, how about turning it into a configurat=
ion=20
> option (with 8 being the default)? I guess that would solve this problem=
=20
> quite nicely.

well, if you think the 'netfilter configuration' submenu doesn't already
have enough config options ;)

SCNR.

Anyway, yes, this would be acceptable.  Patches are welcome, otherwise
it will end up on my TODO list.

> Regards,
>   Dominik

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--IoFIGPN1N3g1Ryqz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+ZTZqXaXGVTD0i/8RAqavAJ9gsHMVN5T83jM09/rqjsvVo+uO7gCdEFYd
f6JI+xIaNhJVgT4H8Ii2JrM=
=cJep
-----END PGP SIGNATURE-----

--IoFIGPN1N3g1Ryqz--
