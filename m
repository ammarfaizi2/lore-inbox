Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWIYKwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWIYKwB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 06:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWIYKwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 06:52:01 -0400
Received: from ns1.suse.de ([195.135.220.2]:3230 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751116AbWIYKv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 06:51:59 -0400
From: Neil Brown <neilb@suse.de>
To: Michiel de Boer <x@rebelhomicide.demon.nl>
Date: Mon, 25 Sep 2006 20:51:40 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17687.46268.156413.352299@cse.unsw.edu.au>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: message from Michiel de Boer on Monday September 25
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
	<451798FA.8000004@rebelhomicide.demon.nl>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday September 25, x@rebelhomicide.demon.nl wrote:
> 
> For what it's worth, i support RMS and his fight for free software fully.
> I support the current draft of the GPL version 3 and am very dissapointed
> it will not be adopted as is. IMHO, Linux has the power and influence
> to move mountains in the software industry, and shouldn't shy away from
> the opportunity to take moral responsibility when it arises.

I think that would be against the character of Linux.  Linux has
always been primarily about technology and community rather than
freedom.  Doing something to improve the technology or enable the
community would be very in-character.  Doing something in the name of
freedom would not.

Is that a reasonable position to take?  Well, maybe.

There are (at least) two ways to change unpleasant behaviour in
others.  One is through legislation.  The other is through making the
pleasant behaviour more attractive.
Legislation is short term, but makes things black-and-white (or, in
the case of grey areas, very expensive). 
Rewarding good behaviour is a much slower process, but deals with gray
areas much more effectively.

I think it is clear that we need a balance.  
The 'legislation' of GPLv2 plus the economic benefit of hundreds of
developers have been an effective 2-prong attack to encourage people
to share their software.  This has been self re-enforcing.  The more
people see the benefit, the more people seem to get involved.
So Linux has done a lot for freedom by focussing on technology.

So the question is: has the balance swung far enough the wrong way to
make a change in legislation necessary?

The 'DRM' provision of the proposed GPLv3 seem to be being driven by 1
company - Tivo.  Yes, what they are doing is against our spirit of
freedom.   But is it enough to justify changing the legislation?  Or
would that be 'the tail wagging the dog'??

The 'patent' provisions are - to me - more defensible than the DRM
provisions (fewer grey areas).  But are they an actual problem, or
just a potential problem?

The GPLv2 was written based on experience of people taking code and
giving nothing back.  Based on quite a lot of (unpleasant) experience,
a very effective measure was developed to combat it.
Do we have the same amount of experience with the problems that the
GPLv3 is supposed to fix?  If not, fixing now might be a bit premature
and may lead to unwanted side effects.

But maybe I am just misinformed.  Maybe there are dozens of different
manufacturers making devices that use DRM to prohibit freedom despite
using GPL code, and maybe there are hundreds of submarine patents
owned by distributors of GPL code and embodied in that code that the
owners are going to start suing us overs.... Is there a list of these
somewhere?

> 
> What is the stance of the developer team / kernel maintainers on DRM,

While I cannot speak for other developers (and sometimes have trouble
speaking for myself), one stance I have often heard is that DRM is
simply a tool - one that is largely based on cryptography which is
just another tool.  They can have good uses and bad uses just like the
TCP/IP stack (think 'spam').  So code to implement then would (if of
suitable quality) be allowed into the kernel.  If you want to make DRM
illegal, speak to your member-of-parliament, not your code developers.

> Trusted Computing and software patents? Does the refusal to adopt GPLv3 as
> is mean that these two are more likely to emerge as supported functionality
> in the Linux kernel? Are there any moral boundaries Linux kernel developers
> will not cross concerning present and new U.S. laws on technology? Are they
> willing to put that in writing? Will Linux support HD-DVD and BluRay by
> being slightly more tolerant to closed source binary blobs? What about
> the already existant problems with the Content Scrambling System for
> DVD's?

Tolerance of binary blogs seems to be steadily dropping.

As far as I can tell, the DVD-CSS is purely a legal issue today - the
technical issues are solved (I can watch any-region on my Linux
computer, and in Australia, the law requires that all DVD players must
ignore region encoding as it is an anti-competitive practice).

How HD-DVD and BluRay will work on Linux is yet to be seen, but I
seriously doubt that anything in the GPLvX would have much effect on
the outcome.  The greater effect would come from people writing to
their congress-person and voting with their wallet.... or just
reverse-engineering the technology:-)

> 
> Finally, i hope that the wishes of the community of people that have only
> contributed to the kernel a few times but whose combined work may equal that
> of the core developers, are taken into account; as well as the wishes of
> the massive amount of users of the Linux kernel.

This isn't about anyone's wishes.  The kernel is GPLv2 only and that is not
going to change - arguably is cannot change.

This is about a group of developers giving an opinion.  If others
agree, it might become an argument that the FSF will choose to allow
to affect their policy making (rather than thinking it is just Linus
raving as usual).  If no-one agrees, it will remain the opinion of a
few, with all the lack of force that implies.

> 
> How about a public poll?

We've all see the sort of politician that get into government on the
back of a public poll...  Do you really think a public poll would
provide a useful result :-)

NeilBrown
