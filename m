Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVBRCGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVBRCGu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 21:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVBRCGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 21:06:49 -0500
Received: from downeast.net ([204.176.212.2]:17147 "EHLO downeast.net")
	by vger.kernel.org with ESMTP id S261254AbVBRCGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 21:06:47 -0500
From: Patrick McFarland <pmcfarland@downeast.net>
To: lm@bitmover.com, linux-kernel@vger.kernel.org, darcs-users@darcs.net
Subject: Re: [BK] upgrade will be needed
Date: Thu, 17 Feb 2005 21:05:16 -0500
User-Agent: KMail/1.7.2
References: <20050214020802.GA3047@bitmover.com>
In-Reply-To: <20050214020802.GA3047@bitmover.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2275150.Gn8lpcjzlu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200502172105.25677.pmcfarland@downeast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2275150.Gn8lpcjzlu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 13 February 2005 09:08 pm, Larry McVoy wrote:
> Something that unintentionally started a flamewar.

Well, we just went through another round of 'BK sucks' and 'BK sucks, we ne=
ed=20
to switch to something else'.

Sans the flamewar, are there any options? CVS and SVN are out because they =
do=20
not support 'off server' branches (arch and darcs do). Darcs would probably=
=20
be the best choice because its easy to use, and the darcs team almost has a=
=20
working linux-kernel import script (originally designed to just test darcs=
=20
with a huge repo, but provides a mostly working linux tree).

So, without the flamewar, what is everyone's opinion on this?=20

=2D-=20
Patrick "Diablo-D3" McFarland || unknown@panax.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, w=
e'd=20
all be running around in darkened rooms, munching magic pills and listening=
 to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989

--nextPart2275150.Gn8lpcjzlu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCFU1l8Gvouk7G1cURApaUAJ4pjxb2Qxx8afMk4sIpySHxdcQsoACgqtZ3
b4bnFWE6OL0hdpe9UVJedHc=
=e5W6
-----END PGP SIGNATURE-----

--nextPart2275150.Gn8lpcjzlu--
