Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTKNLiv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 06:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbTKNLiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 06:38:51 -0500
Received: from D7146.d.pppool.de ([80.184.113.70]:45199 "EHLO
	karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S262352AbTKNLit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 06:38:49 -0500
Subject: Re: kernel.bkbits.net off the air
From: Daniel Egger <degger@fhm.edu>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <3FB4A6B7.5040306@cyberone.com.au>
References: <fa.eto0cvm.1v20528@ifi.uio.no>
	 <200311112021.34631.andrew@walrond.org>
	 <20031111235215.GA22314@work.bitmover.com>
	 <200311131010.27315.andrew@walrond.org>
	 <20031113162712.GA2462@work.bitmover.com>
	 <1068766365.15965.228.camel@sonja>  <3FB4A6B7.5040306@cyberone.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4g/ftrUq0H2P7YNe2qfB"
Message-Id: <1068809923.15965.240.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 14 Nov 2003 12:38:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4g/ftrUq0H2P7YNe2qfB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Fre, den 14.11.2003 schrieb Nick Piggin um 10:56:

> Actually, at http://www.kernel.org/ there is a link to daily snapshots.
> There are also changesets generated every couple of hours at the "C" link
> at the right of the page.

> Even if Linus doesn't release as often (doesn't he? I don't know), this
> is surely much better than pre BK. Maybe I didn't understand you right?

Seems so. I assume you missed the "bandwidth constraint" part. Fetching
a whole snapshot every day is not even close to workable. The snapshots
in patch form are nice however patching forth and back is not really an
option. If svn doesn't get back up I'd be tempted to use rsync and use
vendor branches in my own SVN repository but this also seems far from
optimal to me. rsync alone doesn't cut it because there's no version
management and I've lost quite a few patches due to an not thoroughly
considered rsync use.

--=20
Servus,
       Daniel

--=-4g/ftrUq0H2P7YNe2qfB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/tL7Cchlzsq9KoIYRAtNKAKCiOxMlSDfUhUYKXTtytyO9PNTG3QCfaoc2
jPPe97csCrWSZ0fP3oXhWuU=
=JDk/
-----END PGP SIGNATURE-----

--=-4g/ftrUq0H2P7YNe2qfB--

