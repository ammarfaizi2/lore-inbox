Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268043AbUJLW5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268043AbUJLW5l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 18:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268045AbUJLW5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 18:57:40 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:26128 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S268043AbUJLW5g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 18:57:36 -0400
Date: Tue, 12 Oct 2004 15:57:06 -0700
To: Sven Dietrich <sdietrich@mvista.com>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Thomas Gleixner <tglx@linutronix.de>,
       dwalker@mvista.com, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, amakarov@ru.mvista.com,
       ext-rt-dev@mvista.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Ext-rt-dev] Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Message-ID: <20041012225706.GC30966@nietzsche.lynx.com>
References: <20041012211201.GA28590@nietzsche.lynx.com> <EOEGJOIIAIGENMKBPIAEGEJGDKAA.sdietrich@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EOEGJOIIAIGENMKBPIAEGEJGDKAA.sdietrich@mvista.com>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 02:41:02PM -0700, Sven Dietrich wrote:
> 
> I emailed the mmlinux project about 2 months ago, 
> telling you that we were doing this.

I don't remember getting an email from you. I get tons of
email at times and I don't know if I had lost it or not.
I'm sorry if I didn't respond to you, but being in the
context of commerical development has a certain kind of
conflict with open source culture and balancing them with
competitors is tenuous and tense. I'm about as die hard
open source as it gets and it's a difficult balance if
one thinks of this problem in with these constraints.

> There was no response.
> 
> I am sorry that the early stage of our development upsets you.

Well, it kind of forced a number of things to happen that
is premature from multipule folks, namely me (Ingo can
speak for himself). I didn't want to release these patches
until I had solved a number of really critical problems,
since it would have made the release rather useless.

But since this is in a commerical context we have to save
face by at least putting our cards on the table and establishing
a sort of role in this community. That commericial development
attitude the reason why I haven't been permitted to talk about
this stuff openly, only sort of on the side in various
preemption discussions.

> It was intended to promote discussion, and that seems to be working.

Yeah, for me a bit of freak out Saturday that is still
kind of happening since this has been a personal project
of mine for a long time. :) I interpreted it as a visibility
move on your company's part, which I hate to say is a bit
unnerving to know that another group was doing the same
work. TimeSys's Scott Wood and friends are doing something
like this as well. I'm only being fair by mentioning them. :)

BTW, I'm using their irq-thread patches with modifications.
I intuited that they were doing an incremental model, which,
since this problem space is a bit more known, is no longer
a clearly viable track for them, assuming they are going this
route, because of all of the recent work.

There's going to be tons of overlap here and I suspect
that Ingo is going to kick all of our respective commerical
butts. :)

> We are aware of the issues you describe, and are making
> every effort to raise awareness of these problems.

> It is difficult to solve them for a team of 1 or N,
> in a maintainable fashion, as it requires some level 
> of awareness by the maintainers that we are looking
> at it from that angle.
 
> Thanks for the insights, we look forward to seeing your
> implementation added to the smorgasbord ;)

Well, uh, at least you're single kernel image folks like
us and not flaming us/me yet for corrupting the sancity
of Linux. Oh man, I feel a flame war coming. This is such
touchy material.

What's Monta Vista's attitude toward preemption development ?
open or closed ? I know this is a charged question, but
this has to be asked. :)

This commerical thing is going to be weird. I wish I was
an angry hippie instead of having a job at certain moments. :)

But the bay area is pretty damn cool, so... that makes up
for it. :)

bill

