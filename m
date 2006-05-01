Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWEAHXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWEAHXi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 03:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWEAHXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 03:23:38 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:1992
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751308AbWEAHXh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 03:23:37 -0400
From: Michael Buesch <mb@bu3sch.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
Date: Mon, 1 May 2006 09:28:33 +0200
User-Agent: KMail/1.9.1
References: <20060430174426.a21b4614.rdunlap@xenotime.net>
In-Reply-To: <20060430174426.a21b4614.rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1673370.Ls1rhiPp9A";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200605010928.33773.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1673370.Ls1rhiPp9A
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 01 May 2006 02:44, you wrote:
> +     NOTE! Again - there needs to be a _reason_ for this. If something is
> +     "unsigned long", then there's no reason to do
> +
> +	typedef long myflags_t;

typedef unsigned long myflags_t;

=2D-=20
Greetings Michael.

--nextPart1673370.Ls1rhiPp9A
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEVbihlb09HEdWDKgRAifQAKCGDurJpJWsV9hTEHfUS/ROC3LczwCeJwFZ
8w4y86jcLK130LQU+i2Md40=
=q1qZ
-----END PGP SIGNATURE-----

--nextPart1673370.Ls1rhiPp9A--
