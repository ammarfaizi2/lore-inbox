Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVGLM1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVGLM1N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 08:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVGLMYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 08:24:44 -0400
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:6300 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261385AbVGLMYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 08:24:01 -0400
From: Con Kolivas <kernel@kolivas.org>
To: David Lang <david.lang@digitalinsight.com>
Subject: Re: [ANNOUNCE] Interbench v0.20 - Interactivity benchmark
Date: Tue, 12 Jul 2005 22:23:44 +1000
User-Agent: KMail/1.8.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
References: <200507122110.43967.kernel@kolivas.org> <200507122202.39988.kernel@kolivas.org> <Pine.LNX.4.62.0507120507430.9200@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0507120507430.9200@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2798036.Tb0N4Oca5x";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507122223.46997.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2798036.Tb0N4Oca5x
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tue, 12 Jul 2005 22:17, David Lang wrote:
> which brings up another possible config option/test case, changing the
> read/write tests to try to do X MB/sec rather then the max possible speed
> (probably defaulting to max if nothing is specified)

That's a good idea. I was planning on adding a configurable cpu%/interval=20
benchmark as well so configurable read/write is a logical addition.=20

> thanks again for working to define a good test case

You're welcome, and thanks for feedback.

Cheers,
Con

--nextPart2798036.Tb0N4Oca5x
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC07ZSZUg7+tp6mRURAubZAKCBsriVQOnVh80MuPOxsua3cuUYbQCeKoBS
hFvpMfQPFGrEGZ+uizkS1dw=
=WC9W
-----END PGP SIGNATURE-----

--nextPart2798036.Tb0N4Oca5x--
