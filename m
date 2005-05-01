Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVEABbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVEABbS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 21:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVEABbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 21:31:18 -0400
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:6018 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261488AbVEABbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 21:31:15 -0400
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: 2.6.11-ck7
Date: Sun, 1 May 2005 11:31:31 +1000
User-Agent: KMail/1.8
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200505010017.36907.kernel@kolivas.org> <200505011014.58883.kernel@kolivas.org> <200505011033.07086.kernel@kolivas.org>
In-Reply-To: <200505011033.07086.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1634521.oCuzhsm2uS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505011131.33923.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1634521.oCuzhsm2uS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Small update from ck6 for wrong scsi patch merge

http://ck.kolivas.org/patches/2.6/2.6.11/2.6.11-ck7/patch-2.6.11-ck7.bz2
or
http://ck.kolivas.org/patches/2.6/2.6.11/2.6.11-ck7/patch-2.6.11-ck7-server.bz2

Changes since 2.6.11-ck6:
-scsi-dead-device.diff
+2.6.11-ck-scsifix.diff
Apply the _correct_ scsci fix.

-2611ck6-version.diff
+2611ck7-version.diff

Cheers,
Con

--nextPart1634521.oCuzhsm2uS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCdDF1ZUg7+tp6mRURAjDVAJ90DQRkmfjyH/YPexnOwUYbKbq0AACfdros
etoLmMyqFyFGEHRi8bW1zTo=
=QpIO
-----END PGP SIGNATURE-----

--nextPart1634521.oCuzhsm2uS--
