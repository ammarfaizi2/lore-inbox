Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284138AbSAHKBJ>; Tue, 8 Jan 2002 05:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283783AbSAHKA7>; Tue, 8 Jan 2002 05:00:59 -0500
Received: from tmhoyle.gotadsl.co.uk ([195.149.46.162]:8 "EHLO mail.cvsnt.org")
	by vger.kernel.org with ESMTP id <S283340AbSAHKAt>;
	Tue, 8 Jan 2002 05:00:49 -0500
Mailbox-Line: From tmh@nothing-on.tv  Tue Jan  8 10:00:45 2002
Message-ID: <3C3AC361.20302@nothing-on.tv>
Date: Tue, 08 Jan 2002 10:01:05 +0000
From: Tony Hoyle <tmh@nothing-on.tv>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020105
MIME-Version: 1.0
To: Anthony DeRobertis <asd@suespammers.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_HIMEM instability?
In-Reply-To: <A44AD072-0364-11D6-BB09-00039355CFA6@suespammers.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony DeRobertis wrote:

>> Unfortunately memtest86 is incompatible with this mobo, but the memory 
>> checks out on another machine I tried it on, so I expect it's OK.
> 


I've had no other instablility problems, and downgrading gkrellm to the 
previous version seems to have stopped it dying.  Mozilla started being 
very unstable at the same time..  it could just be a coincidence that 
they all happened at the same time.


> I've had DIMMs not get along. So have other people. This little tester 
> seems to find that fairly well, stunningly --- even when Memtest86 can't 
> find them at all. It found mine in about 30min (512mb box); another 
> persons in an hour or two.


I'll run it & see if anything fails.

 
> PS: You did report the failure to the memtest86 people, right?


Their website says not to report bugs unless you're prepared to do a 
fair bit of debugging yourself.  It also says individual problems won't 
normally be dealt with...  I took the hint and didn't bother.

Tony





