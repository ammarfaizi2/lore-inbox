Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290710AbSBFRlO>; Wed, 6 Feb 2002 12:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290713AbSBFRlG>; Wed, 6 Feb 2002 12:41:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36364 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290710AbSBFRk7>; Wed, 6 Feb 2002 12:40:59 -0500
Date: Wed, 6 Feb 2002 09:40:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave McCracken <dmccr@us.ibm.com>
cc: Dave Jones <davej@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.3] Second version of signal changes for thread groups
In-Reply-To: <54170000.1013014940@baldur>
Message-ID: <Pine.LNX.4.33.0202060914410.22843-100000@athlon.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Feb 2002, Dave McCracken wrote:
>
> --On Tuesday, February 05, 2002 17:26:22 -0800 Linus Torvalds
> <torvalds@transmeta.com> wrote:
>
> > Your mailer does horrible things to whitespace (word wrap etc). Please fix
> > it, the patch itself looks ok.
>
> My apologies.  It's not my mailer that was broken, it was my brain.  I
> accidentally set a config option wrong.

This one was broken too, I get whitespace removed at end of lines, and
lines wrapped. I think it's the "format=flowed" part of

	Content-Type: text/plain; charset=us-ascii; format=flowed

and I'm fairly sure it's from your end (ie I have other emails in my
folder that do not have these problems).

You seem to be using Mulberry, I'm sure there must be some way to fix it,
but I don't know mb myself.

(I can edit and hand-apply patches like these, but I hate to do it, and I
really really hate to have developers with broken mail configurations, so
I'd rather go through this several times to get it fixed than to work
around it)

		Linus

