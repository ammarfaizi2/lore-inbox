Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131006AbRCFQdi>; Tue, 6 Mar 2001 11:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131009AbRCFQd2>; Tue, 6 Mar 2001 11:33:28 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:48757 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S131006AbRCFQdH>; Tue, 6 Mar 2001 11:33:07 -0500
Message-ID: <3AA510C6.7A2190D8@sgi.com>
Date: Tue, 06 Mar 2001 08:31:02 -0800
From: LA Walsh <law@sgi.com>
Organization: Trust Technology, SGI
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, fr
MIME-Version: 1.0
To: God <atm@pinky.penguinpowered.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Annoying CD-rom driver error messages
In-Reply-To: <Pine.LNX.4.21.0103060428100.878-100000@scotch.homeip.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

God wrote:
> 
> On Mon, 5 Mar 2001, Alan Cox wrote:
> 
> > > > this isnt a kernel problem, its a _very_ stupid app
> > > ---
> > >     Must be more than one stupid app...
> >
> > Could well be. You have something continually trying to open your cdrom and
> > see if there is media in it
> 
> Gnome / KDE? does exactly that... (rather annoying too) ..  what app
> specificaly I don't know...
---
	So I'm still wondering what the "approved and recommended" way for a program
to be "automatically" informed of a CD or floppy change/insertion and be able to
informed of media 'type' w/o kernel warnings/error messages.  It sounds like
there is no kernel support for this so far?

	Then it seems the less ideal question is what is the "approved and recommended
way for a program to "poll" such devices to check for 'changes' and 'media type'
without the kernel generating spurious WARNINGS/ERRORS?


-- 
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
