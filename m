Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267052AbTAPNAP>; Thu, 16 Jan 2003 08:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267059AbTAPNAP>; Thu, 16 Jan 2003 08:00:15 -0500
Received: from [212.59.36.210] ([212.59.36.210]:896 "HELO schottelius.net")
	by vger.kernel.org with SMTP id <S267052AbTAPNAO>;
	Thu, 16 Jan 2003 08:00:14 -0500
Date: Thu, 16 Jan 2003 09:37:16 +0100
From: Nico Schottelius <schottelius@wdt.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.4.21pre2 trident / ali5451
Message-ID: <20030116083716.GA859@schottelius.org>
References: <20021228021630.GA324@schottelius.org> <20030114231141.GF15211@fs.tum.de> <20030115133217.GA814@schottelius.org> <20030115222433.GR15211@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <20030115222433.GR15211@fs.tum.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux flapp 2.4.21-pre3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Adrian Bunk [Wed, Jan 15, 2003 at 11:24:34PM +0100]:
> On Wed, Jan 15, 2003 at 02:32:17PM +0100, Nico Schottelius wrote:
> >...
> > can you send me plain modified 2.4.20 trident.c, so I can simlpt insert=
 it
> > into 2.4.21pre3 ?
>=20
> Attached.

Actually this patch works pretty good in 2.4.21pre3!

I tried to port it to 2.5.58, but I don't know what changes where made
to the underlying sound architecture. (Means I failed to get it running in
2.5.58)

Greetings,

Nico

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+Jm88tnlUggLJsX0RAsv8AJ0QY2U8DINz6cWZoFllfCAXlu7HwQCghFUI
oJ55MTgg1RuLL+bnEJ9StFY=
=RCm0
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
