Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266553AbSK1RrC>; Thu, 28 Nov 2002 12:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266564AbSK1RrC>; Thu, 28 Nov 2002 12:47:02 -0500
Received: from khms.westfalen.de ([62.153.201.243]:23514 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S266553AbSK1RrB>; Thu, 28 Nov 2002 12:47:01 -0500
Date: 28 Nov 2002 18:53:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8aiMdRMXw-B@khms.westfalen.de>
In-Reply-To: <200211281625.gASGPo804227@work.bitmover.com>
Subject: Re: connectivity to bkbits.net?
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <200211281625.gASGPo804227@work.bitmover.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lm@bitmover.com (Larry McVoy)  wrote on 28.11.02 in <200211281625.gASGPo804227@work.bitmover.com>:

> We've been having problems getting out to certain parts of the net for the
> last few days, in particular, we can't get to sgi.com which is unusual.
> If you are having problems getting to bkbits.net, let me know.  We have
> a couple of machines at rackspace and I can push repos over there.
>
> traceroute to sgi.com (128.167.58.40), 30 hops max, 38 byte packets
>  1  bitmover (10.3.9.3)  0.535 ms  0.103 ms  0.100 ms
>  2  cisco (192.132.92.1)  1.236 ms  1.175 ms  1.228 ms
>  3  s9-1-1-6-0.ar2.SFO1.gblx.net (64.214.96.229)  3.080 ms  3.205 ms  2.982
> ms  4  64.215.195.189 (64.215.195.189)  3.052 ms  3.256 ms  3.114 ms
>  5  64.211.147.86 (64.211.147.86)  4.592 ms  4.623 ms  4.468 ms
>  6  so6-0-0-2488M.br2.PAO2.gblx.net (207.136.163.126)  4.586 ms  4.530 ms
> 4.701 ms  7  p4-0.paix-bi1.bbnplanet.net (4.0.6.81)  4.627 ms  4.467 ms
> 4.427 ms  8  p6-0.snjpca1-br1.bbnplanet.net (4.24.7.61)  5.179 ms  5.678 ms
> 5.215 ms  9  p1-0.sjccolo-dbe1.bbnplanet.net (4.24.6.253)  5.431 ms  5.214
> ms  5.235 ms 10  vlan40.sjccolo-isw03-rc1.bbnplanet.net (128.11.200.91)
> 5.326 ms  5.396 ms  5.464 ms 11  128.11.16.169 (128.11.16.169)  5.581 ms
> 5.470 ms  5.654 ms 12  *

>From two or three traceroutes, that problem seems to be at the SGI end. I  
can't get to them either (nothing after the same IP as for you, at hop  
#17, some place at Genuity), but you are practically next door.

MfG Kai
