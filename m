Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262730AbTCPTT3>; Sun, 16 Mar 2003 14:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262731AbTCPTT3>; Sun, 16 Mar 2003 14:19:29 -0500
Received: from msp-24-163-212-250.mn.rr.com ([24.163.212.250]:38793 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262730AbTCPTT2>; Sun, 16 Mar 2003 14:19:28 -0500
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
From: Shawn <core@enodev.com>
To: Nicolas Pitre <nico@cam.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andrea Arcangeli <andrea@suse.de>,
       Ben Collins <bcollins@debian.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303161341520.5348-100000@xanadu.home>
References: <Pine.LNX.4.44.0303161341520.5348-100000@xanadu.home>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047843005.27020.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 16 Mar 2003 13:30:05 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-16 at 12:54, Nicolas Pitre wrote:
> On Sun, 16 Mar 2003, Roman Zippel wrote:
> > Hi,
> > On Sun, 16 Mar 2003, Andrea Arcangeli wrote:
> > > true but the missing bits are nearly worthless, I wouldn't be ok with
> > > CVS if this wasn't the case. I mean, in the very worst case, we're not
> > > totally screwed, we probably won't even notice the difference.
> > The missing bits are absolutely not worthless. They are very useful when 
> > you want to test other SCM system to simulate distributed development.
> This is completely ridiculous.  Isn't this a bit too demanding?

I think so.

> Be realistic.  The missing bits are worthless and add absolutely no value to 
> kernel development which is supposed to be the topic for this mailing list.  

They are not useless. It definitely adds value. It's just that it's more
than developers had before, and they want all the extra BK gives them
without having to say "ok" to a license which they do not like.

Fact is, folks simply forget to make sense sometimes.

> It's not the missing bits that will prevent you from making a better
> alternative to BK or whatever either.  If it really does you should consider
> spending your time on another project.  But since I truly believe you are
> more clever than that I suspect you're just trying to stretch the issue out
> of reasonable bounds because of your political beliefs.

