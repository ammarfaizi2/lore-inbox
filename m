Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261223AbSJCMXQ>; Thu, 3 Oct 2002 08:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261224AbSJCMXQ>; Thu, 3 Oct 2002 08:23:16 -0400
Received: from h181n1fls11o1004.telia.com ([195.67.254.181]:54403 "EHLO
	ringstrom.mine.nu") by vger.kernel.org with ESMTP
	id <S261223AbSJCMXP>; Thu, 3 Oct 2002 08:23:15 -0400
Date: Thu, 3 Oct 2002 14:28:44 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: tori@boris.prodako.se
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.40: AT keyboard input problem
In-Reply-To: <20021003141021.A38642@ucw.cz>
Message-ID: <Pine.LNX.4.44.0210031427260.14274-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2002, Vojtech Pavlik wrote:

> On Thu, Oct 03, 2002 at 02:08:26PM +0200, Tobias Ringstrom wrote:
> > On Thu, 3 Oct 2002, Vojtech Pavlik wrote:
> > 
> > > Yes, please try with #I8042_DEBUG_IO enabled, try all the suspicious key
> > > combinations and add comments to the log file which is which. This will
> > > allow me to fix it properly.
> > 
> > I hope this is enough.  There are more combinations, I'm sure.  I hope 
> > that it is one bug causing them all, though.
> 
> Perfect, thanks.
> 
> Are you possible to reproduce it when you use "i8042_direct" on the
> kernel command line?

No, the problem went away.

/Tobias

