Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVCNNcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVCNNcn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 08:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVCNNcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 08:32:43 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:54032 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261489AbVCNNcl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 08:32:41 -0500
Date: Mon, 14 Mar 2005 22:34:22 +0900 (JST)
Message-Id: <20050314.223422.120167824.yoshfuji@linux-ipv6.org>
To: alan@lxorguk.ukuu.org.uk, felix@nevis.columbia.edu
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: select() doesn't respect SO_RCVLOWAT ?
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <1110806662.15927.108.camel@localhost.localdomain>
References: <1110568180.17740.69.camel@localhost.localdomain>
	<Pine.LNX.4.61.0503111434040.30914@shang.nevis.columbia.edu>
	<1110806662.15927.108.camel@localhost.localdomain>
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

In article <1110806662.15927.108.camel@localhost.localdomain> (at Mon, 14 Mar 2005 13:24:24 +0000), Alan Cox <alan@lxorguk.ukuu.org.uk> says:

> 1003.1g both agree with your expectations. The right list is probably
> netdev@oss.sgi.com however.

I've just forwarded this thread to netdev.

--yoshfuji
