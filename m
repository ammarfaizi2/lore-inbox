Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbUL3AqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUL3AqJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 19:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUL3AoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 19:44:13 -0500
Received: from smtp.ono.com ([62.42.230.12]:682 "EHLO mta02.onolab.com")
	by vger.kernel.org with ESMTP id S261470AbUL3Ajn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 19:39:43 -0500
Message-ID: <41D34E4D.7020802@usuarios.retecal.es>
Date: Thu, 30 Dec 2004 01:39:41 +0100
From: =?UTF-8?B?UmFtw7NuIFJleSBWaWNlbnRl?= <rrey@usuarios.retecal.es>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041218)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: [2.6-bk]  net/core/sock.o build failed 
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

CC      net/core/sock.o
In file included from include/net/ipv6.h:18,
~                 from include/net/xfrm.h:16,
~                 from net/core/sock.c:121:
include/linux/ipv6.h: In function `inet6_sk':
include/linux/ipv6.h:278: error: structure has no member named `pinet6'
make[2]: *** [net/core/sock.o] Error 1
make[1]: *** [net/core] Error 2
make: *** [net] Error
- --
Ramón Rey Vicente <ramon.rey en hispalinux.es>
JID rreylinux@jabber.org - GPG public key id 0x9F28E377
GPG Fingerprint 0BC2 8014 2445 51E8 DE87  C888 C385 A9D3 9F28 E377
Planet AUGCyL - http://augcyl.org/planet/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB005Mw4Wp058o43cRAlCOAKC/CgQqOd46mtMd8YH2CZPbUxPYYACgnac6
42+Fo9zb03tshC6Bb6B3BVg=
=wzPr
-----END PGP SIGNATURE-----
