Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbVGZG3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVGZG3Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 02:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVGZG3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 02:29:15 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6059 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261768AbVGZG2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 02:28:42 -0400
Date: Tue, 26 Jul 2005 08:28:39 +0200
From: Pavel Machek <pavel@suse.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/2] Touchscreen support for sharp sl-5500
Message-ID: <20050726062839.GH8684@elf.ucw.cz>
References: <20050722180109.GA1879@elf.ucw.cz> <20050724174756.A20019@flint.arm.linux.org.uk> <20050725045607.GA1851@elf.ucw.cz> <20050725170419.C7629@flint.arm.linux.org.uk> <20050725220659.GF8684@elf.ucw.cz> <20050726000347.A913@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050726000347.A913@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > So, if the collie folk would like to clean their changes up and send
> > > them to me as the driver author, I'll see about integrating them into
> > > my version and we'll take it from there.
> > 
> > Okay, will do. [Is there chance to pull your tree using git? It would
> > help a bit...]
...
> However, if the UCB stuff is going to get worked on, I don't mind
> setting up, maintaining and publishing a git tree for that that,
> provided it then vanishes once merged into mainline.  That falls
> within the "very limited purposes" clause above.

Yes, that would help a lot, because I'd have a tree to diff against.

							Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
