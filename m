Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268084AbUIJFEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268084AbUIJFEn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 01:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268094AbUIJFEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 01:04:43 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:42750 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268084AbUIJFEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 01:04:39 -0400
Message-ID: <414135E6.8050103@namesys.com>
Date: Thu, 09 Sep 2004 22:04:38 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jakma <paul@clubi.ie>
CC: "Theodore Ts'o" <tytso@mit.edu>,
       Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
       William Stearns <wstearns@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes in reiser4 (brief attempt to document
 the idea ofwhat reiser4 wants to do with metafiles and why
References: <41323AD8.7040103@namesys.com> <413E170F.9000204@namesys.com> <Pine.LNX.4.58.0409071658120.2985@sparrow> <200409080009.52683.robin.rosenberg.lists@dewire.com> <20040909090342.GA30303@thunk.org> <4140ABB6.6050702@namesys.com> <Pine.LNX.4.61.0409092136160.23011@fogarty.jakma.org> <4140FBE7.6020704@namesys.com> <Pine.LNX.4.61.0409100212080.23011@fogarty.jakma.org>
In-Reply-To: <Pine.LNX.4.61.0409100212080.23011@fogarty.jakma.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jakma wrote:

> On Thu, 9 Sep 2004, Hans Reiser wrote:
>
>> It is not part of it at one level, but in the shell it is part of it.
>
>
> Just one of many applications. Watch Joe-user save their word 
> processing file sometime, they'll use spaces, quotes, etc.

With great unhappiness they will.

>
>> Have you looked at the political process at all? Or by lots of 
>> people, do you mean a sizable minority?
>
>
> Kernel development does 

did you mean to have a "not" here?

> require deep understanding by the majority of computer users. Only 
> kernel developers need deep understanding. ;)

What makes you think kernel developers have a deep understanding of the 
value of connectivity in the OS? They don't. The average kernel 
developer is not particularly bright. Just ask Ted why htrees are slower 
than reiser4, or ext2 tail combining is slower, and, well, he has no 
clue. He is happy to explain how architects don't do real work and 
should not attend the Linux Kernel Summit, and then when reiser4 blows 
htrees away he undoubtedly still thinks I just take the credit away from 
the programmers who do the real work. They did real work, and they are 
the best in the field, but architecture also matters --- quite a lot 
actually.

Maybe instead of free trade, I should have used anti-trust laws as my 
example. The percentage of persons who analytically understand both that 
free trade is vital and that anti-trust laws are a good thing is very 
small (and especially small at Harvard Law School). Average people can 
understand freedom. Understanding that one is not really free to choose 
to not purchase from a cartel is hard for many. Understanding that free 
markets are only a first approximation and that is why we need 
anti-trust laws is beyond perhaps even most economics PhDs.

This is not due to a lack of education. I once had a boss explain to me 
how many people have trouble understanding orders of magnitude and 
ratios. He particularly meant his boss, who was having trouble 
understanding my report.

We all have mental defects, we just have them in different areas from 
each other. (Forgive me for not enumerating mine....;-) ) Some technical 
matters are understood by much less than 50% of the population. Closure 
is one of them. For most people the value of closure can only be 
understood by using and liking a system that has it, and they are not 
capable of wanting it in advance during the design stages. Codd 
understood the importance of closure. You could sense his frustration at 
being unable to convey it to others in his writings. The search engine 
industry completely misses the importance of closure.

This is why I just want to be left alone to tinker with reiser4. It is 
faster than other filesystems. People should assume I know what I am 
doing, and leave me to tinker in my little fs. 5 years later others will 
follow, or not, I don't care.

>
> The real question though is: Have you given Al Viro technical answers 
> to his technical questions?

Yes, I did. Got no response. Would you like me to post something nice 
and technical to this thread?;-) I can send a summary of my design, and 
the answers I sent to Viro and Linus.

>
> regards,


