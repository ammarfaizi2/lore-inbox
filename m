Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbUJZVar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbUJZVar (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 17:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbUJZVar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 17:30:47 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:24725 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261486AbUJZVaN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 17:30:13 -0400
Message-ID: <417EC260.1010401@tmr.com>
Date: Tue, 26 Oct 2004 17:32:16 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Nick Piggin <nickpiggin@yahoo.com.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
References: <417D7089.3070208@tmr.com><Pine.LNX.4.58.0410221821030.2101@ppc970.osdl.org> <Pine.LNX.4.58.0410251458080.427@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410251458080.427@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 25 Oct 2004, Bill Davidsen wrote:
> 
>>I do agree that the pre and rc names gave a strong hint that (-pre) new 
>>features would be considered or (-rc) it's worth doing more serious 
>>testing.
> 
> 
> Well, I actually do try to _explain_ in the kernel mailing list 
> annoucements what it going on.
> 
> One of the reasons I don't like "-rcX" vs "-preX" is that they are so 
> meaningless. In contrast, when I actually do the write-up on a patch, I 
> tend to explain what I expect to have changed, and if I feel we're getting 
> ready for a release, I'll say something like
> 
> 	..
> 
> 	Ok,
> 	 trying to make ready for the real 2.6.9 in a week or so, so please give
> 	this a beating, and if you have pending patches, please hold on to them
> 	for a bit longer, until after the 2.6.9 release. It would be good to have
> 	a 2.6.9 that doesn't need a dot-release immediately ;)
> 
> 	....
> 
> which is a hell of a lot more descriptive, in my opinion.
> 
> Which is just another reason why the name itself is not that meaningful. 
> It can never carry the kind of information that people seem to _expect_ it 
> to carry. 

I wasn't going to reply to this since it's your call and I've had my 
say, but since several others have, let me throw out one more idea on 
the off chance you like it:

Stop doing the pre's on the next version! After 2.6.10 comes 2.6.10.1 
etc, which everyone can see are incremental changes to 2.6.10, and when 
you really mean it, then put out 2.6.11-rc1.

Did that strike a nerve?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
