Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266175AbSLSVGa>; Thu, 19 Dec 2002 16:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266179AbSLSVGa>; Thu, 19 Dec 2002 16:06:30 -0500
Received: from zeke.inet.com ([199.171.211.198]:42422 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S266175AbSLSVG2>;
	Thu, 19 Dec 2002 16:06:28 -0500
Message-ID: <3E0236B3.9050101@inet.com>
Date: Thu, 19 Dec 2002 15:14:27 -0600
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: dank@kegel.com, linux-kernel@vger.kernel.org
Subject: Re: Dedicated kernel bug database
References: <200212192059.gBJKxFne002827@darkstar.example.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
>>And what about GNATS?  What about the others on 
>>http://www.a-a-p.org/tools_tracking.html ?  A number of those address 
>>the web-based concern.  Do any of them answer your other concerns?  If 
>>there are, where do those fail that bugzilla, GNATS, etc. get it right?
> 
> 
> Why are you so against somebody sitting down and thinking, "OK, we
> need a bug tracking database designed for debugging the Linux
> kernel."?  I don't understand why you think it's a bad idea to start
> over.  If my code was rubbish, then it wouldn't get used, and I wasted
> my time.  Nobody else suffers.

I'm not against someone starting over.  I'm against someone starting 
over without considering the existing base of code.  If for no other 
reason than to see what worked for others and what didn't.  A solid 
comparison of bugzilla, GNATS, and maybe a couple others with pros and 
cons for each can be extremely enlightening.... even if you decide none 
of them have a good, solid design.

My questions were an attempt to get at that comparison so that there was 
evidence that you knew the pitfalls of more than just bugzilla.  And I 
hoped that you might find another one that got some of those things right.

>>But I see that starting from scratch is just the way you work: 
>>http://grabjohn.com/question.php?q=6
> 
> Well, since it's me that's offering to write the code, don't I get to
> decide how to write it?

Absolutely!  I'm just trying to get you to step back from 'rewrite it!' 
as an initial assumption, and look at what already exists.  Maybe every 
wheel invented so far has 3 to 8 sides and we need to consider something 
other than a polygon.  Or maybe there is an oval out there that hints at 
a better way.  I'm just wanting to see that you have looked at more than 
the square wheel.

> Besides, I'm not the only person who thinks it's a good idea to start
> over sometimes - Eric Raymond even addresses this point in The
> Cathedreal and the Bazaar.
> 
> http://www.tuxedo.org/~esr/writings/cathedral-bazaar/cathedral-bazaar/ar01s02.html
> 

Yes, but I didn't see much of an explanation of _why_ nothing out there 
was a good starting point.  Nor did I see an indication that you had 
gone and looked at more than just bugzilla.

>>Well, have fun, good luck, and I do hope you come up with something 
>>useful and maintainable.
> 
> 
> If not, I will admit you were right to the list :-).

*chuckle*  I think you are _premature_ in saying "rewrite!", not _wrong_ 
in saying "rewrite!"  And I will by no means tell you to sit and twiddle 
your thumbs instead of writing something, even if I think that something 
already exists in perfect form.  (Which in this case, I don't. :) )

Have fun!

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

