Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313304AbSDYSVY>; Thu, 25 Apr 2002 14:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313305AbSDYSVX>; Thu, 25 Apr 2002 14:21:23 -0400
Received: from [195.63.194.11] ([195.63.194.11]:43270 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313304AbSDYSVV>; Thu, 25 Apr 2002 14:21:21 -0400
Message-ID: <3CC83A7B.40800@evision-ventures.com>
Date: Thu, 25 Apr 2002 19:18:51 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.10 IDE 41
In-Reply-To: <Pine.LNX.4.33.0203181243210.10517-100000@penguin.transmeta.com> <3CC8136B.2060705@evision-ventures.com> <20020425173908.GN3542@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Jens Axboe napisa?:
> On Thu, Apr 25 2002, Martin Dalecki wrote:
> 
>>Tue Apr 23 00:27:55 CEST 2002 ide-clean-41
>>
>>- Revoke the TCQ stuff. Well having it for some time showed just nicely what
>>  has to be done before it can be included cleanly. But it's just not ready
>>  jet.
> 
> 
> Again, you charge ahead instead of just getting it fixed... It's not a
> lot of work!

Unless you actually try too ;-).

> If you want to disable the TCQ stuff until this is fixed, fine, I have
> no objection to that. Completely ripping it out is a silly decision.

Again: what's the problem? - You still have it there at hand.
Nothing is lost.

> First you blast ahead and include even before I ask you or sent it to
> Linus myself, now you remove it without my consent as well. A bit of
> consistency would get you a long way.

