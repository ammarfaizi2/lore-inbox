Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315167AbSFELN2>; Wed, 5 Jun 2002 07:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315335AbSFELN1>; Wed, 5 Jun 2002 07:13:27 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:7187 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S315167AbSFELN1>; Wed, 5 Jun 2002 07:13:27 -0400
Message-ID: <3CFDF2CE.3070307@loewe-komp.de>
Date: Wed, 05 Jun 2002 13:15:26 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: J Sloan <joe@tmsusa.com>, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
In-Reply-To: <Pine.LNX.4.44.0206041418460.2614-100000@waste.org> <E17FQPj-0001Rr-00@starship> <3CFD8C07.6030607@tmsusa.com> <E17FS6T-0001UR-00@starship>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> On Wednesday 05 June 2002 05:56, J Sloan wrote:
> 
>>Daniel Phillips wrote:
>>
>>
>>>If I recall correctly, XFS makes an attempt to provide such realtime 
>>>guarantees, or at least the Solaris version does. 
>>>
>>>
>>When did Solaris ever support xfs?
>>
>>
>>>However, the operating 
>>>system must be able to provide true realtime guarantees in order for the 
>>>filesystem to provide them, and I doubt that the combination of XFS and 
>>>Solaris can do that.
>>>
>>>
>>no, but the combination of xfs and irix has
>>
>                                      ^^^^			
> Heh, I can only protest that Oxymoron also missed that thinko..
> 
> 
>>made a lot of folks happy -  and xfs/linux is coming along nicely as
>>well...
>>
> 
> Improving the average latency of systems is a worthy goal, and there's
> no denying that 'sorta realtime' has its place, however it's no substitute
> for the real thing.  A soft realtime system screws up only on occasion,
> but - bugs excepted - a hard realtime system *never* does.
> 

Yes, in theory. You define hard realtime system in a clean room.
Even QNX4 couldn't provide hard realtime when creating new processes.
You had to start them beforehand - so you needed good system design.
The OS is just a small part of that.

Even vxworks had problems with priority inversion ... and so on.







