Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267107AbTCEPjQ>; Wed, 5 Mar 2003 10:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267135AbTCEPjP>; Wed, 5 Mar 2003 10:39:15 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:47884 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S267107AbTCEPh5>; Wed, 5 Mar 2003 10:37:57 -0500
Date: Thu, 06 Mar 2003 00:48:20 +0900 (JST)
Message-Id: <20030306.004820.41101302.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: kazunori@miyazawa.org, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, usagi@linux-ipv6.org
Subject: Re: (usagi-core 12294) Re: [PATCH] IPv6 IPsec support
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030305.072149.121185037.davem@redhat.com>
References: <20030305233025.784feb00.kazunori@miyazawa.org>
	<20030305.072149.121185037.davem@redhat.com>
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

In article <20030305.072149.121185037.davem@redhat.com> (at Wed, 05 Mar 2003 07:21:49 -0800 (PST)), "David S. Miller" <davem@redhat.com> says:

> I will apply your patch after basic build testing.

Thank you.

> The next large task will be to abstract out more common
> pieces of code.  There is still quite a bit of code duplication
> between v4 and v6 xfrm methods,

Yes, we will do that.  That patch is first step for reducing 
duplicate codes between IPv4 and IPv6.

--yoshfuji
