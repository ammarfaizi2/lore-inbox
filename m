Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbTGGCWR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 22:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbTGGCWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 22:22:17 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:64520 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S264546AbTGGCWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 22:22:17 -0400
Date: Mon, 07 Jul 2003 11:38:17 +0900 (JST)
Message-Id: <20030707.113817.12872908.yoshfuji@wide.ad.jp>
To: dschadlich@hotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.5.73 compile error
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@wide.ad.jp>
In-Reply-To: <Sea2-F24mVH2tgQSYwp0001111c@hotmail.com>
References: <Sea2-F24mVH2tgQSYwp0001111c@hotmail.com>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Sea2-F24mVH2tgQSYwp0001111c@hotmail.com> (at Sun, 06 Jul 2003 22:27:24 -0400), "David Schadlich" <dschadlich@hotmail.com> says:

>   CC [M]  net/ipv4/ipcomp.o
> In file included from net/ipv4/ipcomp.c:24:
> include/net/esp.h: In function `esp_hmac_digest':
> include/net/esp.h:48: warning: implicit declaration of function 
> `crypto_hmac_init'

CONFIG_CRYPTO_HMAC

--yoshfuji
