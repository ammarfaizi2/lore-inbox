Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264401AbTDPOIY (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 10:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264412AbTDPOIY 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 10:08:24 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:61130 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264401AbTDPOIX 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 10:08:23 -0400
Subject: 2.5.67-gcov and 2.4.20-gcov
From: Paul Larson <plars@linuxtestproject.org>
To: ltp-coverage@lists.sourceforge.net,
       lse-tech <lse-tech@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-fn1F6u39fjamqTywFKM2"
X-Mailer: Ximian Evolution 1.0.5 
Date: 16 Apr 2003 09:20:02 -0500
Message-Id: <1050502803.8637.1094.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fn1F6u39fjamqTywFKM2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

The Linux Kernel GCOV patch has a new home.  It will now be available
from the Linux Test Project site at: http://ltp.sourceforge.net.

This release updates the gcov-kernel patches and utilities for 2.5.67
and 2.4.20 kernels, and includes some minor bugfixes.

The Linux Kernel GCOV patch allows utilization of the gcov tool
against a running kernel.  This is different from most other profiling
methods because it can easily tell you things like: which lines of code
are executed, how many times they are executed, and how often different
branches are taken.

Thanks,
Paul Larson


--=-fn1F6u39fjamqTywFKM2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj6dZpIACgkQbkpggQiFDqcbhACcCCGbOXeaVBKUCoHRls+JaeWZ
jE0AniPzUfqUgGS1JHjQLHJ/G4GwyQfl
=AgAa
-----END PGP SIGNATURE-----

--=-fn1F6u39fjamqTywFKM2--

