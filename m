Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264129AbUFRWyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUFRWyY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 18:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUFRWxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 18:53:08 -0400
Received: from [203.178.140.15] ([203.178.140.15]:60165 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S264129AbUFRWub
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 18:50:31 -0400
Date: Sat, 19 Jun 2004 07:51:28 +0900 (JST)
Message-Id: <20040619.075128.106025605.yoshfuji@linux-ipv6.org>
To: kalin@ThinRope.net, andrew@walrond.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, yoshfuji@linux-ipv6.org
Subject: Re: Iptables-1.2.9/10 compile failure with linux 2.6.7 headers
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <40D3361B.5020304@ThinRope.net>
References: <40D31EA6.5030207@ThinRope.net>
	<20040619.021818.04202102.yoshfuji@linux-ipv6.org>
	<40D3361B.5020304@ThinRope.net>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <40D3361B.5020304@ThinRope.net> (at Sat, 19 Jun 2004 03:36:11 +0900), Kalin KOZHUHAROV <kalin@ThinRope.net> says:

> As far as I understand from this patch, this should be applied to the system headers...

Patch is for current linux-2.5 bk tree,
not for linux-headers.

Please try to patch your kernel and set KERNEL_DIR to 
/path/to/your/kernel when you compile iptables.

Thanks.

--yoshfuji
