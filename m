Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312354AbSDJKGx>; Wed, 10 Apr 2002 06:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312370AbSDJKGw>; Wed, 10 Apr 2002 06:06:52 -0400
Received: from [195.63.194.11] ([195.63.194.11]:48145 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312354AbSDJKGv>; Wed, 10 Apr 2002 06:06:51 -0400
Message-ID: <3CB40036.7010504@evision-ventures.com>
Date: Wed, 10 Apr 2002 11:04:54 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][CFT] IDE TCQ #2
In-Reply-To: <20020409124417.GK25984@suse.de> <3CB3FDF7.6010505@evision-ventures.com> <20020410095829.GG2485@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Apr 10 2002, Martin Dalecki wrote:
> 
>>Jens Axboe wrote:
>>
>>>Hi,
>>>
>>>Version 2 is ready. Changes since last time:
>>
>>Hi,
>>
>>OK I have managed to merge this with the 2.5.8-pre2 + ide-29b at home.
>>However since we have now apparently already a -pre3 I will have
>>to at least redo the patches against it. If this takes more
>>then the time needed for a cup of coffe I will have unfortuntely to
>>do it today afternoon.
> 
> 
> I'm already running 2.5.8-pre3 (which appears to include ide-29b,
> right?) + ide-tcq here, so you should probably not waste any effort on
> that :-)

Well than I will have to basically redo all the
stuff I did in between... like for example nuking the
number of parameters to ata_taskfile()... :-(.

> I'll post an updated patch later today.

Fine.


