Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264664AbSKDM3E>; Mon, 4 Nov 2002 07:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbSKDM3E>; Mon, 4 Nov 2002 07:29:04 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:59652 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264664AbSKDM3C>; Mon, 4 Nov 2002 07:29:02 -0500
Message-Id: <m188gNA-0004qBC@ladystrange.bluehorizon.nl>
From: naoise@ramoth.xs4all.nl (P.A.M. van Dam )
Subject: Re: [lkcd-devel] Re: [lkcd-general] Re: What's left over.
In-Reply-To: <OFE5D1360D.AD5C65BE-ON80256C67.004027FF@portsmouth.uk.ibm.com>
To: Richard J Moore <richardj_moore@uk.ibm.com>
Date: Mon, 4 Nov 2002 13:30:28 +0100 (CET)
CC: Oliver Xymoron <oxymoron@waste.org>, Dave Anderson <anderson@redhat.com>,
       linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net,
       lkcd-general@lists.sourceforge.net
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> > What he really wants is for Andrew or Alan or someone else he trusts
> > to merge it, get actual field results, and declare it useful. If
> > people start visibly passing around crash dump results on l-k and
> > solving problems with them, that'll help too. Until then all he has is
> > his gut feel to go on.
> 
> Are you sure? Isn't what Linus is saying is that he understands that some
> problems can be solved using dumps, some from the oops message and some by
> source code inspection and some by others means. But, he's not interested
> in a timely resolution; he has a preference for solving the problems by
> looking at the source and only that way. That's his preference: arguments
> relating to timeliness and commercial considerations are of no interest to
> him - simply because they argue for benefits in which he has no interest.
> Because LKCD doesn't personally interest him he has declared that he will
> not merge it; it' up to some trusted advocate.

Richard, IMHO what Linus is trying to say is that he wants proof that problems
are solved using crash dumps by developers also outside of the corporations. He wants LKCD to have an audience before he wants to include it. Linus strongly
believes that "oops scribbles" en source code reading is his way of debugging the kernel and is sure of the fact that he doesn't need LKCD. But he leaves the
rest of the developpers free to use LKCD in problem solving. He leaves it up to Alan (for example) to include in a tree for audition. Once he is convinced 
enough that enough people (users/developers and also user/developer outside of
businesses) use it, I strongly believe he will merge LKCD into the mainstream
tree.

I for myself think crash dumps make life a lot easier in debugging the kernel. And not only for that, also for teaching the inner workings of the Linux kernel to students. Crash dumps are equivalent of coredumps for processes. You can see
the state of the machine at a given time.

> 
> So, for those of use who passionately care whether Linux has a system
> dumping mechanism, we need to regroup, we need to decide the correct
> strategy for gaining LKCD's inclusion into the kernel.  Many of the
> arguments relate to timeliness and ultimately have a commercial benefit. I
> suggest we actively campaign among the various distros who are interested
> in selling Linus businesses and provide support. We also need to
> concentrate on consolidating the various requirements of a system crash
> dump - it's going to be much easier for everyone if there is a consensus on
> system dumping technology.

TurboLinux advertised they used LKCD in their distro. Unfortunately the demo didn't contain LKCD.

> 
> 
> First crucial question - are there any avenues still open for 2.5?

I suggest the road to late 2.5 or early 2.6 is by turning left on Cox' road. But let's ask him. Alan?

> Richard J Moore
> RAS Project Lead - IBM Linux Technology Centre
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: ApacheCon, November 18-21 in
> Las Vegas (supported by COMDEX), the only Apache event to be
> fully supported by the ASF. http://www.apachecon.com
> _______________________________________________
> lkcd-devel mailing list
> lkcd-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lkcd-devel
> 
