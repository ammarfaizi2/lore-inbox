Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbUCAUWu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 15:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUCAUWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 15:22:50 -0500
Received: from gprs159-101.eurotel.cz ([160.218.159.101]:9089 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261414AbUCAUWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 15:22:48 -0500
Date: Mon, 1 Mar 2004 21:22:36 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: M?ns Rullg?rd <mru@kth.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dropping CONFIG_PM_DISK?
Message-ID: <20040301202236.GF562@elf.ucw.cz>
References: <20040229162317.GC283@elf.ucw.cz> <yw1x4qt93i6y.fsf@kth.se> <20040229181053.GD286@elf.ucw.cz> <yw1xznb120zn.fsf@kth.se> <20040301094023.GF352@elf.ucw.cz> <yw1xhdx8ani6.fsf@kth.se> <20040301103946.GA9171@atrey.karlin.mff.cuni.cz> <1078135138.3884.19.camel@laptop-linux.wpcb.org.au> <20040301124610.GA1744@openzaurus.ucw.cz> <1078164961.4408.25.camel@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078164961.4408.25.camel@laptop-linux.wpcb.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Forgive my ignorance, but I don't see how that could be something that
> makes suspend2 less stable than the already-merged versions. They have
> the same problem (assuming your patch hasn't been merged yet).

Okay... well...

swsusp2 is meant to be feature-full. in kernel swsusp is meant to be
stable. Perhaps swsusp2 manages to be both feature-full and stable at
same time; at that point I'm obviously doing not-too-good job.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
