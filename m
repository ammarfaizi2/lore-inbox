Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVCARQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVCARQj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 12:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVCARQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 12:16:39 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:57869 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261983AbVCARQg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 12:16:36 -0500
Date: Wed, 02 Mar 2005 02:18:02 +0900 (JST)
Message-Id: <20050302.021802.71004233.yoshfuji@linux-ipv6.org>
To: lm@bitmover.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: bkbits.net down?
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20050301165415.GA1990@bitmover.com>
References: <20050302.010010.132894644.yoshfuji@linux-ipv6.org>
	<20050301165415.GA1990@bitmover.com>
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

In article <20050301165415.GA1990@bitmover.com> (at Tue, 1 Mar 2005 08:54:15 -0800), lm@bitmover.com (Larry McVoy) says:

> No, sorry.  We're working on the tarball+patch server we talked about about
> a couple years back and I screwed up the http server.  The bk:// urls work,
> please use them until I fix this, should be quick.

Okay, thanks. But bk:// urls does not seem to work, unfortunately.

|% bk pull
|Pull bk://linux.bkbits.net:8080/linux-2.5
|  -> file://home2/yoshfuji/BitKeeper/linux-2.6
|% 

No message like "nothing to pull."

Anyway, it's time to sleep for me. ZZZzzz...

> 
> On Wed, Mar 02, 2005 at 01:00:10AM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@ wrote:
> > Hello.
> > 
> > *.bkbits.net (port 8080) seems to reply with no data.
> > And "bk pull" on linux-2.5 also fails.
> > Is this scheduled?
> > 
> > Thank you.
> > 
> > --yoshfuji
> 
> -- 
> ---
> Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
