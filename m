Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262668AbUJ0TcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbUJ0TcE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 15:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbUJ0T33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 15:29:29 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:15514 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262591AbUJ0T0k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 15:26:40 -0400
Message-ID: <417FF5C8.9010701@tmr.com>
Date: Wed, 27 Oct 2004 15:23:52 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Barry K. Nathan" <barryn@pobox.com>
CC: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
References: <417EC260.1010401@tmr.com><417EC260.1010401@tmr.com> <20041027033212.GC9375@ip68-4-98-123.oc.oc.cox.net>
In-Reply-To: <20041027033212.GC9375@ip68-4-98-123.oc.oc.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Barry K. Nathan wrote:
> On Tue, Oct 26, 2004 at 05:32:16PM -0400, Bill Davidsen wrote:
> 
>>Linus Torvalds wrote:
> 
> [snip]
> 
>>>Which is just another reason why the name itself is not that meaningful. 
>>>It can never carry the kind of information that people seem to _expect_ it 
>>>to carry. 
>>
>>I wasn't going to reply to this since it's your call and I've had my 
>>say, but since several others have, let me throw out one more idea on 
>>the off chance you like it:
>>
>>Stop doing the pre's on the next version! After 2.6.10 comes 2.6.10.1 
>>etc, which everyone can see are incremental changes to 2.6.10, and when 
>>you really mean it, then put out 2.6.11-rc1.
>>
>>Did that strike a nerve?
> 
> 
> 2.6.10.1, etc. suggests important bug fixes for 2.6.10, *not* prereleases
> of 2.6.11. But... perhaps (with sufficient warning) the even/odd principle
> could be applied to the third number. So, this would happen:

2.6.10.1 suggests nothing, that convention was used ONCE in the 2.6 
series. I liked the -pre convention as it was, but Linus has dropped 
that in spite of several hundred instances of its use. From that I 
conclude that if Linus like 2.6.10.1 he will use it, and if not we will 
have -rc releases which aren't release candidates. His call.

I personally think it will slow development because some people tested 
the -rc releases harder, but that's not decided by vote.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
