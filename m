Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263854AbRFNS2H>; Thu, 14 Jun 2001 14:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263863AbRFNS15>; Thu, 14 Jun 2001 14:27:57 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:26173 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263854AbRFNS1q>; Thu, 14 Jun 2001 14:27:46 -0400
Date: Thu, 14 Jun 2001 20:27:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org, Richard Henderson <rth@redhat.com>
Subject: Re: unregistered changes to the user<->kernel API
Message-ID: <20010614202744.D2115@athlon.random>
In-Reply-To: <20010614200328.A2115@athlon.random> <E15AbaZ-00054p-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15AbaZ-00054p-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jun 14, 2001 at 07:11:27PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2001 at 07:11:27PM +0100, Alan Cox wrote:
> I dont see why Tux should be merged. If we have people achieving the same
> performance in user space with the core facilities tux added to the kernel

I never had doubt that you could do the same in userspace using the
zorocopy functionality (see the old threads with Jeff V. Merkey and
netware when I was saying you don't need it in kernel) so in theory I
totally agree since the first place...

> like the better irq/sendfile stuff why bother merging tux ?

... but in practice x15 is nor open source nor free software and I'd
prefer to have an open choice. I wouldn't even think to merge tux if
zope, apache, thttpd would run as fast as tux of course.

Andrea
