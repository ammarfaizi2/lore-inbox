Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312095AbSCXWtl>; Sun, 24 Mar 2002 17:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312093AbSCXWtb>; Sun, 24 Mar 2002 17:49:31 -0500
Received: from [195.63.194.11] ([195.63.194.11]:64267 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312095AbSCXWtR>; Sun, 24 Mar 2002 17:49:17 -0500
Message-ID: <3C9E5787.8040202@evision-ventures.com>
Date: Sun, 24 Mar 2002 23:47:35 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Dave Zarzycki <dave@zarzycki.org>
CC: John Langford <jcl@cs.cmu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, ahaas@neosoft.com
Subject: Re: BUG: 2.4.18 & ALI15X3 DMA hang on boot
In-Reply-To: <Pine.LNX.4.33.0203231148570.1199-100000@yuna.zarzycki.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Zarzycki wrote:
> On Sat, 23 Mar 2002, Martin Dalecki wrote:
> 
> 
>>John Langford wrote:
>>
>>>>But before could you just tell the m5229_revision value
>>>>on your system?
>>>
>>>I'm not sure what you mean.  Certainly, lspci says:
>>>
>>>>00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3)
>>>
>>That's it. Thank you.
> 
> 
> To add another data-point, I've been seeing the same problem on a rev c4 
> version of device.


Thank's - that makes the picture complete.

