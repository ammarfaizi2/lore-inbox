Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261452AbTC0WTP>; Thu, 27 Mar 2003 17:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261453AbTC0WTP>; Thu, 27 Mar 2003 17:19:15 -0500
Received: from [12.242.167.130] ([12.242.167.130]:42368 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id <S261452AbTC0WTL>; Thu, 27 Mar 2003 17:19:11 -0500
Message-ID: <3E837B7D.9010005@comcast.net>
Date: Thu, 27 Mar 2003 14:30:21 -0800
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030326
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bongani Hlope <bonganilinux@mweb.co.za>
Cc: thunder7@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: vesafb problem
References: <3E8329D2.7040909@comcast.net> <20030327190222.GA4060@middle.of.nowhere> <3E835241.9060407@comcast.net> <20030327233902.5963b0b1.bonganilinux@mweb.co.za>
In-Reply-To: <20030327233902.5963b0b1.bonganilinux@mweb.co.za>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bongani Hlope wrote:

> Strange I'm having the same problem, but I only have 256MB of memory and my GeForce 2 only has 32MB. This is what's on my messages file:
> 
> 
> vesafb: framebuffer at 0xe0000000, mapped to 0xd0807000, size 32768k
> vesafb: mode is 800x600x16, linelength=1600, pages=3
> vesafb: protected mode interface info at c000:c060
> vesafb: scrolling: redraw
> vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
> Looking for splash picture.... found (800x600, 13683 bytes).
> Console: switching to colour frame buffer device 82x30
> fb0: VESA VGA frame buffer device
> 

Hmmm. That's a different problem than I'm experiencing. Your system 
appears to be correctly remapping the framebuffer and switching to it. 
You don't get a graphical boot? Seems as if you should from the log 
snippet you posted.

-Walt

