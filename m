Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270864AbTHQVPm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 17:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271021AbTHQVPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 17:15:42 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:7810 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S270864AbTHQVPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 17:15:42 -0400
Date: Sun, 17 Aug 2003 22:27:08 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200308172127.h7HLR8Jq001586@81-2-122-30.bradfords.org.uk>
To: rob@landley.net
Subject: Re: [2.6 patch] let broken drivers depend on BROKEN{,ON_SMP}
Cc: davidsen@tmr.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It would be nice if there were some neat 3-D shreadsheet type thing
> > listing all drivers, all architectures, UP vs. SMP, and a status such as
> > WORKS, DOESN'T COMPILE, REPORTED PROBLEMS (SLOW|ERRORS|PANICS) and the
> > like. I don't even know where to find a good open source 3-D spreadsheet,
> > and the data certainly is scattered enough to be a project in itself,
> > chasing a moving target.
>
> You are aware that this would probably take more effort to keep up to date 
> than the code itself, right?  And that one spreadsheet couldn't 
> simultaneously be accurate for 2.4, 2.6, -ac, -mm, -redhat, -suse...
>
> And how would you keep track of weird "there's a good driver for that, but you 
> have to apply this patch" cases?  (Isn't this sort of thing what the various 
> bug database efforts are for?)

I implemented a spreadsheet-type display of which kernel versions
worked, didn't work, were untestable, and had patches available, in my
bug database, for each bug report.  The display looks good but I've
never really found it particularly useful :-).

John.
