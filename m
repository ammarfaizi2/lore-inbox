Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312828AbSDGJG5>; Sun, 7 Apr 2002 05:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313014AbSDGJG4>; Sun, 7 Apr 2002 05:06:56 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:32522 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S312828AbSDGJG4>; Sun, 7 Apr 2002 05:06:56 -0400
Message-ID: <3CB019A0.6050903@namesys.com>
Date: Sun, 07 Apr 2002 14:04:16 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org,
        flx <flx@namesys.com>
Subject: Re: ReiserFS Bug Fixes 3 of 6 (Please apply all 6)
In-Reply-To: <200204052027.g35KRc002869@bitshadow.namesys.com> <Pine.LNX.4.33.0204051347500.1746-100000@penguin.transmeta.com> <20020405171001.C6087@work.bitmover.com> <3CAEE365.4020301@namesys.com> <20020406090157.A12017@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

>
>>Another model you might consider, one which would probably make you more 
>>money, make us happier, and better avoid "freeloaders", would be to make 
>>bitkeeper free for use with free software only.  This would be rather 
>>similar to what I use for reiserfs, which is free for use with free 
>>operating systems only, and available for a fee for all others.  It 
>>allows you to "do unto others as they would do unto you" (The Reiser 
>>Rule ;-) ).
>>
>
>We are dealing with various commercial organizations who play games
>with the checkin comments so that they can use BK for free and not give
>up any information.  Technically, it's a violation of the license if
>they do that, but proving that they are doing it just isn't worth it.
>What I'm tempted to do is to figure out a reasonable way to force free
>uses to make their changes publically available. 
>

This would be good to do.

> More like sourceforge,
>if you use their service, anyone can get at your source.  The problem
>is that we can't force all the changes out into the open immediately,
>people may have good reasons to hide (security changes, for example),
>along with bad reasons (they're freeloaders).
>
Better this inconvenience than hiding the source code....

>
>
>Allowing free use of BK with free software only doesn't solve anything.
>We have lots of people doing that and still hiding their changes
>behind empty (or "fixed") checkin comments.  It's only the commercial
>organizations who are a problem.  I'd really like to force those changes
>out in the open if they aren't going to pay.  The whole point of the
>openlogging stuff was to get people to work out in the open.
>
Umm, I usually use "comment" as my comment for anything not a bugfix, 
but it has nothing to do with your license and fear of people reading 
it, it is purely that my comments go into the source code unless it is a 
bugfix (bugfixes should have user emails attached to them, etc.).

>
>
>I've thought a bit about some sort of answer which addresses this and
>I'm curious to see what people would think if the rule were that your
>changes had to show up on a public server within a given time period
>(a month? 2 months? 3 months?).  In other words, factor in a reasonable
>ability to work in privacy but make it be limited enough that it only
>works for truly free software.
>
I'd be happy.

>
>
>My definition of free software is anything where the source is publically
>available.  It's sometimes called "Open Source".  Open source software
>where you can't get at the source is lame.
>
Call it accessible source, this is my term which allows for pay for use 
software whose source code is available for all to read.  If you want to 
require the software to be free as well, then call it free and 
accessible source.  (But please don't forbid it from being pay for use 
as well as free like reiserfs is.....)

I believe that the antitrust laws should be interpreted as requiring 
software source code to be accessible for any software for which there 
might be a market for improvements to it.  This of course assumes that 
the government has any intention of enforcing the anti-trust laws.... 
which the current administration surely does not.

Hans

