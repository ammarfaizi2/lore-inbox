Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315506AbSECA2j>; Thu, 2 May 2002 20:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315509AbSECA2i>; Thu, 2 May 2002 20:28:38 -0400
Received: from [195.63.194.11] ([195.63.194.11]:43537 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315506AbSECA2h>; Thu, 2 May 2002 20:28:37 -0400
Message-ID: <3CD1CAFE.3010109@evision-ventures.com>
Date: Fri, 03 May 2002 01:25:50 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
In-Reply-To: <802.1020382834@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Keith Owens napisa?:

> I know how to do ABI versioning right.  But there is no chance of me
> starting work on the correct method of ABI versioning until kbuild 2.5
> is in.

It's shown in the syscall part of the kernel :-) Just don't provide
a too big ABI and stick to it is one possible strategy.

And of course I'm sure you recognize that what we could use is ABI *checking*
and not ABI *versioning* thingee. If one really really want's to do this the
only true one way, well the solution is.... for example CORBA IDL and stuff
if you divide the remote part of CORBA out.

And hell I'm not expecting an ORB to appear in the kernel any time soon.
(However I remember someone once implementid such a beast...)


