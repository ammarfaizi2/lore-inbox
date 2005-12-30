Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbVL3AKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbVL3AKd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 19:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVL3AKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 19:10:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:995 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751162AbVL3AKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 19:10:32 -0500
Date: Thu, 29 Dec 2005 16:10:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: userspace breakage
In-Reply-To: <43B46078.1080805@wolfmountaingroup.com>
Message-ID: <Pine.LNX.4.64.0512291603500.3298@g5.osdl.org>
References: <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
 <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
 <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu>
 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com>
 <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <20051229224103.GF12056@redhat.com>
 <43B453CA.9090005@wolfmountaingroup.com> <Pine.LNX.4.64.0512291541420.3298@g5.osdl.org>
 <43B46078.1080805@wolfmountaingroup.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Dec 2005, Jeff V. Merkey wrote:
>
> Linus Torvalds wrote:
> >
> > We're not talking about internal kernel stuff. Internal kernel stuff _does_
> > get changed, and we dont' care about breakage of out-of-kernel stuff. That's
> > fundamental.
> 
> Start caring. People spend lots of money supporting you, and what you are
> doing. How about taking some responsibility for that [...]

Cry me a river, Jeff.

The kernel is GPL'd. That's my responsibility. Source code. Stuff that 
comes to me as patches. That's my job, and that's what I get paid for. In 
fact, my contract says that I _cannot_ work on anything that isn't open 
source.

Stuff outside the kernel is almost always either (a) experimental stuff 
that just isn't ready to be merged or (b) tries to avoid the GPL.

Neither is worth a _second_ of anybodys time trying to support, and when 
you say "people spend lots of money supporting you", you're lying through 
your teeth. The GPL-avoiding kind of people don't spend a dime supporting 
me, they spend their money actively trying to debase and destroy what I 
and thousands of others have been working our butts off for.

So don't try to make it sound like something it isn't. We support outside 
projects a hell of a lot better than we'd need to, and I can tell you that 
it's mostly _me_ who does that. Most of the core kernel developers argue 
that I should support less of it - and yes, they are backed up by lawyers 
at their (sometimes quite big) companies.

So be honest now. Are those projects you care about going to be GPL'd and 
actively pushed back into the standard kernel?

And if they aren't, SHUT THE HELL UP, because they are total freeloaders, 
and claimign that they "support" me is total crap.

			Linus
