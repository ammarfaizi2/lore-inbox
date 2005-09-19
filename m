Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbVISEhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbVISEhl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 00:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVISEhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 00:37:41 -0400
Received: from mail.ctyme.com ([69.50.231.10]:18350 "EHLO newton.ctyme.com")
	by vger.kernel.org with ESMTP id S932170AbVISEhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 00:37:41 -0400
Message-ID: <432E4093.4060609@perkel.com>
Date: Sun, 18 Sep 2005 21:37:39 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl> <432DCE2A.5070705@slaphack.com> <432DDF7A.3050704@teleformix.com> <op.sxbtg9lzth1vuj@localhost>
In-Reply-To: <op.sxbtg9lzth1vuj@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Maindomain: perkel.com
X-Spam-filter-host: newton.ctyme.com - http://www.junkemailfilter.com
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



PFC wrote:

>
>
>> I'm of the same opinion.  If I have hardware that has a problem, and  
>> causes downtime, it gets replaced or repaired.  I don't switch to a  
>> different piece of software to compensate for broken hardware.
>>
>> With that said, I have seen ReiserFS expose hardware that had 
>> problems.   Hardware was repaired, and ReiserFS rides again.
>
>
>

Agreed - if the hardware has problem and anything is readable I'm happy. 
When I was sysadmin at EFF we got a bunch of IBM Deathstar drives - and 
for those who experiences this - every one of them fails. But they 
usually fail slowly. What amazed me was I would stat to see seek errors 
- sector not found and I would copy off everything I could onto a new 
drive before I lost anything. And - I thought it was amazing that I 
usually managed to get all the important stuff. So - I give reiser 
credit for being somewhat resiliant.

here's the way I see it. This isn't like Hans Reiser is some unknown guy 
who has some wild idea that we all don't know. ReiserFS is a majoy 
player in the Linux world and many people like it the best. Several 
distros use Reiser as their default install. So to me this gives him 
more than average standing and the way I see it - there has to be a good 
reason to NOT merge it rather than a reason TO merge it.

So - is Reiser4 going to break anything? If not - what is the reason to 
not do it?

-- 
Marc Perkel - marc@perkel.com

Spam Filter: http://www.junkemailfilter.com
    My Blog: http://marc.perkel.com

