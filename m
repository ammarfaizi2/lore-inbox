Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVAaFPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVAaFPs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 00:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVAaFPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 00:15:48 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:18443 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261920AbVAaFPp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 00:15:45 -0500
Date: Mon, 31 Jan 2005 14:16:36 +0900 (JST)
Message-Id: <20050131.141636.20664459.yoshfuji@linux-ipv6.org>
To: kaber@trash.net, kozakai@linux-ipv6.org
Cc: herbert@gondor.apana.org.au, davem@davemloft.net,
       rmk+lkml@arm.linux.org.uk, Robert.Olsson@data.slu.se, akpm@osdl.org,
       torvalds@osdl.org, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Memory leak in 2.6.11-rc1?
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <41FDBB78.2050403@trash.net>
References: <E1CvSuS-00056x-00@gondolin.me.apana.org.au>
	<20050131.134559.125426676.yoshfuji@linux-ipv6.org>
	<41FDBB78.2050403@trash.net>
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

In article <41FDBB78.2050403@trash.net> (at Mon, 31 Jan 2005 06:00:40 +0100), Patrick McHardy <kaber@trash.net> says:

|We don't need this for IPv6 yet. Once we get nf_conntrack in we
|might need this, but its IPv6 fragment handling is different from
|ip_conntrack, I need to check first.

Ok. It would be better to have some comment but anyway...
kozakai-san?

--yoshfuji
