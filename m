Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267795AbTBVEW4>; Fri, 21 Feb 2003 23:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267808AbTBVEW4>; Fri, 21 Feb 2003 23:22:56 -0500
Received: from franka.aracnet.com ([216.99.193.44]:10637 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267795AbTBVEWz>; Fri, 21 Feb 2003 23:22:55 -0500
Date: Fri, 21 Feb 2003 20:32:30 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Larry McVoy <lm@bitmover.com>
cc: Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sf.et,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <14450000.1045888349@[10.10.2.4]>
In-Reply-To: <20030222024721.GA1489@work.bitmover.com>
References: <96700000.1045871294@w-hlinder> <20030222001618.GA19700@work.bitmover.com> <306820000.1045874653@flay> <20030222024721.GA1489@work.bitmover.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> In your humble opinion.
> 
> My opinion has nothing to do with it, go benchmark them and see for
> yourself. 

Nope, I was referring to this:

>> > Ben is right.  I think IBM and the other big iron companies would be
>> > far better served looking at what they have done with running multiple
>> > instances of Linux on one big machine, like the 390 work.  Figure out
>> > how to use that model to scale up. There is simply not a big enough
>> > market to justify shoveling lots of scaling stuff in for huge machines
>> > that only a handful of people can afford.  

Which I totally disagree with. 

>> >That's the same path which
>> > has sunk all the workstation companies, they all have bloated OS's and
>> > Linux runs circles around them.

Not the fact that Linux is capable of stellar things, which I totally
agree with.

> I'm in a pretty good position to back up my statements with
> data, we support BitKeeper on AIX, Solaris, IRIX, HP-UX, Tru64, as well
> as a pile of others, so we have both the hardware and the software to
> do the comparisons.  I stand by statement above and so does anyone else
> who has done the measurements.  

Oh, I don't doubt it -  But I'd be amused to see the measurements, 
if you have them to hand.

> It is much much more pleasant to have Linux versus any other Unix 
> implementation on the same platform.  Let's keep it that way.

Absolutely.
 
>> Unfortunately, as I've pointed out to you before, this doesn't work in
>> practice. Workloads may not be easily divisible amongst machines, and
>> you're just pushing all the complex problems out for every userspace
>> app to solve itself, instead of fixing it once in the kernel.
> 
> "fixing it", huh?  Your "fixes" may be great for your tiny segment of 
> the market but they are not going to be welcome if they turn Linux into
> BloatOS 9.8.

They won't - the maintainers would never allow us to do that.
 
>> The fact that you were never able to do this before doesn't mean it's
>> impossible, it just means that you failed.
> 
> Thanks for the vote of confidence.  I think the thing to focus on, 
> however, is that *noone* has ever succeeded at what you are trying 
> to do.  And there have been many, many attempts.  Your opinion, it
> would appear, is that you are smarter than all of the people in all
> of those past failed attempts, but you'll forgive me if I'm not 
> impressed with your optimism.

Who said that I was going to single-handedly change the world? What's
different with Linux is the development model. That's why *we* will 
succeed where others have failed before. There's some incredible intellect 
all  around Linux, but that's not all it takes, as you've pointed out.

>> > In terms of the money and in terms of installed seats, the small Linux
>> > machines out number the 4 or more CPU SMP machines easily 10,000:1.
>> > And with the embedded market being one of the few real money makers
>> > for Linux, there will be huge pushback from those companies against
>> > changes which increase memory footprint.
>> 
>> And the profit margin on the big machines will outpace the smaller 
>> machines by a similar ratio, inverted. 
> 
> Really?  How about some figures?  You'd need HUGE profit margins to 
> justify your position, how about some actual hard cold numbers?

I don't have them to hand, but if you think anyone's making money on
PCs nowadays, you're delusional (with respect to hardware). With respect
to Linux, what makes you think distros are going to make large amounts
of money from a freely replicatable OS, for tiny embedded systems?
Support for servers, on the other hand, is a different game ...

M.


