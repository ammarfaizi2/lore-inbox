Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291051AbSAaMxR>; Thu, 31 Jan 2002 07:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291052AbSAaMxH>; Thu, 31 Jan 2002 07:53:07 -0500
Received: from [195.63.194.11] ([195.63.194.11]:44811 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291051AbSAaMw4>; Thu, 31 Jan 2002 07:52:56 -0500
Message-ID: <3C593E19.1070309@evision-ventures.com>
Date: Thu, 31 Jan 2002 13:52:41 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: David Weinehall <tao@acc.umu.se>
CC: Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <3C59353F.3080208@evision-ventures.com> <Pine.LNX.4.33.0201311515350.9106-100000@localhost.localdomain> <20020131132830.W1735@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:

>On Thu, Jan 31, 2002 at 03:17:52PM +0100, Ingo Molnar wrote:
>
>>On Thu, 31 Jan 2002, Martin Dalecki wrote:
>>
>>>And then we are still just discussing here how to get things IN. But
>>>there apparently currently is nearly no way to get things OUT of the
>>>kernel tree. Old obsolete drivers used by some computer since
>>>archeologists should be killed (Atari, Amiga, support, obsolete
>>>drivers and so on). Just let *them* maintains theyr separate kernel
>>>tree...
>>>
>>'old' architectures do not hinder development - they are separate, and
>>they have to update their stuff. (and i think the m68k port is used by
>>many other people and not CS archeologists.) Old drivers are not a true
>>problem either - if they dont compile that's the problem of the
>>maintainer. Occasionally old drivers get zapped (mainly when there is a
>>new replacement driver).
>>
>
>To testify that even really old hardware is used, I recently received a
>patch for 2.0.xx to add autodetection for wd1002s-wx2 in the
>xd.c-driver. Not particularly recent hardware, but the person who sent
>the patch uses it. Why deny him usage of his hardware when it doesn't
>intrude upon the rest of the codebase?
>

He should feel free to use the 2.0.xx kernel up no end. Nobody denys it 
to him. But from the mainline
it all should get out of the sight for the developement.

