Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263864AbTIIBEA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 21:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbTIIBEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 21:04:00 -0400
Received: from holomorphy.com ([66.224.33.161]:37799 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263864AbTIIBDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 21:03:54 -0400
Date: Mon, 8 Sep 2003 18:05:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Use of AI for process scheduling
Message-ID: <20030909010504.GE1715@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Timothy Miller <miller@techsource.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3F5CD863.4020605@techsource.com> <20030908225749.GJ4306@holomorphy.com> <20030908230621.GC17441@matchmail.com> <20030908231439.GK4306@holomorphy.com> <3F5D1D32.7020704@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5D1D32.7020704@techsource.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought better of sending this as it seemed perhaps too unfriendly,
but after pasting a few lines of it on IRC, it appears some people
found it humorous. So, on with the diatribe^Wshow:

William Lee Irwin III wrote:
>> Worse than useless unless backed by code. We have enough managers already.

On Mon, Sep 08, 2003 at 08:22:10PM -0400, Timothy Miller wrote:
> Your hostility is misplaced.  I have been participating in discussions 
> of a number of things for a while now, and if you've paid attention, 
> mostly what I do is discuss ideas.  I'm more of a lurker than a hacker. 
>  I do intend to get into kernel hacking, but I have decided, 
> particularly with my limited free time, that it would be best to watch 
> and learn before blindly diving into kernel development.  In the time 
> I've been on LKML, I've learned a great deal about the Linux culture 
> which has direct bearing on how one goes about doing just about any kind 
> of kernel hacking.  At least as I see it, the social aspect is as 
> important as actual coding.  The definition of Free Software is 
> something which is shared, and sharing is social.

Such far-flung notions have far better ways to be pursued, starting
with some kind of review of concrete issues they address and some kind
of meaningful prediction of the results. e.g. what performance metric
do you expect your AI-produced scheduler to optimize? How much better
than some other algorithm? What other algorithms? Does it do something
unique that other algorithms can't, e.g. predicting task behavior?
What's the advantage of its unique capability? How is it exploited?

I don't see any of this happening and don't really want/expect answers.


On Mon, Sep 08, 2003 at 08:22:10PM -0400, Timothy Miller wrote:
> As for the idea I suggested, I don't expect some other person to "run 
> with it", although I'd be delighted if someone did.
> I proposed the idea in order to get people's thoughts on it.  If, for 
> instance, enough people had logical reasons why it was a _bad_idea_, 
> then I would drop it before writing a line of code.
> Don't you ever discuss your ideas with anyone before writing code?  I 
> do.  I'm reasonably intelligent, but not arrogant enough to think that I 
> always know the right thing to do before bouncing ideas off of other 
> intelligent people.  Perhaps it is not your style, but it is my style to 
> begin discussing ideas very early in development.

The trouble with this is the implication that someone will do the hacking
for you. Ideas can be worthwhile, but ultimately only if backed by some
potential of ever being utilized, i.e. coded. As one of those frequently
pegged to run off and do various kinds of coding, I'm rather wary of
stuff like this cropping up as requirements phrased in Star Trek dialogue.


On Mon, Sep 08, 2003 at 08:22:10PM -0400, Timothy Miller wrote:
> Are we on the same page here?  If it's generally agreed that a 
> kernel-related discussion is "off topic" unless code is involved, then 
> I'll shut up and go work on the code in silence until I have something. 
>  But keep in mind that this is a purely academic (in both meanings) 
> issue until we can interface it with some real kernel scheduler code.

Yes and no. I know what you're on about, but frankly, the mere Subject:
line had me falling off my chair with laughter when I saw it. At the
level you're presenting it, this is coming off as unicorns, leprechauns,
dancing munchkins, and witches squished by falling houses. If it were
serious it wouldn't have been "AI" but rather some specific learning
method (probably a computationally inexpensive one) and a specific kind
of decision to improve.

Not that I mean to "verbally attack" at all. This is all dead serious.
"AI" is frankly a buzzword and suggests more science fiction than
science. The lack of detail and the fumbling around for general
categories of learning methods ruled out any coherent plan. There isn't
even a hint of what the thing is supposed to do inside the scheduler;
presumably the entire algorithm is supposed to spring forth from the
mind of some self-aware computational entity. It's just far too removed
from reality not to dismiss out of hand.

Sorry, this one was a turkey. Ideas for solutions to problems we're
having instead of not-yet-decided solutions looking for problems hoping
for a blast radius somewhere near kernel/sched.c would be far preferable.


-- wli
