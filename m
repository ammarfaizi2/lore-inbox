Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262140AbSJFTcn>; Sun, 6 Oct 2002 15:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262141AbSJFTcn>; Sun, 6 Oct 2002 15:32:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30733 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262140AbSJFTcm>; Sun, 6 Oct 2002 15:32:42 -0400
Date: Sun, 6 Oct 2002 12:39:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Russell King <rmk@arm.linux.org.uk>, "David S. Miller" <davem@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
       Ulrich Drepper <drepper@redhat.com>, <bcollins@debian.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: BK MetaData License Problem?
In-Reply-To: <Pine.LNX.4.44.0210061601040.7386-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0210061236400.10069-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Different issue, and slightly off-topic ]

On Sun, 6 Oct 2002, Ingo Molnar wrote:
> 
> until now the Linux kernel tree was distributed in a tarball that had a
> nice COPYING file in a very prominent spot. With BK the situation is
> different - and like i said in previous mails it's not BK's "fault", but
> BK's "effect" - and it's a situation that needs to be remedied, right?

If this is a concern, it actually appears that BK has the capability to
"enforce" a license, in that I coul dmake BK aware of the GPL and that
would cause BK to pop up a window saying "Do you agree to this license"  
before the first check-in by a person (the same way it asked you whether 
you wanted to allow openlogging).

Do people feel that would be a good idea? I actually dismissed it when 
Larry talked about it, because I felt people might take it as another "too 
much BK in your face", even though the license would be the _Linux_ 
license, not the BK one.

		Linus

