Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263015AbVAFVQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbVAFVQS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 16:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263013AbVAFVO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 16:14:27 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:61119 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262997AbVAFVJb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 16:09:31 -0500
Message-ID: <41DDA8E1.8080406@tmr.com>
Date: Thu, 06 Jan 2005 16:08:49 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rol@as2917.net
CC: "'Willy Tarreau'" <willy@w.ods.org>, "'Theodore Ts'o'" <tytso@mit.edu>,
       "'Horst von Brand'" <vonbrand@inf.utfsm.cl>,
       "'Thomas Graf'" <tgraf@suug.ch>, "'Adrian Bunk'" <bunk@stusta.de>,
       "'Diego Calleja'" <diegocg@teleline.es>, wli@holomorphy.com,
       aebr@win.tue.nl, solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
References: <20050104214324.GG22075@alpha.home.local> <200501061808.j06I84104393@tag.witbe.net>
In-Reply-To: <200501061808.j06I84104393@tag.witbe.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Rolland wrote:
> Hello,
> 
> 
>>>In practice, that's all the -rc releases are these days 
>>
>>anyway (there
>>
>>>are times when a 2.6.x-rcy release is more stable than 2.6.z).  The
>>>problem is that since the -rc releases are called what they are
>>>called, they don't get enough testing.
>>
>>Perfectly true. I would add that with -rc releases, people 
>>only upgrade when
>>we tell them that they can, while with more frequent 
>>releases, they upgrade
>>when they *need* to, and can try several versions if the 
>>first one they pick
>>does not work.
>>
> 
> 
> I'd like to add some personal view : After 2.4.x, we have had a fork and
> 2.5.x was born, clearly identified as a development tree, so no stability
> guaranteed... Then one day came 2.6.0, and so on...
> I'm sorry, but I still cannot consider 2.6.x being any stable the way 2.4.x
> is today.
> 
> Theodore wrote :
> 
>>that at least 1 in 3 releases will turn out to be stable enough for
>>most purposes.  But we won't know until after 2 or 3 days which
>>releases will be the good ones.
> 
> 
> I mostly agree. When a new 2.4.x comes out, I have a confident feeling
> about it, and there is no reason for me to wait 2 or 3 days to know if 
> it's stable or not. It's part of a stable branch, and there are no
> major changes in it.
> 2.6.x, I still consider as a development branch. OK, people changed the
> numbering from 2.5.x to 2.6.x, but the number of changes still going on
> didn't really change. Just have a look at the numbers : patches are even
> bigger now that we are in a "stable" branch (4Mo average for 2.6 patch, 
> gzip when we had a 1Mo average for 2.5 !)

I think you are quoting MB/release where MB/month would be much closer. 
Part of the "new development model" is that Linus only releases a new 
version the Thursday after the racoons tip over his garbage can.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
