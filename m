Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbTISDBf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 23:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbTISDBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 23:01:35 -0400
Received: from mx2.undergrid.net ([64.174.245.170]:26579 "EHLO
	mail.undergrid.net") by vger.kernel.org with ESMTP id S261162AbTISDBd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 23:01:33 -0400
From: "Jeremy T. Bouse" <Jeremy.Bouse@UnderGrid.net>
Date: Thu, 18 Sep 2003 20:00:37 -0700
To: linux-kernel@vger.kernel.org
Subject: Problems with airo/airo_cs since test4-bk2
Message-ID: <20030919030037.GA5581@UnderGrid.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
X-GPG-Debian: 1024D/29AB4CDD  C745 FA35 27B4 32A6 91B3 3935 D573 D5B1 29AB 4CDD
X-GPG-General: 1024D/62DBDF62  E636 AB22 DC87 CD52 A3A4 D809 544C 4868 62DB DF62
User-Agent: Mutt/1.5.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Since test4-bk2 I've still had increasing problems with the
airo/airo_cs driver... test4-bk2 operates but generates an awful lot of
frame errors... I've tried test5-bk1 , bk3 and bk5 and they fail to even
be able to associate with the AP at all and totally unusable... As soon
as the driver and/or card are removed it causes an oops unlike earlier
test versions which would just lock the whole machine up...

	Has anyone else been noticing these problems with a Cisco Aironet 350?
I've got it in a Sony Vaio PCG-C1MWP and use it on two networks which
use either a LinkSys WAP11 or an Orinoco AP-1000 with the same
results...

	Regards,
	Jeremy

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/anFVzbdYcZyFNB8RAlzUAKC9i3mvYtbU6UxR+kdkKZyU13xiaQCfRBn7
oECX0dhr9Sc9ByrEJgzrGeE=
=VwPM
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
