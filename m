Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbVBIVxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVBIVxV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 16:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVBIVxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 16:53:21 -0500
Received: from lug-owl.de ([195.71.106.12]:39865 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261938AbVBIVxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 16:53:08 -0500
Date: Wed, 9 Feb 2005 22:53:07 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Paulo Marques <pmarques@grupopie.com>, LKML <linux-kernel@vger.kernel.org>,
       Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>
Subject: Re: [RFC/RFT] [patch] Elo serial touchscreen driver
Message-ID: <20050209215307.GN10594@lug-owl.de>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	Paulo Marques <pmarques@grupopie.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>
References: <20050208164227.GA9790@ucw.cz> <420A0ECF.3090406@grupopie.com> <20050209170015.GC16670@ucw.cz> <20050209171438.GI10594@lug-owl.de> <20050209173026.GA17797@ucw.cz> <420A518A.9040500@grupopie.com> <20050209191817.GA1534@ucw.cz> <20050209200351.GK10594@lug-owl.de> <20050209201032.GA2159@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtBqmokgY1evbO3C"
Content-Disposition: inline
In-Reply-To: <20050209201032.GA2159@ucw.cz>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtBqmokgY1evbO3C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-02-09 21:10:32 +0100, Vojtech Pavlik <vojtech@suse.cz>
wrote in message <20050209201032.GA2159@ucw.cz>:
> On Wed, Feb 09, 2005 at 09:03:51PM +0100, Jan-Benedict Glaw wrote:
> > The problematic part is that this needs to be done at a quite low level,
> > since POS keyboards may send quite a lot more than make/break codes in
> > "proper" order...
>=20
> I'll need some specific examples of protocols the keyboard use to judge
> how to tackle that.

I'll try to get some showkeys dumps for you tomorrow. This will be sent
to you privately since it may contain real card data...

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

--vtBqmokgY1evbO3C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCCoZDHb1edYOZ4bsRAvWNAKCRHlz8MnPzEyAq3NuQF6FOhRVudgCgj7sQ
CF3R6UqiOwfWLNFZPxoJTeg=
=Wk8J
-----END PGP SIGNATURE-----

--vtBqmokgY1evbO3C--
