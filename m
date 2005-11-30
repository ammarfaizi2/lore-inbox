Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbVK3JF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbVK3JF6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 04:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbVK3JF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 04:05:58 -0500
Received: from lug-owl.de ([195.71.106.12]:52676 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751153AbVK3JF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 04:05:57 -0500
Date: Wed, 30 Nov 2005 10:05:53 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH 2.6.15-rc2-git6] Fix tar-pkg target
Message-ID: <20051130090553.GR13985@lug-owl.de>
Mail-Followup-To: Brian Gerst <bgerst@didntduck.org>,
	Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
	Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
References: <20051128170414.GA10601@harddisk-recovery.nl> <20051129133042.6d344110.akpm@osdl.org> <20051129203622.GA17053@mars.ravnborg.org> <438D3982.2020000@didntduck.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qOEfHYdX8LquYLAx"
Content-Disposition: inline
In-Reply-To: <438D3982.2020000@didntduck.org>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qOEfHYdX8LquYLAx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-11-30 00:32:50 -0500, Brian Gerst <bgerst@didntduck.org> wrote:
> Sam Ravnborg wrote:
> >>I already have the below queued up, which is a bit different.  Does it=
=20
> >>work
> >>OK?
> >
> >Brian's version preserve EXTRANAME, but I have not seen it
> >used/documented anywhere?
>=20
> Can probably get rid of EXTRANAME, unless it is meant to be set from the=
=20
> environment/cmdline.  I can't find any other reference to it.

Exactly that was IIRC the intention when this came in. I'm fine with
removing it.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--qOEfHYdX8LquYLAx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDjWtxHb1edYOZ4bsRAp7kAJ9NWdpvlb5J5T/6Dj+zYi0N5nT3iwCfWHvG
RvcvZXS+muFipj7lJlecTh4=
=dg7o
-----END PGP SIGNATURE-----

--qOEfHYdX8LquYLAx--
