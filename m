Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWBCLob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWBCLob (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 06:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbWBCLob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 06:44:31 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:139 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030187AbWBCLob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 06:44:31 -0500
Date: Fri, 3 Feb 2006 12:44:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060203114419.GB2972@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060202152316.GC8944@ucw.cz> <20060202132708.62881af6.akpm@osdl.org> <200602030918.07006.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602030918.07006.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > So, as promised, there's nothing useful here.  What we'd most like to see
> > is for Nigel to start working on in-kernel swsusp, merging up the good bits
> > from suspend2 in some evolutionary incremental manner under which the
> > kernel continually improves.  If, at the end of the day, that ends up with
> > us having a complete implementation of suspend2, well, Mission
> > Accomplished?
> 
> Thanks for the reply. You're right. It doesn't help at all :)
> 
> Well, actually it does.
> 
> It reminds me why I started working on this in the first place. It wasn't 
> because I wanted to be a big shot kernel developer or the like, or have my 
> name in the kernel credits. It was because I wanted to use the code.
> 
> So, given that I'm perfectly willing to send Pavel patches, but he's not 
> willing to take them, I guess I the best thing I can do is to just let Pavel 
> have his way, give up on the concept of merging Suspend2 and maintain it out 
> of tree. When Pavel and Rafael get swsusp up to scratch, I can stop doing 
> that and just use their version.

[Pavel is willing to take patches, as his cooperation with Rafael
shows, but is scared by both big patches and series of 10 small
patches he does not understand. He likes patches removing code.]
									Pavel
-- 
Thanks, Sharp!
