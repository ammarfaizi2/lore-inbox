Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263061AbTJOMnR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 08:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbTJOMnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 08:43:17 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:41684 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263061AbTJOMnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 08:43:15 -0400
Date: Wed, 15 Oct 2003 14:43:14 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Unbloating the kernel, was: :mem=16MB laptop testing
Message-ID: <20031015124314.GD20846@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0310141813320.1776-100000@gaia.cela.pl> <200310141733.h9EHXnYg002262@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qBQybEWmAN81Rzrq"
Content-Disposition: inline
In-Reply-To: <200310141733.h9EHXnYg002262@81-2-122-30.bradfords.org.uk>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qBQybEWmAN81Rzrq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-10-14 18:33:49 +0100, John Bradford <john@grabjohn.com>
wrote in message <200310141733.h9EHXnYg002262@81-2-122-30.bradfords.org.uk>:
> No, 2.6 should run on a 4MB 386 with no significant performance
> penalty against 2.0, in my opinion.

Achtually, with HZ at around 100 (or oven 70..80), an old i386 or i486
will *start* just fine, at least at 8MB. However, over some days /
weeks, the machine gets slower and slower (my testdrive: my 90MHz
P-Classic with 16MB). Even with that "much" RAM, I get hit by whatever
slows down the machine. I *think* that it's the MM subsystem, but I'm
really not skilled enough with it to blame it:)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--qBQybEWmAN81Rzrq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/jUDiHb1edYOZ4bsRAiMZAJ0RFPrvsIKh006gwpS4Ie0iZ91yMwCfT+/s
qUBiEsktxe3HRNRX2dUg3ro=
=pPUi
-----END PGP SIGNATURE-----

--qBQybEWmAN81Rzrq--
