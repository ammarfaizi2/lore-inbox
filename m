Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129506AbRAaWvU>; Wed, 31 Jan 2001 17:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129522AbRAaWvK>; Wed, 31 Jan 2001 17:51:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41745 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129506AbRAaWvB>;
	Wed, 31 Jan 2001 17:51:01 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101311959.f0VJx2n11108@flint.arm.linux.org.uk>
Subject: Re: Recommended swap for 2.4.x.
To: riel@conectiva.com.br (Rik van Riel)
Date: Wed, 31 Jan 2001 19:59:02 +0000 (GMT)
Cc: matthew@hairy.beasts.org (Matthew Kirkwood),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.21.0101301643190.1321-100000@duckman.distro.conectiva> from "Rik van Riel" at Jan 30, 2001 04:43:40 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel writes:
> On Tue, 30 Jan 2001, Matthew Kirkwood wrote:
> > On Tue, 30 Jan 2001, Rik van Riel wrote:
> > > While reclaiming swap space when you run out is pretty
> > > trivial to do, Linus doesn't seem to like the idea all
> > > that much and Disk Space Is Cheap(tm) so it's not very
> > > high on my list of things to do.
> > 
> > 'anybody who says "disk is cheap" deserves to be shot.'
> > - Linus Torvalds
> 
> I wonder if Linus will shoot himself or if he'll just
> segfault ;)

Depends whether someone compiled oom_kill.c into his brain!

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
