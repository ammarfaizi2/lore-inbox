Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262810AbVA1Wpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbVA1Wpb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 17:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbVA1Wpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 17:45:30 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:27914 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S262781AbVA1WpU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 17:45:20 -0500
Date: Sat, 29 Jan 2005 07:46:05 +0900 (JST)
Message-Id: <20050129.074605.78506312.yoshfuji@linux-ipv6.org>
To: herbert@gondor.apana.org.au
Cc: wweissmann@gmx.at, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       davem@davemloft.net, 282492@bugs.debian.org, yoshfuji@linux-ipv6.org
Subject: Re: multiple neighbour cache tables for AF_INET
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <E1CueSz-0000lz-00@gondolin.me.apana.org.au>
References: <24939.1106917237@www31.gmx.net>
	<E1CueSz-0000lz-00@gondolin.me.apana.org.au>
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

In article <E1CueSz-0000lz-00@gondolin.me.apana.org.au> (at Sat, 29 Jan 2005 09:19:49 +1100), Herbert Xu <herbert@gondor.apana.org.au> says:

> IMHO you need to give the user a way to specify which table they want
> to operate on.  If they don't specify one, then the current behaviour
> of choosing the first table found is reasonble.

We have dev. Isn't is sufficient?

--yoshfuji
