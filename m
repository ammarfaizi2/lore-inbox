Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWBZSK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWBZSK7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 13:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWBZSK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 13:10:59 -0500
Received: from av10-1-sn2.hy.skanova.net ([81.228.8.181]:54974 "EHLO
	av10-1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751377AbWBZSK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 13:10:58 -0500
X-Spam-Score: -3.8
Message-ID: <4401EF2C.2000004@fulhack.info>
Date: Sun, 26 Feb 2006 19:10:52 +0100
From: Henrik Persson <root@fulhack.info>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Warne <nick@linicks.net>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Mark Lord <lkml@rtr.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: hda: irq timeout: status=0xd0 DMA question
References: <200602261308.47513.nick@linicks.net> <4401E06D.90305@rtr.ca> <9a8748490602260917h31883941qa46dea626276d389@mail.gmail.com> <200602261720.34062.nick@linicks.net>
In-Reply-To: <200602261720.34062.nick@linicks.net>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Warne wrote:
> On Sunday 26 February 2006 17:17, Jesper Juhl wrote:
> 
> 
>>>But perhaps someone may successfully implement this.
>>
>>Unfortunately my machines only have SCSI devices, so I'd have no way
>>to actually test a patch, otherwise I'd be happy to give it a shot - a
>>parameter to disable the behaviour shouldn't be too difficult to
>>implement, and if the default stays as the current behaviour then it
>>shouldn't be too controversial.
>>I wouldn't mind trying to hack up a patch, but it would be untested...
> 
> 
> Post it to me - but look at my original post - this is/was on kernel 2.4.32.  
> I have yet to see such output on 2.6.x series kernels.

I get those on 2.6.x.

Does happen once or twice a year.. Probably something funky with the
cabling or some power-related issues.

Anyway, I would be happy if the IDE driver would "just not do that". :)

--
Henrik Persson
