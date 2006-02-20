Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161194AbWBTXJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161194AbWBTXJr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 18:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161196AbWBTXJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 18:09:47 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:4520 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1161194AbWBTXJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 18:09:47 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [-mm patch] remove kernel/power/pm.c:pm_unregister()
Date: Tue, 21 Feb 2006 09:06:42 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060220223617.GM4661@stusta.de>
In-Reply-To: <20060220223617.GM4661@stusta.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9683826.FxiYcYt9VU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602210906.45783.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart9683826.FxiYcYt9VU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

One word...

On Tuesday 21 February 2006 08:36, Adrian Bunk wrote:
> Since the last user is removed in -mm, we can now remove this long
> deprecated function.

Yay!

Nigel

--nextPart9683826.FxiYcYt9VU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD+kuFN0y+n1M3mo0RAuCdAJ9kE1fKM4xX/Mb7dXjOqMfuZAqEAwCdGKC/
jllgB5hNjgYCMsfNPs5ng0U=
=rGbM
-----END PGP SIGNATURE-----

--nextPart9683826.FxiYcYt9VU--
