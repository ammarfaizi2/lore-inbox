Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbTDLXfu (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 19:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbTDLXfu (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 19:35:50 -0400
Received: from ca-fulrtn-cuda2-c6a-113.anhmca.adelphia.net ([68.66.9.113]:32896
	"EHLO shrike.mirai.cx") by vger.kernel.org with ESMTP
	id S262526AbTDLXft (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 19:35:49 -0400
Message-ID: <3E98A597.6000507@tmsusa.com>
Date: Sat, 12 Apr 2003 16:47:35 -0700
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joshua Kwan <joshk@triplehelix.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bug: slab corruption in 2.5.67-mm1
References: <3E988DA2.4080600@tmsusa.com> <20030412232425.GA24920@triplehelix.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Kwan wrote:

>On Sat, Apr 12, 2003 at 03:05:22PM -0700, J Sloan wrote:
>  
>
>>I had run 2.5.67-mm1 for some days and for
>>the most part it ran well in it's duties as dns,
>>squid, vpn/firewall and postfix server, with
>>the only oddity being the ide messages which
>>I reported earlier.
>>    
>>
>
>You're insane running a -mm kernel on a production machine, IMHO.
>
Oh please.

This is my network, and there is nothing
insane about it - FYI the stock 2.4.18 RH
kernel had severe stability problems on
this system - OTOH 2.5.67-mm1 is like
the rock of gibraltar in comparison.

:-)

>They're good for desktop use but in my experience anything that needs to
>stay up for more than a few days should at LEAST use one of the
>stability-oriented patches like -mjb or -osdl, if not the vanilla
>kernel.
>
Sorry,  -mm fixes a number of bugs that
render the vanilla kernel unusable for me.

>2.5-mm typically goes nuts with such errors as you described after a
>few days of uptime, as far as I've seen and noticed. These bugs will
>probably eventually be fixed, but at this time, it's still unstable.
>
By running 2.5 and reporting, maybe we
can help expose those bugs - but since .65
or so, I haven't really seen any show stopper
issues - everything works, and works well,
on my particular hardware, and workload.

>
>I wouldn't run anything above 2.4.20 on a box that does what you
>describe..
>  
>
My clients get official vendor kernels, but
in the sanctity of my own domain I run the
latest and greatest and take a look at what's
coming - what I'm running today is a sneak
preview of what my clients will be running
tomorrow.

Joe

