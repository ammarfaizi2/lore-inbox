Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVBZNhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVBZNhN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 08:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVBZNhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 08:37:13 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:43788 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261197AbVBZNhH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 08:37:07 -0500
Date: Sat, 26 Feb 2005 22:38:30 +0900 (JST)
Message-Id: <20050226.223830.64958789.yoshfuji@linux-ipv6.org>
To: bunk@stusta.de
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [2.6 patch] deprecate EXPORT_SYMBOL(do_settimeofday)
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20050226.223742.103439510.yoshfuji@linux-ipv6.org>
References: <20050224212448.367af4be.akpm@osdl.org>
	<20050226133337.GK3311@stusta.de>
	<20050226.223742.103439510.yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050226.223742.103439510.yoshfuji@linux-ipv6.org> (at Sat, 26 Feb 2005 22:37:42 +0900 (JST)), YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> says:

> In article <20050226133337.GK3311@stusta.de> (at Sat, 26 Feb 2005 14:33:37 +0100), Adrian Bunk <bunk@stusta.de> says:
> 
> 
> > +
> > +What:	EXPORT_SYMBOL(do_settimeofday)
> > +When:	26 Aug 2005
>                    ~~~ Feb?
> > +Files:	arch/*/kernel/time.c
> > +Why:	not used in the kernel
> > +Who:	Adrian Bunk <bunk@stusta.de>

oops, I was wrong. This is schedule. sorry.

--yoshfuji
