Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbVL0W1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbVL0W1N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 17:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbVL0W1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 17:27:13 -0500
Received: from [204.225.94.109] ([204.225.94.109]:49421 "EHLO pcburn.com")
	by vger.kernel.org with ESMTP id S932378AbVL0W1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 17:27:12 -0500
Message-ID: <43B1BFB8.8050207@pcburn.com>
Date: Tue, 27 Dec 2005 17:27:04 -0500
From: Chris Bergeron <chris@pcburn.com>
Reply-To: chris@pcburn.com
Organization: PCBurn Media
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Gerhard Mack <gmack@innerfire.net>, linux-kernel@vger.kernel.org
Subject: Re: ati X300 support?
References: <Pine.LNX.4.64.0512261858200.28109@innerfire.net> <200512271545.31224.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0512271047260.2104@innerfire.net> <200512271603.30939.s0348365@sms.ed.ac.uk>
In-Reply-To: <200512271603.30939.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:

>On Tuesday 27 December 2005 15:57, Gerhard Mack wrote:
>  
>
>>I have it working in X.org with no problem.  I just can't get the drm
>>module working in the kernel.  Last time I tried to just add my PCI ids
>>the problem was a lack of PCIE support in the drm drivers.
>>    
>>
>
>I'd try again, I have a vague memory of reading a changelog a few releases ago 
>that mentioned PCIe support in radeon-drm.
>
>  
>
>>FYI the fglrx drivers suck badly.  ATI hasn't bothered to keep their
>>drivers up to date at all and the result is that they finally have
>>working 2.6.14 drivers but only for 32 bit machines.  x86_64 is still
>>broken on any recent kernel and it's been that way for months.  ATI's tech
>>support basically gave up after several days and just informed me it
>>wasn't really supported and there is nothing they could do for me.
>>    
>>
>
>You're better off running open source drivers anyway, it's less hassle, you 
>don't have to worry about every kernel upgrade breaking them, and it's only 
>an X300 anyway -- on my Mobility 9600, I just play a few small games and 
>expect OpenGL accelerated applications to work properly.
>
>If your goals are similar, they're probably achievable with mainline.
>
>  
>

The DRI project only supports up to the Radeon 9200 unless I missed an 
update and their page is outdated.  Check the DRI ATI page for details.

http://dri.freedesktop.org/wiki/ATI

Now.. the fglrx driver supposedly supports the X300, but if ATI won't 
support you on it that doesn't mean much, I guess. 

-- Chris
Editor, PCBurn.com
