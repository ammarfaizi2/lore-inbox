Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264578AbUFSQuC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264578AbUFSQuC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 12:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbUFSQto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 12:49:44 -0400
Received: from [203.178.140.15] ([203.178.140.15]:518 "EHLO yue.st-paulia.net")
	by vger.kernel.org with ESMTP id S264650AbUFSQeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 12:34:36 -0400
Date: Sun, 20 Jun 2004 01:35:27 +0900 (JST)
Message-Id: <20040620.013527.55353972.yoshfuji@linux-ipv6.org>
To: andrew@walrond.org, davem@redhat.com
Cc: kalin@ThinRope.net, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, yoshfuji@linux-ipv6.org
Subject: Re: Iptables-1.2.9/10 compile failure with linux 2.6.7 headers
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200406191038.51118.andrew@walrond.org>
References: <40D31EA6.5030207@ThinRope.net>
	<20040619.021818.04202102.yoshfuji@linux-ipv6.org>
	<200406191038.51118.andrew@walrond.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200406191038.51118.andrew@walrond.org> (at Sat, 19 Jun 2004 10:38:50 +0100), Andrew Walrond <andrew@walrond.org> says:

> On Friday 18 Jun 2004 18:18, YOSHIFUJI Hideaki / 吉藤英明 wrote:
> >
> > Please try this. Thanks
> >
> 
> I can confirm that iptables-1.2.10 builds fine with your patch applied to 
> linux-2.6.7

Thanks. David?

--yoshfuji
