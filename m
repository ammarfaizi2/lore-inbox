Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314474AbSD1Tvr>; Sun, 28 Apr 2002 15:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314475AbSD1Tvq>; Sun, 28 Apr 2002 15:51:46 -0400
Received: from [195.63.194.11] ([195.63.194.11]:33030 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314474AbSD1Tvq>; Sun, 28 Apr 2002 15:51:46 -0400
Message-ID: <3CCC4426.3040303@evision-ventures.com>
Date: Sun, 28 Apr 2002 20:49:10 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [bk+patch] Let (WIP) be replaced with (EXPERIMENTAL)
In-Reply-To: <20020428142415.A10747@ucw.cz> <3CCBFAB6.7060607@evision-ventures.com> <20020428212429.A12005@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Vojtech Pavlik napisa?:
> On Sun, Apr 28, 2002 at 03:35:50PM +0200, Martin Dalecki wrote:
> 
> 
>>Uz.ytkownik Vojtech Pavlik napisa?:
>>
>>>ChangeSet@1.571, 2002-04-28 14:22:33+02:00, vojtech@twilight.ucw.cz
>>>  This removes the CONFIG_IDEDMA_PCI_WIP option, replacing it with
>>>  the more common CONFIG_EXPERIMENTAL. It also adds a depencency
>>>  on $CONFIG_EXPERIMENTAL where missing.
>>
>>
>>All fine and all will be taken. However please note that
>>I don't use BK and I don't intend too. My rejection of
>>it isn't based on any idiotic policy - I found it just ugly to
>>use and I was confused about the beta-alpha versions
>>offered on the web site - too much work in progress for my taste.
>>Finally I don't entrust source code to programmers who even don't know
>>the difference between TCP and UDP and use TCP becouse they don't know better.
> 
> 
> Ok - your decision. If you want, I'll omit the BK part of the patches.
> On the other hand, if you could just forward it to Linus as is (or let
> me send it to Linus after your confirmation), change comments won't get
> lost. 
> 
> 
>>I preferr a classical diff -urN ;-).
> 
> 
> It's included, anyway.

Yes but why the hell should I bother looking at some uu-encoded stuff?
Jet another reason I think BK is plain ugly.
Anyway. Please send the chipset parts to linus directly. They seem
fine. However the _WIP change is despite beeing correct, not complete
and I will prefer to do it myself. OK?

