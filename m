Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290827AbSBVB3v>; Thu, 21 Feb 2002 20:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290878AbSBVB3a>; Thu, 21 Feb 2002 20:29:30 -0500
Received: from starbug.ugh.net.au ([203.31.238.37]:36876 "EHLO
	starbug.ugh.net.au") by vger.kernel.org with ESMTP
	id <S290827AbSBVB3W>; Thu, 21 Feb 2002 20:29:22 -0500
Date: Fri, 22 Feb 2002 12:29:20 +1100 (EST)
From: David Burrows <snadge@ugh.net.au>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dodgey Linus BogoMIPS code ;) (was Re: baffling linux bug)
In-Reply-To: <20020222011209.GE20060@matchmail.com>
Message-ID: <20020222122108.I15623-100000@starbug.ugh.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Mike Fedyk wrote:
> I didn't see one thing mentioning Linus in there... ;)  I could sue if you
> were selling something. ;)

Kind of.  Except Linus wrote the particular section of code in question.
=)

> Anyway, jiffies are same as HZ and on i386 100 jiffies/sec, and one timer
> interrupt per jiffie.

Or perhaps not in the case of my hardware functioning properly one day,
and never to boot linux (but fine with everything else) again..

I need a sure fire way of testing whether the timer interrupt works,
perhaps even a kernel patch to include such a check before initialising
the timers.  Is there a possibility of working around such problem?  I
would rather destroy this motherboard than sacrifice it to running
inferior operating systems for the remainder of its life. =)

Regards,

Dave.

