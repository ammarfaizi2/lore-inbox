Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264551AbUDULjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264551AbUDULjv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 07:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264552AbUDULjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 07:39:51 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:41349 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S264551AbUDULjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 07:39:49 -0400
Date: Wed, 21 Apr 2004 13:39:47 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 4/15] New set of input patches: lkkbd whitespace
Message-ID: <20040421113947.GA12700@lug-owl.de>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <200404210049.17139.dtor_core@ameritech.net> <200404210052.28755.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W7pZbPQLbZqmHLZM"
Content-Disposition: inline
In-Reply-To: <200404210052.28755.dtor_core@ameritech.net>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--W7pZbPQLbZqmHLZM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-04-21 00:52:25 -0500, Dmitry Torokhov <dtor_core@ameritech.net>
wrote in message <200404210052.28755.dtor_core@ameritech.net>:
> diff -Nru a/drivers/input/keyboard/lkkbd.c b/drivers/input/keyboard/lkkbd=
=2Ec
> --- a/drivers/input/keyboard/lkkbd.c	Tue Apr 20 23:00:57 2004
> +++ b/drivers/input/keyboard/lkkbd.c	Tue Apr 20 23:00:57 2004
> @@ -12,7 +12,7 @@
>   * adaptor).
>   *
>   * DISCLAUNER: This works for _me_. If you break anything by using the
            ^--- If you had only caught this one :)

I'll take this patch into my tree, too.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--W7pZbPQLbZqmHLZM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAhl2DHb1edYOZ4bsRAkw8AJ4jCNnEaWT6YqFolfpGXtdA1QMYjgCeNE8N
333SdO56Sdss9FnDDDFhEHA=
=9Aos
-----END PGP SIGNATURE-----

--W7pZbPQLbZqmHLZM--
