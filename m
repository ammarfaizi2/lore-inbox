Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbULaJ5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbULaJ5Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 04:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbULaJ5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 04:57:16 -0500
Received: from mail.portrix.net ([212.202.157.208]:27787 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261832AbULaJ5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 04:57:12 -0500
Message-ID: <41D52275.8030100@ppp0.net>
Date: Fri, 31 Dec 2004 10:57:09 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.6.10-ac1
References: <1104103881.16545.2.camel@localhost.localdomain> <200412300005.31211.gene.heskett@verizon.net> <1104430176.2446.3.camel@localhost.localdomain> <200412302006.19872.gene.heskett@verizon.net>
In-Reply-To: <200412302006.19872.gene.heskett@verizon.net>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> On Thursday 30 December 2004 18:38, Alan Cox wrote:
> 
> Thanks for the reply Alan, I appreciate it.
> 
> 
>>On Iau, 2004-12-30 at 05:05, Gene Heskett wrote:
>>
>>>some sort of an error message that looks like it may be memory
>>>related.  There's a pair of half giggers in here, running at 333
>>>fsb, but they are supposedly rated for a 400 mhz fsb. Thats
>>>presumably because I have turned on the MCE stuffs.
>>
>>MCE's generally come from the processor. To decode it you need to
>>know what CPU and then get the manuals out and decode the bits.
>>

Here is a tool for it: (parsemce.c)

http://www.kernel.org/pub/linux/kernel/people/davej/tools/

Though I do not know for which processors it is supposed to work.

Jan
