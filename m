Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272985AbRIIRO5>; Sun, 9 Sep 2001 13:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272983AbRIIROs>; Sun, 9 Sep 2001 13:14:48 -0400
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:2567 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S272929AbRIIROl>;
	Sun, 9 Sep 2001 13:14:41 -0400
Message-ID: <3B9BA3C1.7050202@si.rr.com>
Date: Sun, 09 Sep 2001 13:15:45 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: LOADLIN and 2.4 kernels
In-Reply-To: <3B99BCF4.4050506@transmeta.com> <20010908122611.A27775@willow.seitz.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Very interesting.  I've managed to get a decent number of machines booting via
> DOS and loadlin with 2.4 kernels.  I happen to be using kernels in the 2.4.7-ac
> range.


I was able to boot a recent 2.4.x kernel that was less than the floppy 
size requirement. Kernels greater than that size will automatically 
reboot my machine (using the Win95 Command Prompt Only option + LOADLIN 
1.6a). My last recorded 2.4.x kernel to boot with a size greater than a 
floppy is 2.4.5-ac17, which is very close the size of the recent kernels 
). The same .config has been used with the recent 2.4.x kernels as 
2.4.5-ac17 (minor additions for new fs supports). The power management 
option is not enabled.

Regards,
Frank

> 
> I've got it going on all various sorts of hardware.  If you need some info, just
> ask.
> 
> Ross Vandegrift
> ross@willow.seitz.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


