Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbTE2LUH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 07:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbTE2LSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 07:18:43 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:64517 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S262169AbTE2LQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 07:16:37 -0400
Date: Thu, 29 May 2003 20:30:32 +0900 (JST)
Message-Id: <20030529.203032.131225364.yoshfuji@wide.ad.jp>
To: evil@g-house.de
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: IPv6 module oopsing on 2.5.69
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@wide.ad.jp>
In-Reply-To: <3ED5E9E7.5070602@g-house.de>
References: <3ED5E9E7.5070602@g-house.de>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CC: netdev

Upgrade to 2.5.70 and retest, please.
Thank you.

In article <3ED5E9E7.5070602@g-house.de> (at Thu, 29 May 2003 13:07:19 +0200), Christian <evil@g-house.de> says:

> while booting the ipv6 module gets installed, along with this message in 
> the log:
...

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
