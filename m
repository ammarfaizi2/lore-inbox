Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264709AbSJUDhh>; Sun, 20 Oct 2002 23:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264717AbSJUDhg>; Sun, 20 Oct 2002 23:37:36 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:26378 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S264709AbSJUDhf>; Sun, 20 Oct 2002 23:37:35 -0400
Date: Mon, 21 Oct 2002 12:42:57 +0900 (JST)
Message-Id: <20021021.124257.131358184.yoshfuji@linux-ipv6.org>
To: davem@rth.ninka.net
Cc: sandy@storm.ca, mk@linux-ipv6.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, cryptoapi-devel@kerneli.org,
       design@lists.freeswan.org, usagi@linux-ipv6.org
Subject: Re: [Design] [PATCH] USAGI IPsec
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <1035168066.4817.1.camel@rth.ninka.net>
References: <m3k7kpjt7c.wl@karaba.org>
	<3DB41338.3070502@storm.ca>
	<1035168066.4817.1.camel@rth.ninka.net>
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

In article <1035168066.4817.1.camel@rth.ninka.net> (at 20 Oct 2002 19:41:06 -0700), "David S. Miller" <davem@rth.ninka.net> says:

> > Is this code being checked in to the mainline kernel? Or becoming part 
> > of the
> > CryptoAPI patch set? Bravo, in either case.
> 
> We will be incorporating lots of ideas and small code pieces
> from USAGI's work, but most of the core engine will be a new
> implementation.
:
> It is intended that this work will be complete (it isn't done as I
> type this) and pushed to Linus upon his return from vacation.

Well, we'd like to learn more about your ideas...
Source code is our friend.
If you don't mind, would you send "as-is" codes to us?

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
