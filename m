Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSE2QpO>; Wed, 29 May 2002 12:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313638AbSE2QpN>; Wed, 29 May 2002 12:45:13 -0400
Received: from [195.63.194.11] ([195.63.194.11]:1288 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S313563AbSE2QpM>;
	Wed, 29 May 2002 12:45:12 -0400
Message-ID: <3CF4F7E8.2020300@evision-ventures.com>
Date: Wed, 29 May 2002 17:46:48 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Gerald Champagne <gerald@io.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.18 IDE 73
In-Reply-To: <1022680784.2945.24.camel@wiley> <3CF4D19F.9080402@evision-ventures.com> <20020529183343.A19610@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Wed, May 29, 2002 at 03:03:27PM +0200, Martin Dalecki wrote:
> 
> 
>>BTW> The next thing to be gone is simple the fact that we drag
>>around the id information permanently, where infact only
>>some capabilitie fields are sucked out of it and the
>>device identification string is only needed for reporting
>>during boot-up.
> 
> 
> Also for black/whitelists. And we're going to need those, though maybe
> the current data in them is not worth much.


Indeed thanks for the reminder. However as far as I'm concerned
I would rather agree that the data currently present in those
black/whitelists is basically useless. Most of the disks
present there are simple plain just obsoleted by a great margin
or have already dyed due to the severe firmware errors they did contain.
And finally this data was basically collected during the fortunately
long bast days where cmd64x chips where prevalent on VLB 486 systems.
It's most propably not accurate for more modenr ATA host chip cells.

