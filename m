Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbUBTSTw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 13:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbUBTSTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 13:19:51 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.135.30]:15621 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S261275AbUBTSTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 13:19:00 -0500
Date: Sat, 21 Feb 2004 03:20:06 +0900 (JST)
Message-Id: <20040221.032006.68375681.yoshfuji@linux-ipv6.org>
To: andrew@walrond.org, netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.3 : [eth0: Too much work at interrupt,
 status=0x00000001.]
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200402201803.12146.andrew@walrond.org>
References: <200402201803.12146.andrew@walrond.org>
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

In article <200402201803.12146.andrew@walrond.org> (at Fri, 20 Feb 2004 18:03:11 +0000), Andrew Walrond <andrew@walrond.org> says:

> I'm getting loads of these messages in dmesg.
> 
> This is a vanilla 2.6.3 kernel with ACPI disabled with acpi=off boot 
> parameter. No preempt, APIC and IOAPIC enabled
> 
> Its a single 2Ghz celeron with Via chipset and Rhine II ethernet. It is under 
> no load at all. ssh only.
> 
> dmesg is short and follows; Any knowledge apprieciated!
:
> eth0: Too much work at interrupt, status=0x00000001.

I've got this several times, randomly, and
I had to go to the console to reboot the machine.

Well, sorry, I haven't tracked it down yet...

Others?

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
