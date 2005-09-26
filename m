Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbVIZUSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbVIZUSl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 16:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVIZUSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 16:18:41 -0400
Received: from mail01.hansenet.de ([213.191.73.61]:51919 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S932504AbVIZUSl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 16:18:41 -0400
From: Malte =?utf-8?q?Schr=C3=B6der?= <MalteSch@gmx.de>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: Re: Problem with nfs4, kernel 2.6.13.2
Date: Mon, 26 Sep 2005 22:18:11 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200509251516.23862.MalteSch@gmx.de> <1127737730.8453.5.camel@lade.trondhjem.org>
In-Reply-To: <1127737730.8453.5.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5760677.6HedpckEf1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509262218.15885.MalteSch@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5760677.6HedpckEf1
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 26 September 2005 14:28, Trond Myklebust wrote:
> Also, is this something that is NFSv4 only, or can you reproduce it on
> NFSv2/v3 too?

I have been running my "stress test" for a few hours with nfsv3, without=20
problems.
I tried over nfsv4 again and it crashed after a few minutes.

=2D-=20
=2D--------------------------------------
Malte Schr=C3=B6der
MalteSch@gmx.de
ICQ# 68121508
=2D--------------------------------------


--nextPart5760677.6HedpckEf1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDOFeH4q3E2oMjYtURApuVAJ458bgPiD2CEBY1nMim2sid8IkB5ACeIDZf
uydkAWO7Z1K9lkC9cc0Ze0U=
=g7wH
-----END PGP SIGNATURE-----

--nextPart5760677.6HedpckEf1--
