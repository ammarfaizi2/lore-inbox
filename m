Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314805AbSDVVga>; Mon, 22 Apr 2002 17:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314791AbSDVVg3>; Mon, 22 Apr 2002 17:36:29 -0400
Received: from fiona.siteprotect.com ([66.113.135.14]:2064 "HELO
	fiona.siteprotect.com") by vger.kernel.org with SMTP
	id <S314816AbSDVVfm>; Mon, 22 Apr 2002 17:35:42 -0400
Message-ID: <3CC481BD.5070506@hostway.net>
Date: Mon, 22 Apr 2002 16:33:49 -0500
From: Nicholas Harring <nharring@hostway.net>
Reply-To: nharring@hostway.net
Organization: Hostway Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Doug Ledford <dledford@redhat.com>, Larry McVoy <lm@bitmover.com>,
        Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org
Subject: Re: BK, deltas, snapshots and fate of -pre...
In-Reply-To: <Pine.LNX.4.44.0204202108410.10137-100000@home.transmeta.com> <E16zNxY-0001Ld-00@starship> <20020422165327.A914@redhat.com> <E16zOWH-0001MF-00@starship>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> On Monday 22 April 2002 22:53, Doug Ledford wrote:
> 
>>On Sun, Apr 21, 2002 at 10:29:19PM +0200, Daniel Phillips wrote:
>>
>>>On Monday 22 April 2002 21:53, Doug Ledford wrote:
>>>
>>>>On Sun, Apr 21, 2002 at 07:34:49PM +0200, Daniel Phillips wrote:
>>>>
>>>>>How about a URL instead?  Any objection?
>>>>
>>>>Yes.  Why should I have to cut and paste (assuming I'm in X) or
>>>>write down
>>>
>>>What???   What kind of system are you running?  Err... redhat supports
>>>cut and paste I thought. <-- funnny.
>>
>>Depends on what you use to read the file containing the URL.  Obviously, 
>>if I'm Al Viro I'm on a text console and wouldn't use a mouse if you 
>>cemented it in my hand, so cut and paste isn't an option.
> 
> 
> Would everybody with no mouse on their system please stand up, and leave
> the room.
> 
> Seriously, you're trolling.
> 
> 
>>>>and transpose some URL from a file that used to contain
>>>>the exact instructions I need in order to get those instructions now
>>>
>>>Bogus.  You'd have to do the same to edit/list the file.
>>
>>No, I wouldn't.  In one case I would do "less <filename>" and in the other 
>>case I would do "less <filename>", ohh damn, it's only a pointer to the 
>>real docs, switch to X or install lynx on my system, go to URL.  It's a 
>>matter of having the appropriate documentation at hand vs. having to 
>>retrieve it.
> 
> 
> lynx <url>
> 
> What's the difference?
The difference is that currently linux/Documentation/SubmittingPatches 
currently exists and advocates the usage of diff. Linus no longer 
prefers diff, he has made it clear he likes BK output.
Would it be acceptable to simply modify said file to include both 
instructions for using diff, which I believe Linus has said he will 
continue to accept, as well as to include basic commands for BK to get 
output such as Linus wants emailed to him. No feature listing, no 
advertising, no advocacy, just simple usage.

> 
> 
>>I put my docs on my web site because that's what I owned/controlled and it 
>>was relevant to people already coming to my web site.  That in no way 
>>indicates that your position is correct, especially since you ignored to 
>>truly relevant item in my email:
> 
> 
> I'm actually trying to do a little work as well as handle all the input
> from the Bitkeeper moonies, thankyou.
> 
> Err, did I say moonies, sorry I meant advocates, err, apologists, umm.
> Sorry, I just meant I've been getting a lot of email lately, some of it
> is too long to read every word.  Unless you are a spectacularly good
> writer, expect some of your deathless prose to drop through the cracks.
> 
> 
>>>>information so that the whole picture, from start to finish, was all 
>>>>described in one easy to access place.
>>>
>>One place for relevant information, from start to finish.
> 
> 
> Right.  bitkeeper.com, any argument?
> 
> 
>>>You haven't read the thread closely, this was described before.  There are
>>>one documentation file and three scripts.  The documentation file is about
>>>half general description of Bitkeeper - which is quite unabashedly
>>>promotional and the author does describe it as an adverisement - and half
>>>how to use for submitting kernel patches.
>>
>>Now, now Daniel, let's not put words into people's mouths.  Jeff has said 
>>he does like BitKeeper, and he said he could *see how you think his 
>>description is an advertisement* but that he *didn't write it as an 
>>advertisement*.
> 
> 
> He agreed it was an advertisement.
> 



