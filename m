Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbUKUNgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbUKUNgE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 08:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbUKUNgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 08:36:04 -0500
Received: from ipx10602.ipxserver.de ([80.190.249.152]:16913 "EHLO taytron.net")
	by vger.kernel.org with ESMTP id S261165AbUKUNgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 08:36:00 -0500
From: Florian Schirmer <jolt@tuxbox.org>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: kbuild: make O=/build/dir broken
Date: Sun, 21 Nov 2004 14:35:56 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200411071436.14046.jolt@tuxbox.org> <20041107160335.GA14156@mars.ravnborg.org>
In-Reply-To: <20041107160335.GA14156@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2793263.Ev0dx1vNxe";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411211436.00736.jolt@tuxbox.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2793263.Ev0dx1vNxe
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

> Old bug fixed some time ago.
>
> Upgrade to latest 2.6.10 - you need to fetch daily snapshots.

Confirmed. Upgraded to -rc2 and both problem are fixed. Thanks for your help!

Best,
  Florian

--nextPart2793263.Ev0dx1vNxe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBoJnAXRF2vHoIlBsRAiYMAKCmAlRjdxX5zx8mZzEEux3nUEjWZQCcDR7x
HGlVCKqa2NwE5X2DTnXzAS8=
=sDJC
-----END PGP SIGNATURE-----

--nextPart2793263.Ev0dx1vNxe--
