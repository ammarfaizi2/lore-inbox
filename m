Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263463AbTHZIcT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 04:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263515AbTHZIcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 04:32:19 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:9735 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S263463AbTHZIcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 04:32:16 -0400
Date: Tue, 26 Aug 2003 17:32:26 +0900 (JST)
Message-Id: <20030826.173226.114994096.yoshfuji@linux-ipv6.org>
To: oford@arghblech.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [OOPS] less /proc/net/igmp
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <1061878985.3463.2.camel@spider.hotmonkeyporn.com>
References: <20030825163206.GA1340@penguin.penguin>
	<20030826.150331.102449369.yoshfuji@linux-ipv6.org>
	<1061878985.3463.2.camel@spider.hotmonkeyporn.com>
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

Please CC: netdev.

In article <1061878985.3463.2.camel@spider.hotmonkeyporn.com> (at 26 Aug 2003 01:23:06 -0500), Owen Ford <oford@arghblech.com> says:

> > I could not reproduce this issue.  anyone?
> 
> I can confirm. I have it with 2.6.0-test4.
> 
> Let me know what useful info I can provide.  The oops is the same.

Okay, everyone. I'll try to fix this.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
