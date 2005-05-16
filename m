Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVEPLeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVEPLeJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 07:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVEPLeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 07:34:09 -0400
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:25831 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261551AbVEPLd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 07:33:27 -0400
From: Con Kolivas <kernel@kolivas.org>
To: AndrewMorton <akpm@osdl.org>
Subject: Re: [SMP NICE] [PATCH] SCHED: Implement nice support across physical cpus on SMP
Date: Mon, 16 May 2005 21:33:09 +1000
User-Agent: KMail/1.8
Cc: Carlos Carvalho <carlos@fisica.ufpr.br>, ck@vds.kolivas.org,
       Ingo Molnar <mingo@elte.hu>,
       Markus =?iso-8859-1?q?T=F6rnqvist?= <mjt@nysv.org>,
       linux-kernel@vger.kernel.org
References: <20050509112446.GZ1399@nysv.org> <17023.63512.319555.552924@fisica.ufpr.br> <200505111304.06853.kernel@kolivas.org>
In-Reply-To: <200505111304.06853.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3324502.NxN9umJa87";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505162133.13399.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3324502.NxN9umJa87
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, 11 May 2005 13:04, Con Kolivas wrote:
> Andrew please consider for inclusion in -mm

It looks like I missed my window of opportunity and the SMP balancing desig=
n=20
has been restructured in latest -mm again so this patch will have to wait=20
another generation. Carlos, Markus you'll have to wait till that code settl=
es=20
down (if ever) before I (or someone else) rewrites it for it to get include=
d=20
in -mm followed by mainline. The patch you currently have will work fine fo=
r=20
2.6.11* and 2.6.12*

Cheers,
Con

--nextPart3324502.NxN9umJa87
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCiIT5ZUg7+tp6mRURAv+aAJ97siSMCJRg/FTi1pSUfDOULRPESwCfaqap
2BTcEJV7dm3m9Pi9LT6oTXM=
=5a6L
-----END PGP SIGNATURE-----

--nextPart3324502.NxN9umJa87--
