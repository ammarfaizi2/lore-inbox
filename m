Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbTEMDCL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 23:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbTEMDBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 23:01:20 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:32005 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S263182AbTEMDAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 23:00:46 -0400
Date: Tue, 13 May 2003 12:13:53 +0900 (JST)
Message-Id: <20030513.121353.47478435.yoshfuji@linux-ipv6.org>
To: chris@wirex.com
Cc: davem@redhat.com, torvalds@transmeta.com, dhowells@redhat.com,
       linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] fix net/rxrpc/proc.c
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030512200530.I19432@figure1.int.wirex.com>
References: <20030512190036.B20068@figure1.int.wirex.com>
	<20030513.112656.112825273.yoshfuji@linux-ipv6.org>
	<20030512200530.I19432@figure1.int.wirex.com>
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

In article <20030512200530.I19432@figure1.int.wirex.com> (at Mon, 12 May 2003 20:05:30 -0700), Chris Wright <chris@wirex.com> says:

> * YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B (yoshfuji@linux-ipv6.org) wrote:
> > 
> > Sorry, it's my mistake.   David, please apply his patch.
> 
> Thanks, sorry, I should have Cc:'d you in the first place, my apology.
> Seems like the rxrpc_proc_calls_fops should get an owner as well?  (relative
> to the last patch)

Yes. Thanks for pointing out.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
