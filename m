Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285720AbSBXKYU>; Sun, 24 Feb 2002 05:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285747AbSBXKYJ>; Sun, 24 Feb 2002 05:24:09 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:27665 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S285720AbSBXKX5>; Sun, 24 Feb 2002 05:23:57 -0500
Date: Sun, 24 Feb 2002 11:23:54 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
Message-ID: <20020224112354.A355@ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0202230953290.14299-100000@penguin.transmeta.com> <Pine.LNX.4.10.10202232035190.5715-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10202232035190.5715-100000@master.linux-ide.org>; from andre@linuxdiskcert.org on Sat, Feb 23, 2002 at 08:42:37PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2002 at 08:42:37PM -0800, Andre Hedrick wrote:

> > What really bugs me about this is that while normally you're hard to
> > communicate with, this time you have actively _lied_ about the patches on
> > IRC and in email about how they will cause IDE corruption etc due to
> > timing changes.
> 
> Before I truley reply to this statement above, would you like to recant it?
> 
> > No such timing changes existed, and whenever you were asked about what was
> > actually actively _wrong_ with the patches, you didn't reply.
> 
> Here I question the taking of a patch 12 which altered the behavior of the
> subsystem baseclock to setting up PIO timings for the executing command
> block operations.  I then looked over the patch again and saw you had not
> taken it yet.
> 
> In that private email, I clearly stated I made a mistake in reading what
> was accepted into 2.5.5.  The fact is you had not accepted it yet.
> However I expect you will take it.  Given that very few people in the
> world have most of the hardware that was effected by that change, and even
> less have the NDA documents on the rules, please accept the change.

Maybe then you'll want to point out how patch #12 can change any PIO
timings? I'm definitely curious ... that'd affect my VIA driver as well,
you know ...

-- 
Vojtech Pavlik
SuSE Labs
