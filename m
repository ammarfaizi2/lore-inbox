Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264655AbSKDMBk>; Mon, 4 Nov 2002 07:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbSKDMBk>; Mon, 4 Nov 2002 07:01:40 -0500
Received: from d06lmsgate-6.uk.ibm.com ([194.196.100.252]:62878 "EHLO
	d06lmsgate-6.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S264655AbSKDMBj>; Mon, 4 Nov 2002 07:01:39 -0500
Subject: Re: [lkcd-general] Re: What's left over.
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Dave Anderson <anderson@redhat.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net, lkcd-general@lists.sourceforge.net,
       lkcd-general-admin@lists.sourceforge.net,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFE5D1360D.AD5C65BE-ON80256C67.004027FF@portsmouth.uk.ibm.com>
From: "Richard J Moore" <richardj_moore@uk.ibm.com>
Date: Mon, 4 Nov 2002 11:59:23 +0000
X-MIMETrack: Serialize by Router on D06ML023/06/M/IBM(Release 5.0.9a |January 7, 2002) at
 04/11/2002 12:04:51
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> What he really wants is for Andrew or Alan or someone else he trusts
> to merge it, get actual field results, and declare it useful. If
> people start visibly passing around crash dump results on l-k and
> solving problems with them, that'll help too. Until then all he has is
> his gut feel to go on.

Are you sure? Isn't what Linus is saying is that he understands that some
problems can be solved using dumps, some from the oops message and some by
source code inspection and some by others means. But, he's not interested
in a timely resolution; he has a preference for solving the problems by
looking at the source and only that way. That's his preference: arguments
relating to timeliness and commercial considerations are of no interest to
him - simply because they argue for benefits in which he has no interest.
Because LKCD doesn't personally interest him he has declared that he will
not merge it; it' up to some trusted advocate.

So, for those of use who passionately care whether Linux has a system
dumping mechanism, we need to regroup, we need to decide the correct
strategy for gaining LKCD's inclusion into the kernel.  Many of the
arguments relate to timeliness and ultimately have a commercial benefit. I
suggest we actively campaign among the various distros who are interested
in selling Linus businesses and provide support. We also need to
concentrate on consolidating the various requirements of a system crash
dump - it's going to be much easier for everyone if there is a consensus on
system dumping technology.


First crucial question - are there any avenues still open for 2.5?


Richard J Moore
RAS Project Lead - IBM Linux Technology Centre


