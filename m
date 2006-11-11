Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752771AbWKKUYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbWKKUYz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 15:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753369AbWKKUYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 15:24:55 -0500
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:34450 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S1752771AbWKKUYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 15:24:54 -0500
Date: Sat, 11 Nov 2006 21:24:45 +0100
From: martin f krafft <madduck@madduck.net>
To: linux-kernel@vger.kernel.org
Subject: Re: scary messages: HSM violation during boot of 2.6.18/amd64
Message-ID: <20061111202445.GA29555@piper.madduck.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <45550308.1090408@wpkg.org> <200611102310.kAANAgOf019164@turing-police.cc.vt.edu> <455556F7.4000802@gmail.com> <455496CA.5040405@wpkg.org> <200611102239.kAAMdoYV015817@turing-police.cc.vt.edu> <45550308.1090408@wpkg.org> <200611102310.kAANAgOf019164@turing-police.cc.vt.edu> <455496CA.5040405@wpkg.org> <200611102239.kAAMdoYV015817@turing-police.cc.vt.edu> <45550308.1090408@wpkg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <455556F7.4000802@gmail.com> <200611102310.kAANAgOf019164@turing-police.cc.vt.edu> <45550308.1090408@wpkg.org>
X-OS: Debian GNU/Linux 4.0 kernel 2.6.18-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Tomasz Chmielewski <mangoo@wpkg.org> [2006.11.10.2354 +0100]:
> You use old smartmontools :)

I just tried a CVS snapshot of smartmontools from today because you
said:

> -o on / -S on is not supported for sata, unless you use a CVS version of=
=20
> smartmontools.

However, the messages are still there (and neither -o nor -S worked,
smartd said it failed for both).

> For more info, check smartmontools-support mailing list.

I'll turn there. Thanks.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
warning at the gates of bill:
abandon hope, all ye who press <enter> here...

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFVjGNIgvIgzMMSnURAloqAJ9on6PWkMT5ascjW04XJ+y1iCCcvQCgoTSZ
XJ8aparIJD7+bOg8wBJ5xDk=
=eO0q
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
