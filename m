Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262668AbSJHAby>; Mon, 7 Oct 2002 20:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262680AbSJHAby>; Mon, 7 Oct 2002 20:31:54 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:2058 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S262668AbSJHAbx>; Mon, 7 Oct 2002 20:31:53 -0400
Date: Tue, 08 Oct 2002 09:37:21 +0900 (JST)
Message-Id: <20021008.093721.11469009.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Fix Prefix Length of Link-local Addresses
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20021007.115530.00078126.davem@redhat.com>
References: <20021008.000559.17528416.yoshfuji@linux-ipv6.org>
	<20021007.115530.00078126.davem@redhat.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021007.115530.00078126.davem@redhat.com> (at Mon, 07 Oct 2002 11:55:30 -0700 (PDT)), "David S. Miller" <davem@redhat.com> says:

> BTW, we start to run into conflicts now and most of USAGI patches now
> I need to apply some parts by hand.  Here is one example, with this
> patch:
:
> It is not such a big deal now, but it may soon become larger as
> bigger USAGI patches are applied.  We will need to synchronize
> at some point.

Agreed.

So,... What kind of patches do you prefer, now?

 - on top of plain kernel (2.4.19, 2.4.20, 2.4.21-preXX, or whatever)
 - plain kernel + on top of our whole patch?
 - ???

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
