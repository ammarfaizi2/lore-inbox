Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbUKJTI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbUKJTI0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 14:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbUKJTIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 14:08:25 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:854 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262099AbUKJTIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 14:08:21 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net,
       user-mode-linux-user@lists.sourceforge.net,
       Jeff Dike <jdike@addtoit.com>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: 2.6.9-bb2 released.
User-Agent: KMail/1.7.1
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Nov 2004 20:07:46 +0100
Content-Type: multipart/signed;
  boundary="nextPart1356586.hH1RFF5opU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411102008.02212.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1356586.hH1RFF5opU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

You can find all on http://www.user-mode-linux.org/~blaisorblade/.

Changes in both 2.6.9-bb2 against 2.6.9-bb1:
=2D updated most bugs of -bb1 which were reported
=2D fixed the Gentoo/NPTL issue, thanks to Bodo Stroesser (sorry for forget=
ting=20
the credit on the changelog, but I'm leaving for one day in a few minutes):
but you must still compile Uml disabling CONFIG_MODE_TT (and obviously use =
the=20
SKAS patch you find on the same site).

More info on the website "Changelog" page.

Distribution (like -bb1):

* the patch are also in split-out form, both web-browsable and tarballed.
* md5sums are available (to test with "md5sum -c *.md5").

Any testing and report is welcome.

Hope It Rocks!
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--nextPart1356586.hH1RFF5opU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBkmcRqH9OHC+5NscRAhlgAJ9udAuPfVO+R1Kf90epy7CBlEqqGQCgjqty
RF9jeeKvVYk8yJ3MhwcgsC4=
=q6sS
-----END PGP SIGNATURE-----

--nextPart1356586.hH1RFF5opU--
