Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267780AbTBVCh7>; Fri, 21 Feb 2003 21:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267781AbTBVCh7>; Fri, 21 Feb 2003 21:37:59 -0500
Received: from bitmover.com ([192.132.92.2]:31133 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267780AbTBVCh6>;
	Fri, 21 Feb 2003 21:37:58 -0500
Date: Fri, 21 Feb 2003 18:47:21 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Larry McVoy <lm@bitmover.com>, Hanna Linder <hannal@us.ibm.com>,
       lse-tech@lists.sf.et, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030222024721.GA1489@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Larry McVoy <lm@bitmover.com>, Hanna Linder <hannal@us.ibm.com>,
	lse-tech@lists.sf.et, linux-kernel@vger.kernel.org
References: <96700000.1045871294@w-hlinder> <20030222001618.GA19700@work.bitmover.com> <306820000.1045874653@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <306820000.1045874653@flay>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 04:44:13PM -0800, Martin J. Bligh wrote:
> > Ben is right.  I think IBM and the other big iron companies would be
> > far better served looking at what they have done with running multiple
> > instances of Linux on one big machine, like the 390 work.  Figure out
> > how to use that model to scale up.  There is simply not a big enough
> > market to justify shoveling lots of scaling stuff in for huge machines
> > that only a handful of people can afford.  That's the same path which
> > has sunk all the workstation companies, they all have bloated OS's and
> > Linux runs circles around them.
> 
> In your humble opinion.

My opinion has nothing to do with it, go benchmark them and see for
yourself.  I'm in a pretty good position to back up my statements with
data, we support BitKeeper on AIX, Solaris, IRIX, HP-UX, Tru64, as well
as a pile of others, so we have both the hardware and the software to
do the comparisons.  I stand by statement above and so does anyone else
who has done the measurements.  It is much much more pleasant to have
Linux versus any other Unix implementation on the same platform.  Let's
keep it that way.

> Unfortunately, as I've pointed out to you before, this doesn't work in
> practice. Workloads may not be easily divisible amongst machines, and
> you're just pushing all the complex problems out for every userspace
> app to solve itself, instead of fixing it once in the kernel.

"fixing it", huh?  Your "fixes" may be great for your tiny segment of 
the market but they are not going to be welcome if they turn Linux into
BloatOS 9.8.

> The fact that you were never able to do this before doesn't mean it's
> impossible, it just means that you failed.

Thanks for the vote of confidence.  I think the thing to focus on, 
however, is that *noone* has ever succeeded at what you are trying 
to do.  And there have been many, many attempts.  Your opinion, it
would appear, is that you are smarter than all of the people in all
of those past failed attempts, but you'll forgive me if I'm not 
impressed with your optimism.

> > In terms of the money and in terms of installed seats, the small Linux
> > machines out number the 4 or more CPU SMP machines easily 10,000:1.
> > And with the embedded market being one of the few real money makers
> > for Linux, there will be huge pushback from those companies against
> > changes which increase memory footprint.
> 
> And the profit margin on the big machines will outpace the smaller 
> machines by a similar ratio, inverted. 

Really?  How about some figures?  You'd need HUGE profit margins to 
justify your position, how about some actual hard cold numbers?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
