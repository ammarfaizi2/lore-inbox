Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbVKBJvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbVKBJvz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 04:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbVKBJvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 04:51:55 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44425 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932505AbVKBJvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 04:51:54 -0500
Date: Wed, 2 Nov 2005 10:51:39 +0100
From: Pavel Machek <pavel@suse.cz>
To: Ben Dooks <ben@fluff.org.uk>
Cc: vojtech@suse.cz, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: best way to handle LEDs
Message-ID: <20051102095139.GB30220@elf.ucw.cz>
References: <20051101234459.GA443@elf.ucw.cz> <20051102024755.GA14148@home.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102024755.GA14148@home.fluff.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I think even slow blinking was used somewhere. I have some code from
> > John Lenz (attached); it uses sysfs interface, exports led collor, and
> > allows setting different frequencies.
> > 
> > Is that acceptable, or should some other interface be used?
> 
> there is already an LED interface for linux-arm, which is
> used by a number of the extant machines in the sa11x0 and
> pxa range.

Where is that interface? I think that making collie use it is obvious
first step...
								Pavel
-- 
Thanks, Sharp!
