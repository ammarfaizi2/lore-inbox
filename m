Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbVJaMPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbVJaMPR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 07:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbVJaMPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 07:15:17 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:41991 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S932320AbVJaMPQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 07:15:16 -0500
Date: Mon, 31 Oct 2005 21:15:34 +0900 (JST)
Message-Id: <20051031.211534.50784200.yoshfuji@linux-ipv6.org>
To: yanzheng@21cn.com, acme@ghostprotocols.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH][MCAST]IPv6: Check packet size when process Multicast
 Address and Source Specific Query
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <43660989.2000100@21cn.com>
References: <4365A995.3050404@21cn.com>
	<20051031.142717.40152885.yoshfuji@linux-ipv6.org>
	<43660989.2000100@21cn.com>
Organization: USAGI/WIDE Project
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

In article <43660989.2000100@21cn.com> (at Mon, 31 Oct 2005 20:09:45 +0800), Yan Zheng <yanzheng@21cn.com> says:

> I hope the new one is correct.

looks ok.
Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

--yoshfuji
