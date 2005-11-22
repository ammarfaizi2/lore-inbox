Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965107AbVKVSzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbVKVSzj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 13:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbVKVSzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 13:55:39 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22463 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965107AbVKVSzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 13:55:38 -0500
Date: Tue, 22 Nov 2005 19:53:23 +0100
From: Pavel Machek <pavel@suse.cz>
To: Bj?rn Mork <bmork@dod.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Message-ID: <20051122185323.GC1748@elf.ucw.cz>
References: <87zmoa0yv5.fsf@obelix.mork.no> <d120d5000511181532g69107c76x56a269425056a700@mail.gmail.com> <20051119234850.GC1952@spitz.ucw.cz> <200511220026.55589.dtor_core@ameritech.net> <871x19giuw.fsf@obelix.mork.no> <20051122174643.GB1752@elf.ucw.cz> <871x18ed96.fsf@obelix.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871x18ed96.fsf@obelix.mork.no>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> Maybe that even would give me a chance to fix some hardware problem
> >> causing the timeout, and then retry the resume.
> >
> > ..while doing resume few times, trying to change hw config to make it
> > resume is _way_ more dangerous.
> 
> I guess it would be.  But then, what are the chances it would make the
> situation any worse?  Probably never would work, but at least I would

Yes, you could make the situation worse -- if you actually
succeeded. We are talking silent corruption on filesystem here...

("swsusp gives you enough rope to blow up small town")...

> Thanks for all the good work!  I've been running Linux on a number of
> laptops since 1998 and am most impressed by the swsusp evolution the
> last few years.  Things weren't too bad when APM used to work and
> "lots of RAM" meant 80GB, but today I don't think I could use a laptop
> without swsusp.

Thanks. (I'd still like to see that 80GB laptop :-).
								Pavel
-- 
Thanks, Sharp!
