Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263337AbTDSCG6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 22:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbTDSCG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 22:06:58 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:5129 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S263337AbTDSCG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 22:06:57 -0400
Date: Sat, 19 Apr 2003 11:17:19 +0900 (JST)
Message-Id: <20030419.111719.51896623.yoshfuji@wide.ad.jp>
To: davem@redhat.com
Cc: latten@austin.ibm.com, kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: IPsecv6 integrity failures not dropped
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@wide.ad.jp>
In-Reply-To: <20030419.111238.07385967.yoshfuji@wide.ad.jp>
References: <200304182017.h3IKH4ng019821@faith.austin.ibm.com>
	<20030418.141014.17269641.davem@redhat.com>
	<20030419.111238.07385967.yoshfuji@wide.ad.jp>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030419.111238.07385967.yoshfuji@wide.ad.jp> (at Sat, 19 Apr 2003 11:12:38 +0900 (JST)), YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@wide.ad.jp> says:

>   > 0: more header(s) follows; next header is pointed by skb->nh.raw[nhoff]
                                 next header is pointed by nhoff (which means, the next header is skb->nh.raw[nhoff])

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
