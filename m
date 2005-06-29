Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262674AbVF2WcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbVF2WcG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 18:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVF2WcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 18:32:06 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:25606 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262674AbVF2WcB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 18:32:01 -0400
Message-ID: <42C3220E.2060303@tmr.com>
Date: Wed, 29 Jun 2005 18:34:54 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13-rc1
References: <Pine.LNX.4.58.0506282310040.14331@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506282310040.14331@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok, guys,
>  there was a lot of stuff pending after 2.6.12, and in the week and a half
> since the release, the current diff against it has grown to almost three
> megabytes compressed.
> 
> Which is actually normal for a -rc1 release judging by the two last ones,
> but it usually takes us longer than ten days to get there. Which just
> shows that 2.6.12 was brewing for too long, but we can also think
> positively and say that perhaps it also seems to imply that this git thing
> is working out and not slowing people down.
> 
> Anyway, I really don't want to drag out 2.6.13 as long as 2.6.12 took, and
> we don't have any reason to anyway, so let's try to see if we can calm
> things down again, and people who are thinking about writing new code
> might think about spending some quality time looking at the existing code
> and patches instead.

Can't comment on git slowing things down, but I have to think that the 
time it took, and was ALLOWED to take, is a result of the -stable fixes 
working very well indeed. The fact that the 2.6.11.X was available to 
take the presure off to get something out of the door.

My big thank you to the stable folks, I personally think this idea is 
working as intended.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
