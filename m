Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266927AbSKOXJQ>; Fri, 15 Nov 2002 18:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266928AbSKOXJQ>; Fri, 15 Nov 2002 18:09:16 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:28801 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S266927AbSKOXJP> convert rfc822-to-8bit; Fri, 15 Nov 2002 18:09:15 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.47-mm3
Date: Sat, 16 Nov 2002 10:15:53 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211161015.56003.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I dont have anything crypto enabled in the config

In file included from include/net/xfrm.h:6,
                 from net/core/skbuff.c:61:
include/linux/crypto.h: In function `crypto_tfm_alg_modname':
include/linux/crypto.h:202: dereferencing pointer to incomplete type
include/linux/crypto.h:205: warning: control reaches end of non-void function
make[2]: *** [net/core/skbuff.o] Error 1
make[1]: *** [net/core] Error 2
make: *** [net] Error 2

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE91YApF6dfvkL3i1gRAoCsAKCVHM1sZofeuVSK7HLZO9RyjQe+kACeKPoz
vdAtgtG2/8DAqe6Vz03Mn8k=
=IFnQ
-----END PGP SIGNATURE-----

