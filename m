Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVBFLeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVBFLeH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 06:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVBFLcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 06:32:47 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:24846 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261179AbVBFL1T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 06:27:19 -0500
Date: Sun, 06 Feb 2005 20:28:13 +0900 (JST)
Message-Id: <20050206.202813.132742833.yoshfuji@linux-ipv6.org>
To: andre@tomt.net
Cc: herbert@gondor.apana.org.au, davem@davemloft.net,
       mirko.parthey@informatik.tu-chemnitz.de, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, shemminger@osdl.org, yoshfuji@linux-ipv6.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <4205F797.8080804@tomt.net>
References: <20050204213813.4bd642ad.davem@davemloft.net>
	<20050205061110.GA18275@gondor.apana.org.au>
	<4205F797.8080804@tomt.net>
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

In article <4205F797.8080804@tomt.net> (at Sun, 06 Feb 2005 11:55:19 +0100), Andre Tomt <andre@tomt.net> says:

> I'm contemplating just using it as a quick-fix until 2.6.11 to get this 
> problem under control.

Would you find if my patch works? Thanks.

--yoshfuji
