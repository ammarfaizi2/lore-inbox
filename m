Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbTELTnl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 15:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbTELTnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 15:43:40 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:44237 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S262589AbTELTnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 15:43:39 -0400
Date: Mon, 12 May 2003 21:54:18 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Pavel Machek <pavel@suse.cz>, Linus Torvalds <torvalds@transmeta.com>,
       mikpe@csd.uu.se,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] restore sysenter MSRs at resume
Message-ID: <20030512195418.GA8943@elf.ucw.cz>
References: <200305101641.h4AGfEVE002970@harpo.it.uu.se> <Pine.LNX.4.44.0305111158500.12955-100000@home.transmeta.com> <20030511190822.GA1181@atrey.karlin.mff.cuni.cz> <1052681292.1869.5.camel@laptop-linux> <20030512113017.GA25757@atrey.karlin.mff.cuni.cz> <1052768026.1865.0.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052768026.1865.0.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Ok. I haven't updated it for 2.5.69 version, but it doesn't look like
> > > any changes are required. Here is the relevant part of the full swsusp
> > > patch.
> > 
> > I guess it still needs to be updated for the driver model....
> 
> Yes,
> 
> No time here :> I'm busy with my real work and with work on 2.4 swsusp.

Okay, I'll do it.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
