Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293492AbSCFMBj>; Wed, 6 Mar 2002 07:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293493AbSCFMB2>; Wed, 6 Mar 2002 07:01:28 -0500
Received: from [195.63.194.11] ([195.63.194.11]:35847 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S293492AbSCFMBK>; Wed, 6 Mar 2002 07:01:10 -0500
Message-ID: <3C86049F.1030800@evision-ventures.com>
Date: Wed, 06 Mar 2002 12:59:27 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: benh@kernel.crashing.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
In-Reply-To: <Pine.LNX.4.44.0203061307310.2839-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Wed, 6 Mar 2002, Martin Dalecki wrote:
> 
> 
>>1. Indeed the code quality found there is *excellent* nothing comparable
>>    with the messy crude found currently in linux.
>>
> 
> I thought you stated that no one else was using something similar? Or 
> were you refererring to the userland accessible ioctls? I believe 
> FreeBSD-CURRENT might also have something in the works.

I was referring to the userland accessible ioctls going through
HDIO_DRIVE_TASKFILE - a recent introduction in 2.5.3. And I didn't
found anything comparable in the Apple code.
After looking at the code I can actually assure you that FreeBSD-CURRENT
does not contain anything comparable to this.



