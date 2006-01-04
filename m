Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965237AbWADR2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965237AbWADR2g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965233AbWADR2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:28:36 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:61707 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S965238AbWADR2f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:28:35 -0500
Date: Wed, 04 Jan 2006 11:29:14 -0600 (CST)
Message-Id: <20060104.112914.97246675.yoshfuji@linux-ipv6.org>
To: nick@linicks.net
Cc: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: 2.6.14.5 to 2.6.15 patch
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200601041710.37648.nick@linicks.net>
References: <200601041710.37648.nick@linicks.net>
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

In article <200601041710.37648.nick@linicks.net> (at Wed, 4 Jan 2006 17:10:37 +0000), Nick Warne <nick@linicks.net> says:

> A stupid question - buggered if I can find a kernel patch from 2.6.14.5 to 
> 2.6.15?
> 
> Is there one?

$ interdiff -p1 -z patch-2.6.14.5.bz2 patch-2.6.15.bz2 > patch-2.6.15_2.6.14.5

--yoshfuji
