Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVBIUJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVBIUJK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 15:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVBIUIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 15:08:02 -0500
Received: from lug-owl.de ([195.71.106.12]:30647 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261915AbVBIUGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 15:06:50 -0500
Date: Wed, 9 Feb 2005 21:06:46 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>
Subject: Re: [RFC/RFT] [patch] Elo serial touchscreen driver
Message-ID: <20050209200646.GL10594@lug-owl.de>
Mail-Followup-To: Paulo Marques <pmarques@grupopie.com>,
	Vojtech Pavlik <vojtech@suse.cz>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>
References: <20050208164227.GA9790@ucw.cz> <420A0ECF.3090406@grupopie.com> <20050209170015.GC16670@ucw.cz> <20050209171438.GI10594@lug-owl.de> <20050209173026.GA17797@ucw.cz> <420A518A.9040500@grupopie.com> <20050209191817.GA1534@ucw.cz> <420A6A5C.8030106@grupopie.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gS/sOEqITpbrYRmu"
Content-Disposition: inline
In-Reply-To: <420A6A5C.8030106@grupopie.com>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gS/sOEqITpbrYRmu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-02-09 19:54:04 +0000, Paulo Marques <pmarques@grupopie.com>
wrote in message <420A6A5C.8030106@grupopie.com>:
> >We could have a library that would do that and link applications against
> >it. It could also handle things like tap-n-drag, etc, something we
> >certainly don't want in the kernel.
>=20
> I really like this idea :)
>=20
> A libtouch library that handled calibration (this includes mirroring and=
=20
> swapping the coordinates) and other goodies (like filtering out short=20
> "touch release" events while dragging, etc.) would be a good standard=20
> interface for all applications.
>
> Being in user space would also mean that the library could do things=20
> like keeping a /etc/touch.conf file where it would read default=20
> calibration data, etc.

=2E..and for X11. Maybe we'd start talking about an API for this lib? At
least, my employer is interested I guess. (But this is OT wrt. the Linux
kernel, could you contact me at jbglaw@microdata-pos.de?)

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

--gS/sOEqITpbrYRmu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCCm1WHb1edYOZ4bsRAn/1AJ98lZhXVHjIFQJZ5kUF76Zj7UVb9QCdHWEc
agVpFg5yoWiyiX169M6gF14=
=FXc/
-----END PGP SIGNATURE-----

--gS/sOEqITpbrYRmu--
