Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265110AbUD3Is1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265110AbUD3Is1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 04:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUD3Is1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 04:48:27 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:17560 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265110AbUD3Ira (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 04:47:30 -0400
Date: Fri, 30 Apr 2004 10:47:22 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-ID: <20040430084722.GU29503@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0404291114150.9152-100000@chimarrao.boston.redhat.com> <4FE43C97-9A20-11D8-B804-000A95CD704C@wagland.net> <4091757B.3090209@techsource.com> <200404292347.17431.koke_lkml@amedias.org> <0CAE0144-9A2C-11D8-B83D-000A95BCAC26@linuxant.com> <20040429195553.4fba0da7.seanlkml@rogers.com> <3A39091E-9A4C-11D8-B83D-000A95BCAC26@linuxant.com> <20040430004344.663acf90.seanlkml@rogers.com> <6FD0ADAF-9A69-11D8-B83D-000A95BCAC26@linuxant.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pnDjx0H/VpusRTEI"
Content-Disposition: inline
In-Reply-To: <6FD0ADAF-9A69-11D8-B83D-000A95BCAC26@linuxant.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pnDjx0H/VpusRTEI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-04-30 01:44:24 -0400, Marc Boucher <marc@linuxant.com>
wrote in message <6FD0ADAF-9A69-11D8-B83D-000A95BCAC26@linuxant.com>:

> There are major chipset vendors out there who have managed to become=20
> market leaders while not providing any drivers for Linux.

Which I think is a bad thing. Vendors work for their customers (hey,
even you said something like that) and /me as a customer wants to see
specs for the devices. So? Comply or die, dear vendor.

(Oh, I'm to buy a new laptop at some time. Any hints for a good machine?
Fully supported and not-that-much sucking? The sparc boxes from tadpole
look nice...)

> But other vendors are also still releasing new native linux drivers,=20
> despite the availability of our solutions (Intel's project for Centrino=
=20
> at ipw2100.sourceforge.net is a great example).

It's nice if they actually work on drivers (ie. the e100 driver is more
stable on some chipset-buildin NICs than the eepro100), but that
wouldn't be the final factor for or against a decision about a product.
Documentation therefor matters! If a supplied driver is commented very
well, I'd even accept that for docs!

> This essentially proves that we are not removing the incentive to do=20
> proper native drivers, simply providing more options for 1) people who=20
> would otherwise be stuck or unable to use the full functionality of=20
> their machines under Linux right now, and 2) vendors who are not able=20
> to afford or justify the cost of developing native linux drivers due to=
=20
> the size of the current Linux desktop market. In general these vendors=20
> plan to one day produce native drivers, once the numbers make it=20
> possible.

I think that most vendors actually do have specs for their hardware. In
most cases, it should even be enough to let them leak at some time...
This way they'd probably sell more hardware:)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--pnDjx0H/VpusRTEI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAkhKaHb1edYOZ4bsRArXJAJ9D9PRZ6EFVfS13cHKyJDUdvZA0XwCgkZoT
fyRjWPdooBg9H3mkMHvzF3M=
=udoF
-----END PGP SIGNATURE-----

--pnDjx0H/VpusRTEI--
