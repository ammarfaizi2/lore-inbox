Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262760AbTCJXKR>; Mon, 10 Mar 2003 18:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262762AbTCJXKR>; Mon, 10 Mar 2003 18:10:17 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54545 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262760AbTCJXKR>; Mon, 10 Mar 2003 18:10:17 -0500
Date: Tue, 11 Mar 2003 00:20:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Patrick Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SWSUSP Discontiguous pagedir patch
Message-ID: <20030310232057.GC8555@atrey.karlin.mff.cuni.cz>
References: <20030307202759.GA2447@elf.ucw.cz> <Pine.LNX.4.33.0303101012230.1002-100000@localhost.localdomain> <20030310192300.GC11310@atrey.karlin.mff.cuni.cz> <1047334626.6245.30.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047334626.6245.30.camel@laptop-linux.cunninghams>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Do you think you can suspend with 90% memory kmalloc()-ed?
> 
> Is that a fair question? Would 90% of memory ever be kmalloced? If the
> question is can you suspend with 90% of memory used, then I can answer
> yes. I do it all the time under the code I'm porting to 2.5. (Nearly
> there, by the way).

No, it was not fair question, not at all. If he'd replied with yes,
I'd tell him I don't believe that ;-).
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
