Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVCKXka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVCKXka (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 18:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVCKXgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 18:36:03 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:37540 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S261820AbVCKXdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 18:33:45 -0500
Date: Fri, 11 Mar 2005 18:33:42 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.11.2
In-reply-to: <4231F019.5080006@tmr.com>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503111833.42582.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050309083923.GA20461@kroah.com>
 <200503100754.14711.gene.heskett@verizon.net> <4231F019.5080006@tmr.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 March 2005 14:23, Bill Davidsen wrote:
>Gene Heskett wrote:
>> Somewhat Greg, it caught me out.  OTOH, once we know that .2 needs
>> .1, we'll be ok.  And it does give a quick method for us frogs to
>> define if one of them is a regression.  The only thing that should
>> break if we leave one out of the squence is the EXTRAVERSION path
>> in the Makefile & we can certainly fix that easily enough for
>> testing.
>
>2nd that, I'm so delighted to have -stable that I will happily
> accept patches of what ever type you find easiest to produce, in
> this case sequential incrementals. Just don't screw the process by
> changing it, we can cope! Anyone who can't figure out how to
> generate the single big diff against mainline shouldn't be patching
> kernels ;-)

Humm, that might be a pretty high fence for me to jump there Bill.  
ATM, what I'm running is 11.2, with the bk-ieee1394.patch, and for my 
uses, it certainly seems to be bulletproof.  But then I'm not running 
a server with 30,000 clients either, this is your classic geeks 
desktop here, even if the geek is 70 years old.  Firewire Just 
Works(TM), usb seems to be back among the living and I'm a relatively 
happy camper.  Till the next patch comes out & I'll just *have* to 
try it...  :)

Heck, if the next .3 patch just was a relabeled bk-ieee1394.patch, I'd 
be in Hog Heaven.  And if the next patch after that made my 
pcHDTV-3000 card work out of the box,  I'd offer the patch maker a 
couple of his favorite libations.  Hows that for a good deal?  So 
far, thats a re-install after every reboot situation now because the 
replacement modules are built out of the tree.

>> Question?  Is it a given that these, if they don't have warts,
>> will be in mainline 2.6.12?
>
>I think Linus noted his intention to grab the fixes he likes. That's
> not a determanent process by any means ;-)

We've noted that previously.  OTOH, he has always managed to come up 
with perfectly valid objections to those not accepted if queried 
about the whynots.  I can't argue with that for a heartbeat since I 
don't and cannot come close to having an overall view in as much 
detail as he obviously keeps in his head.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
