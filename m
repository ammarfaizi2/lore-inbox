Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289484AbSCLQqV>; Tue, 12 Mar 2002 11:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311285AbSCLQoz>; Tue, 12 Mar 2002 11:44:55 -0500
Received: from [195.63.194.11] ([195.63.194.11]:59914 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S289484AbSCLQo2>; Tue, 12 Mar 2002 11:44:28 -0500
Message-ID: <3C8E3025.4070409@evision-ventures.com>
Date: Tue, 12 Mar 2002 17:43:17 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <E16kYXz-0001z3-00@the-village.bc.nu> <Pine.LNX.4.33.0203111431340.15427-100000@penguin.transmeta.com> <20020311234553.A3490@ucw.cz> <3C8DDFC8.5080501@evision-ventures.com> <20020312165937.A4987@ucw.cz> <3C8E28A1.1070902@evision-ventures.com> <20020312172134.A5026@ucw.cz> <3C8E2C2C.2080202@evision-ventures.com> <20020312173301.C5026@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Tue, Mar 12, 2002 at 05:26:20PM +0100, Martin Dalecki wrote:
> 
>>Vojtech Pavlik wrote:
>>
>>
>>
>>>Well, as much as I'd like to use safe pre-computed register values for
>>>the chips, that ain't possible - even when we assumed the system bus
>>>(PCI, VLB, whatever) was always 33 MHz, still the drives have various
>>>ideas about what DMA and PIO modes should look like, see the tDMA and
>>>tPIO entries in hdparm -t.  
>>>
>>Yes yes yes of course some of the drivers are confused. And I don't
>>argue that precomputation is adequate right now. It just wasn't for
>>the CMD640 those times... I only wanted to reffer to history and
>>why my timings where different then the computed.
>>
> 
> We may want to compare your original timings to what ide-timing.[ch]
> will compute ...

Unfortunately there is no chance. I have abondony this board quite
happy a long time ago... It was an 486 and I don't keep old
shread around. Sorry I just don't have it at hand anylonger.


