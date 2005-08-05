Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262876AbVHES3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262876AbVHES3Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 14:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbVHES3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 14:29:19 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:49103 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S262861AbVHES3J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 14:29:09 -0400
Date: Fri, 5 Aug 2005 14:29:04 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: francoisgrand@free.fr,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: system freeze on USB plug
In-Reply-To: <20050804123834.0c4e7f91.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0508051428090.4895-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2005, Andrew Morton wrote:

> francoisgrand@free.fr wrote:
> >
> > I'd like to report a system freeze happening on USB device plug.
> 
> Many others reported similar problems.  There have been many weird USB
> problems reported across the 2.6.13 cycle and I've lost the plot on which
> ones remain unfixed and which ones are regressions since 2.6.12.
> 
> So I'm going to stop tracking all non-bugzilla'ed USB bug reports.  -rc6
> will be out soon - if anyone still has USB problems in rc6 which aren't in
> bugzilla, then please get them in there, thanks.


Francois:

You should look at

http://bugme.osdl.org/show_bug.cgi?id=4944

This appears to be almost exactly the same as your problem, even though
the motherboard is completely different.  Instead of starting a new bug
report of your own, just add your address to the CC: list for this bug and
add a comment summarizing your experiences.

Alan Stern


