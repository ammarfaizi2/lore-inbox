Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264058AbUGLWsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbUGLWsh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 18:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUGLWsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 18:48:37 -0400
Received: from [203.178.140.15] ([203.178.140.15]:35846 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S264058AbUGLWsg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 18:48:36 -0400
Date: Tue, 13 Jul 2004 07:48:40 +0900 (JST)
Message-Id: <20040713.074840.92140725.yoshfuji@linux-ipv6.org>
To: cra@WPI.EDU
Cc: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: v2.6 IGMPv3 implementation
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20040712222713.GK7822@angus.ind.WPI.EDU>
References: <20040712203056.GI7822@angus.ind.WPI.EDU>
	<20040712140409.3575b900.davem@redhat.com>
	<20040712222713.GK7822@angus.ind.WPI.EDU>
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

In article <20040712222713.GK7822@angus.ind.WPI.EDU> (at Mon, 12 Jul 2004 18:27:13 -0400), "Charles R. Anderson" <cra@WPI.EDU> says:

> Another thing I noticed.  Which is better, __u32 or struct in_addr and
> int?  Both are used in include/linux/in.h for what appear to be the
> same objects:

Please refer standards (e.g. RFC3678).

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
