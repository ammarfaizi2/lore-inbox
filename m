Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBPNOT>; Fri, 16 Feb 2001 08:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129069AbRBPNOA>; Fri, 16 Feb 2001 08:14:00 -0500
Received: from mail.netgem.com ([195.154.83.81]:7954 "EHLO netgem.com")
	by vger.kernel.org with ESMTP id <S129027AbRBPNN5>;
	Fri, 16 Feb 2001 08:13:57 -0500
From: Jocelyn Mayer <jocelyn.mayer@netgem.com>
To: lkthomas@hkicable.com, linux-kernel@vger.kernel.org
Message-ID: <3A8D2763.9080102@netgem.com>
Date: Fri, 16 Feb 2001 14:13:07 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; 0.7) Gecko/20010119
X-Accept-Language: en, fr
MIME-Version: 1.0
Subject: Re: finding Tekram SCSI dc395U linux patch driver:
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> Well, I think it should add to normal kernel and do not need to patch, 
> Thanks
> 
> also, why this driver still stick in ac3?
> and where can I find the new version of this patch?
> I think mandrake was improved that driver, Thanks
> 
I'm not so sure...
I've been using this driver for a long time,
and there still are kernel Ooops and hangs
with the 1.32 driver...
Actually, it's quite stable, but only with 5 M
speed. It's a pity when your card can drive
a SCSI bus up to 40 M/s....
But, even with that speed, I got problems
from time to time....

So, you should take a good care of what you do...
But, maybe it shold be integrated into the kernel
so a lot of people could test and (maybe) debut it...

Jocelyn Mayer.

> 
