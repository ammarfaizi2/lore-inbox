Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266570AbUHSPhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266570AbUHSPhS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 11:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266578AbUHSPhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 11:37:17 -0400
Received: from cantor.suse.de ([195.135.220.2]:5551 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266535AbUHSP3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 11:29:10 -0400
To: Martin Mares <mj@ucw.cz>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org, kernel@wildsau.enemy.org,
       diablod3@gmail.com
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
	<d577e5690408190004368536e9@mail.gmail.com>
	<4124A024.nail7X62HZNBB@burner> <20040819131026.GA9813@ucw.cz>
	<4124AD46.nail80H216HKB@burner> <20040819135614.GA12634@ucw.cz>
From: Andreas Jaeger <aj@suse.de>
Date: Thu, 19 Aug 2004 17:29:04 +0200
In-Reply-To: <20040819135614.GA12634@ucw.cz> (Martin Mares's message of
 "Thu, 19 Aug 2004 15:56:14 +0200")
Message-ID: <hofz6juoxr.fsf@reger.suse.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Martin Mares <mj@ucw.cz> writes:

>[...]
> You explain that SuSE is non-cooperative, because they distribute crippled
> cdrecord, but you fail to explain what crippledness do you have in mind.

I would be interested also in what's the problem with our current
versions.

> Also, if you put away your flamethrower and just politely asked SUSE to a=
dd
> a message like `this version has been modified by SUSE, so please send yo=
ur
> bug reports to support@suse.com instead of the original author', the whole
> issue would be probably already settled a long time ago.

Just for reference, SUSE does this already since some time.  There was
one version in the 8.x series that was indeed broken but since then
I'm not aware of any issues.

SUSE Linux 9.1 has:

# cdrecord --version
Cdrecord-Clone-dvd 2.01a27 (x86_64-suse-linux) Copyright (C) 1995-2004 J=F6=
rg Schilling
Note: This version is an unofficial (modified) version with DVD support
Note: and therefore may have bugs that are not present in the original.
Note: Please send bug reports or support requests to http://www.suse.de/fee=
dback
Note: The author of cdrecord should not be bothered with problems in this v=
ersion.

Andreas

P.S. Yes, I do work for SUSE.

P.P.S: I think this is getting more and more offtopic for
linux-kernel.  Should we move the discussion somewhere else?

=2D-=20
 Andreas Jaeger, aj@suse.de, http://www.suse.de/~aj
  SUSE Linux AG, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
   GPG fingerprint =3D 93A3 365E CE47 B889 DF7F  FED1 389A 563C C272 A126

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBJMdBOJpWPMJyoSYRAvgiAJ9TP2XtaDb14omrF/uvk1xN7HrgxACeJQHA
ny1rKozt0YE+LvuwKs3pO9g=
=2ZcK
-----END PGP SIGNATURE-----
--=-=-=--
