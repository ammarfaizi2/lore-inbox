Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263112AbTIGEmY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 00:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbTIGEmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 00:42:24 -0400
Received: from static-ctb-210-9-247-166.webone.com.au ([210.9.247.166]:44037
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S263112AbTIGEmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 00:42:19 -0400
Message-ID: <3F5AB71C.5060904@cyberone.com.au>
Date: Sun, 07 Sep 2003 14:42:04 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Ed Sweetman <ed.sweetman@wmich.edu>, Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy v12
References: <3F58CE6D.2040000@cyberone.com.au> <195560000.1062788044@flay> <20030905202232.GD19041@matchmail.com> <207340000.1062793164@flay> <3F5935EB.4000005@cyberone.com.au> <6470000.1062819391@[10.10.2.4]> <3F5980CD.2040600@cyberone.com.au> <139550000.1062861227@[10.10.2.4]> <3F59C956.5050200@wmich.edu> <146640000.1062902095@[10.10.2.4]>
In-Reply-To: <146640000.1062902095@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin J. Bligh wrote:

>>All of this basing scheduling performance on a bloated wannabe winamp 
>>makes as much sense as gauging car performance using a van.   If this 
>>was a purely scheduling problem, then why do other players like 
>>alsaplayer and such not suck as bad as xmms when under the exact same 
>>priority and all?  At least use something without a frontend so that 
>>you can limit the possibility that the programmers did something stupid 
>>like make decoding dependent on some update to the gui. 
>>xmms was coded first and foremost to look and work like winamp. 
>>Streamlined - even low latency performance was not a base goal.  
>>
>
>The reality is that people use xmms, and whilst it may not be the greatest
>program known to man, I don't believe it's *that* fundamentally screwed up
>that it should skip under normal desktop loads. *Especially* if it worked
>fine under 2.4 ;-)
>

I agree with Martin here. xmms may not be the smartest music player,
but its really sad if it skips on a P4 or Athlon.


