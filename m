Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264200AbRFFWZC>; Wed, 6 Jun 2001 18:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264201AbRFFWYx>; Wed, 6 Jun 2001 18:24:53 -0400
Received: from asteria.host4u.net ([216.71.64.118]:6151 "EHLO
	asteria.host4u.net") by vger.kernel.org with ESMTP
	id <S264200AbRFFWYl>; Wed, 6 Jun 2001 18:24:41 -0400
Message-Id: <5.1.0.14.2.20010606152347.028e21d0@ansa.hostings.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 06 Jun 2001 15:27:57 -0700
To: Jonathan Morton <chromi@cyberspace.org>
From: android <linux@ansa.hostings.com>
Subject: Re: Break 2.4 VM in five easy steps
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <l03130314b74459ae92f1@[192.168.239.105]>
In-Reply-To: <5.1.0.14.2.20010606143453.028ed400@ansa.hostings.com>
 <9fm4t7$412$1@penguin.transmeta.com>
 <3B1D5ADE.7FA50CD0@illusionary.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >I'd be happy to write a new routine in assembly
>
>I sincerely hope you're joking.
>
>It's the algorithm that needs fixing, not the implementation of that
>algorithm.  Writing in assembler?  Hope you're proficient at writing in
>x86, PPC, 68k, MIPS (several varieties), ARM, SPARC, and whatever other
>architectures we support these days.  And you darn well better hope every
>other kernel hacker is as proficient as that, to be able to read it.
I realize that assembly is platform-specific. Being that I use the IA32 class
machine, that's what I would write for. Others who use other platforms could
do the deed for their native language. As for the algorithm, I'm sure that
whatever method is used to handle page swapping, it has to comply with
the kernel's memory management scheme already in place. That's why I would
need the details so that I wouldn't create more problems than already present.
Being that most users are on the IA32 platform, I'm sure they wouldn't reject
an assembly solution to this problem. As for kernel acceptance, that's an
issue for the political eggheads. Not my forte. :-)

                                  -- Ted

