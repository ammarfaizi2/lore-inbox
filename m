Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbUC2IJr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 03:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUC2IJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 03:09:47 -0500
Received: from [196.25.168.8] ([196.25.168.8]:54756 "EHLO lbsd.net")
	by vger.kernel.org with ESMTP id S262733AbUC2IJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 03:09:43 -0500
Date: Mon, 29 Mar 2004 10:09:36 +0200
From: Nigel Kukard <nkukard@lbsd.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] DVD+-RW support for 2.6.x
Message-ID: <20040329080936.GO19235@lbsd.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sr6hGnsCY8KeifOY"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-PHP-Key: http://www.lbsd.net/~nkukard/keys/gpg_public.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Sr6hGnsCY8KeifOY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I've re-worked the DVD+-RW support for 2.6.x, all bugs should now be
fixed.

This patch applies cleanly...
http://www.lbsd.net//downloads/kernel/linux-2.6.4_dvd+rw-rc2.patch.bz2

This patch (support for DVD-RW) requires the packet writing patch to
be applied first...
http://www.lbsd.net//downloads/kernel/linux-2.6.4_dvd-rw-rc1.patch.bz2

Packet writing patch can be found here...
http://w1.894.telia.com/~u89404340/patches/packet/2.6/

Updates to the DVD+-RW patches can be found at...
http://www.lbsd.net//display.php?page=downloads


Regards
Nigel Kukard


--Sr6hGnsCY8KeifOY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAZ9nAKoUGSidwLE4RAt4bAJ4rJeFAE4IeZsFkEq2L6MfFrGQ10ACfSHhv
MEAQNBN0Cgw/DW/btZVc75s=
=LV4N
-----END PGP SIGNATURE-----

--Sr6hGnsCY8KeifOY--
