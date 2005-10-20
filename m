Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751739AbVJTPO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbVJTPO4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 11:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbVJTPO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 11:14:56 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:15593 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751739AbVJTPOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 11:14:55 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Adaptive read-ahead v4
Date: Thu, 20 Oct 2005 17:14:42 +0200
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, WU Fengguang <wfg@mail.ustc.edu.cn>,
       joern@wohnheim.fh-wedel.de, mingo@elte.hu
References: <20051015174731.GA5851@mail.ustc.edu.cn> <20051018025806.GA3963@mail.ustc.edu.cn> <20051017203137.05350739.akpm@osdl.org>
In-Reply-To: <20051017203137.05350739.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8900464.hFd2VhZG3K";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510201714.48654.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart8900464.hFd2VhZG3K
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 18 October 2005 05:31, Andrew Morton wrote:
[lot of additional page stats]
> You should treat such informaton as a development aid, really.  People are
> very unlikely to look at it in real life.

And put the whole stuff under debugfs, which was made for this AFAIR.


Regards

Ingo Oeser



--nextPart8900464.hFd2VhZG3K
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDV7RoU56oYWuOrkARAlDkAJ4pIiHCjwnsx53qryvxiD4ZxKmUbgCgiOq2
b17Fv4OchtVWKTtVNKwz9nM=
=Redc
-----END PGP SIGNATURE-----

--nextPart8900464.hFd2VhZG3K--
