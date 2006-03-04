Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751722AbWCDDLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbWCDDLN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 22:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbWCDDLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 22:11:13 -0500
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:57728 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751722AbWCDDLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 22:11:12 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Interbench v0.30
Date: Sat, 4 Mar 2006 14:11:05 +1100
User-Agent: KMail/1.9.1
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2281878.3xXco7ZJG0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603041411.08252.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2281878.3xXco7ZJG0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Interbench is a benchmark application designed to benchmark interactivity i=
n=20
Linux.

http://interbench.kolivas.org

Direct download:
http://ck.kolivas.org/apps/interbench/interbench-0.30.tar.bz2

Changes:
Hackbench as a load was made optional during realtime testing instead of=20
defaulting on as this load caused out of memory kills very easily. Some for=
m=20
of userspace starvation is occurring (and this may be something useful to=20
instrument but I haven't the time).

Selecting or unselecting loads to benchmark was added (thanks Peter William=
s)

Manpage was added (thanks Julien Valroff).

Cheers,
Con

--nextPart2281878.3xXco7ZJG0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBECQVMZUg7+tp6mRURAjbFAJ49AceSZhP1VCwB9IHnlnQMt66ltgCfd82Z
zukbA1a+9/6McepAxL1nSNg=
=O2fn
-----END PGP SIGNATURE-----

--nextPart2281878.3xXco7ZJG0--
