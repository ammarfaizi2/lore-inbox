Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269041AbUHZOxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269041AbUHZOxa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 10:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269014AbUHZOuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 10:50:12 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:31748 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S269032AbUHZOqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 10:46:17 -0400
From: Felipe Alfaro Solana <lkml@felipe-alfaro.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.9-rc1-mm1
Date: Thu, 26 Aug 2004 16:45:54 +0200
User-Agent: KMail/1.7
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20040826014745.225d7a2c.akpm@osdl.org> <412DC47B.4000704@kolivas.org> <200408261636.06857.rjw@sisk.pl>
In-Reply-To: <200408261636.06857.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart10618987.bdzzmUu5oY";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200408261646.08419.lkml@felipe-alfaro.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart10618987.bdzzmUu5oY
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 26 August 2004 16:36, Rafael J. Wysocki wrote:

> I think the problem is that relatively not so many people run -mm, and ev=
en
> less people try to use them for a longer time.  Also, there sometimes are
> some issues with -mm that must be sorted out first, but then there's not
> much time left for testing the scheduler before the next -mm.

I think this is the main reason of existence for -mm kernels: find problems=
,=20
sort them out and fix them. I've been running -mm kernels since 2.5.80+ and=
=20
all problems I have had were resolved in a timely manner.

What I think is that Con's scheduler is the one that needs to get into -mm=
=20
kernels to give it more exposure. Currently, it has a very limited audience.

--nextPart10618987.bdzzmUu5oY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBLfewBmklErlTjhURApKwAKCnfy/Elh63IGcbtDN9MUgajEbNLQCdH1H/
0EBkxqyFHyvoCmjMdUx2QAc=
=RlVQ
-----END PGP SIGNATURE-----

--nextPart10618987.bdzzmUu5oY--
