Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267569AbSLFHh3>; Fri, 6 Dec 2002 02:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267574AbSLFHh3>; Fri, 6 Dec 2002 02:37:29 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:49672 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S267569AbSLFHh3>; Fri, 6 Dec 2002 02:37:29 -0500
Date: Fri, 06 Dec 2002 16:45:05 +0900 (JST)
Message-Id: <20021206.164505.28366762.yoshfuji@linux-ipv6.org>
To: justinpryzby@users.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: IPSsec kernel panic
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20021206071000.GA7493@perseus.homeunix.net>
References: <20021206071000.GA7493@perseus.homeunix.net>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021206071000.GA7493@perseus.homeunix.net> (at Fri, 6 Dec 2002 02:10:00 -0500), Justin Pryzby <justinpryzby@users.sourceforge.net> says:

> http://lwn.net/Articles/16924/ reports that Debian's freeswan package
> (http://packages.debian.org/testing/non-us/freeswan.html) causes a
> kernel kernel panic due to improper handling of short packets.  A
> userspace program shouldn't be able to cause a kernel panic (unless it
> tries, and is priveliged), so I believe this indicates a kernel problem.

It is FreeS/WAN's problem, isn't it?
If yes, you probably need to talk with FreeS/WAN people.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
