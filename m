Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbTJSEbx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 00:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbTJSEbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 00:31:53 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:59407 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S261965AbTJSEbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 00:31:52 -0400
Date: Sun, 19 Oct 2003 13:33:14 +0900 (JST)
Message-Id: <20031019.133314.127739603.yoshfuji@linux-ipv6.org>
To: ameschede@gmx.de
Cc: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: IPv6 module broken in 2.6.0-test8
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <3F915007.7040709@gmx.de>
References: <3F915007.7040709@gmx.de>
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

In article <3F915007.7040709@gmx.de> (at Sat, 18 Oct 2003 16:36:55 +0200), Alwin Meschede <ameschede@gmx.de> says:

> the ipv6 module of 2.6.0-test8 is not loadable because of an unknown 
> symbol __secpath_destroy. I think this is related to the "Clear security 
> path for tunnel packets" patch by herbert@gondor.apana.org.au

Please send me your .config.
Thanks.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
