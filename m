Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265580AbTGDA0m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 20:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265591AbTGDA0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 20:26:42 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:29201 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S265580AbTGDA0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 20:26:35 -0400
Date: Fri, 04 Jul 2003 09:42:15 +0900 (JST)
Message-Id: <20030704.094215.81714589.yoshfuji@linux-ipv6.org>
To: akpm@osdl.org
Cc: manfred@colorfullife.com, andyp@osdl.org, linux-kernel@vger.kernel.org,
       akpm@digeo.com, yoshfuji@linux-ipv6.org
Subject: Re: Linux 2.5.74: BUG at mm/slab.c:1537
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030703141758.12ec3825.akpm@osdl.org>
References: <3F048E77.8080402@colorfullife.com>
	<20030703141758.12ec3825.akpm@osdl.org>
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

In article <20030703141758.12ec3825.akpm@osdl.org> (at Thu, 3 Jul 2003 14:17:58 -0700), Andrew Morton <akpm@osdl.org> says:

> This is the patch out of bugzilla.  I'm not sure who wrote it, and
> there is no description.
>
> (Could people please not do that?  If you have a patch which fixes a
> bug, please squirt it to the mailing list)

I am so sorry to have introduced this bug.
I am the author of the patch, and I have already submit it 
here and to netdev.

http://www.ussg.iu.edu/hypermail/linux/kernel/0307.0/0503.html

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
