Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268040AbUIPNk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268040AbUIPNk3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 09:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268064AbUIPNk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 09:40:29 -0400
Received: from S010600105aa6e9d5.gv.shawcable.net ([24.68.24.66]:15788 "EHLO
	spitfire.gotdns.org") by vger.kernel.org with ESMTP id S268040AbUIPNeu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 09:34:50 -0400
From: Ryan Cumming <ryan@spitfire.gotdns.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc2-mm1
Date: Thu, 16 Sep 2004 06:34:47 -0700
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20040916024020.0c88586d.akpm@osdl.org>
In-Reply-To: <20040916024020.0c88586d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1125981.BfrhYmJggi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200409160634.49470.ryan@spitfire.gotdns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1125981.BfrhYmJggi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 16 September 2004 02:40, Andrew Morton wrote:
> +sched-fix-scheduling-latencies-for-preempt-kernels.patch

This patch got a rather unfortunate name, as it actually only fixes latenci=
es=20
for non-preempt kernels.

=2DRyan

--nextPart1125981.BfrhYmJggi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBSZZ5W4yVCW5p+qYRAvqSAJ9+kvSB79hEWYi/kL77RMlguvuOHQCgrf3V
pQDyweJlK8hcmQniQRyzsC8=
=2Dnh
-----END PGP SIGNATURE-----

--nextPart1125981.BfrhYmJggi--
