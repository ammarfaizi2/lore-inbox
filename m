Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313202AbSHFQmZ>; Tue, 6 Aug 2002 12:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313305AbSHFQmZ>; Tue, 6 Aug 2002 12:42:25 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:59622 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S313202AbSHFQmZ>;
	Tue, 6 Aug 2002 12:42:25 -0400
Message-ID: <3D4FFD23.5010707@candelatech.com>
Date: Tue, 06 Aug 2002 09:45:23 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre1
References: <Pine.LNX.4.44.0208060832090.6811-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> On Mon, 5 Aug 2002, Ben Greear wrote:
> 
> 
>>Marcelo Tosatti wrote:
>>
>>>So here goes -pre1, with a big -ac and x86-64 merges, plus other smaller
>>>stuff.
>>>
>>>2.4.20 will be a much faster release cycle than 2.4.19 was.
>>
>>Two questions:  I see change logs about NAPI going in, and then
>>NAPI being removed.  I assume it is removed...but maybe it will
>>be back soon?
> 
> 
> I want arguments from Davem to include NAPI. Changing the drivers is a
> reason for me to _not_ want it in.
> 
> But lets see if Davem can convince me ;)

Well, I hope he does, and I hope it really works :)

The patch I was looking for was the pre-patch you put out.
I see it's on kernel.org now, so no problem there.

Ben
> 
> 
>>Second:  Where is the patch?  I looked on kernel.org and didn't
>>find it.  If it's going to be there shortly, that's fine, I'll
>>keep checking back.
> 
> 
> Maybe at davem's CVS repo?
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


