Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286386AbRLTV2h>; Thu, 20 Dec 2001 16:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286394AbRLTV20>; Thu, 20 Dec 2001 16:28:26 -0500
Received: from smtp1.ndsu.NoDak.edu ([134.129.111.146]:3083 "EHLO
	smtp1.ndsu.nodak.edu") by vger.kernel.org with ESMTP
	id <S286386AbRLTV1d>; Thu, 20 Dec 2001 16:27:33 -0500
Subject: Re: Configure.help editorial policy
From: Reid Hekman <reid.hekman@ndsu.nodak.edu>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112201605310.9934-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.33.0112201605310.9934-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 20 Dec 2001 15:28:02 -0600
Message-Id: <1008883684.4704.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-12-20 at 15:07, Mark Hahn wrote:
> > 4 binary kilobyte pages
> > 1024 decimal kilobyte disk
> > 8.4 decimal gigabyte disks
> > 4 binary gigabytes of memory
> > 10 decimal gigabits of bandwith
> > 
> > or if that offends the sensibilities:
> > 
> > 4 kilobytes (binary)
> > 1024 kilobytes (decimal)
> > 8.4 gigabytes (decimal)
> > 
> > I know that they are long on keystrokes, but in lieu of an accepted and
> > aesthetically pleasing standard, they are clear and unambiguous.
> 
> though as your example showed, there's very little, if any,
> ambiguity: disk is always decimal, memory is always binary, etc.
> 

My examples were by no means exhaustive. One also must consider things
like network traffic and in that case there seems to be a distinction
between computers and telecommunications. I've also seen pointed out
that the "MB" of 1.44MB floppy fame is actually 1,024,000 bytes.

More importantly, less educated users than yourself might not strike up
the distinction between disk and memory units. The common example being,
"why does my 9.1GB hard drive show up as 8.9GB?" Rather than explain
this again and again, or expect users to find the one FAQ entry amidst a
sea of configuration help, they could devine the answer from the clear
unit measures of decimal or binary that crop up everywhere.

For me, my reasons for full names are consistency and aesthetics --
allowing us to sidestep the abortion that the IEC has created of SI
units.

Regards,
Reid


