Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbVFGT1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVFGT1o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 15:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVFGT1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 15:27:44 -0400
Received: from mail.dvmed.net ([216.237.124.58]:49870 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261969AbVFGT12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 15:27:28 -0400
Message-ID: <42A5F51B.5060909@pobox.com>
Date: Tue, 07 Jun 2005 15:27:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.12-rc6-mm1 & Chelsio driver
References: <20050607181300.GL2369@mail.muni.cz> <42A5EC7C.4020202@pobox.com> <20050607185845.GM2369@mail.muni.cz>
In-Reply-To: <20050607185845.GM2369@mail.muni.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek wrote:
> On Tue, Jun 07, 2005 at 02:50:36PM -0400, Jeff Garzik wrote:
> 
>>>should chelsio 10GE driver work in this kernel? If I do modprobe cxgb, 
>>>then it
>>>silently returns. No messages in log (dmesg) nor terminal and no new ethX 
>>>device is discoverred.
>>
>>I suppose you have Chelsio hardware?
> 
> 
> Yes :) 
> 
> Bus  2, device   3, function  0:
>     Ethernet controller: PCI device 1425:0006 (ASIC Designers Inc) (rev 0).
>       IRQ 24.
>       Master Capable.  Latency=248.  
>       Non-prefetchable 64 bit memory at 0xf6042000 [0xf6042fff].
> 
> 
> kernel 2.6.6 and driver from web site:
> Chelsio TOE Network Driver - version 2.1.0
> eth0: Chelsio T110 1x10GBaseX TOE (rev 1), PCIX 100MHz/64-bit
> eth0: 512MB SDRAM, 128MB FCRAM

I can't help much beyond this then :(  There should be Chelsio email 
addresses in the driver...

	Jeff


