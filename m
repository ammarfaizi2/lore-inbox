Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261853AbSKCNNp>; Sun, 3 Nov 2002 08:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261856AbSKCNNp>; Sun, 3 Nov 2002 08:13:45 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:26889 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S261853AbSKCNNo>; Sun, 3 Nov 2002 08:13:44 -0500
Date: Sun, 03 Nov 2002 22:20:10 +0900 (JST)
Message-Id: <20021103.222010.31188042.yoshfuji@linux-ipv6.org>
To: kisza@securityaudit.hu
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, davem@redhat.com,
       kuznet@ms2.inr.ac.ru, usagi@linux-ipv6.org, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Functions Clean-up
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20021103.221658.52523847.yoshfuji@linux-ipv6.org>
References: <20021103.115427.104445233.yoshfuji@linux-ipv6.org>
	<1036328414.1048.3.camel@arwen>
	<20021103.221658.52523847.yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021103.221658.52523847.yoshfuji@linux-ipv6.org> (at Sun, 03 Nov 2002 22:16:58 +0900 (JST)), YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> says:

> So, the reason why the copy of route6_me_harder() 
> lives there is because net/ipv6/ip6_output.c has not been 
                                               ~~~~~~~~~~~~does not
> exported it.
  ~~~~~~~~export

--yoshfuji
