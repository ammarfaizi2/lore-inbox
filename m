Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270536AbTGSUPc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 16:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270537AbTGSUPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 16:15:32 -0400
Received: from filesrv1.system-techniques.com ([199.33.245.55]:64135 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id S270536AbTGSUP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 16:15:27 -0400
Date: Sat, 19 Jul 2003 16:30:24 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Mark Mielke <mark@mark.mielke.cc>
cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: SCM file system (Was Re: Bitkeeper)
In-Reply-To: <20030719161725.GD17587@mark.mielke.cc>
Message-ID: <Pine.LNX.4.56.0307191627200.3541@filesrv1.baby-dragons.com>
References: <200307191600.h6JG0OZd002669@81-2-122-30.bradfords.org.uk>
 <20030719161725.GD17587@mark.mielke.cc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello Mark All ,  (I hate continuing this thread But) A thought
	just (re-)occured to me that for those people who -really- need
	it .  What about an SCM file system ?  Thoughts , anger ,
	complancency ?  Twys ,  JimL

On Sat, 19 Jul 2003, Mark Mielke wrote:
> On Sat, Jul 19, 2003 at 05:00:24PM +0100, John Bradford wrote:
> > > Any investment into writing a new source management
> > > system would be better served by improving the linux source code.
> > What happens if somebody develops a really good versioned filesystem
> > for Linux, would it not get merged, because the linux kernel would
> > then contain SCM-like functionality?
> One day, when it happens, we'll see what ripple effects it has.
> In most cases, however, I suspect that a versioned file system will never
> be a replacement for a good source management system. The lines could become
> blurred, but the 'good versioned file system' might take the form a kernel
> module that allowed SCM systems to plug into it, at which point, Bit Keeper
> might plug into it, and everybody would be happy. I doubt you want to put
> merge manager functionality into the kernel, or many of the other components
> of a good source management system. The storage and access is one of the
> lesser concerns. Bit Keeper uses similar storage and access methods as
> SCCS, does it not?
-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+
