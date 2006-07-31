Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWGaQYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWGaQYO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 12:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbWGaQYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 12:24:14 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49549 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030222AbWGaQYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 12:24:12 -0400
Date: Mon, 31 Jul 2006 18:23:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Hua Zhong <hzhong@gmail.com>, "'Rafael J. Wysocki'" <rjw@sisk.pl>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: suspend2 merge history [was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion]
Message-ID: <20060731162358.GC3445@elf.ucw.cz>
References: <200607300054.18231.rjw@sisk.pl> <00c801c6b427$20d545d0$0200a8c0@nuitysystems.com> <20060730230757.GA1800@elf.ucw.cz> <44CE13A7.5010206@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CE13A7.5010206@tmr.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Suspend2 patch is open source. You can always take a look.
> >
> >swsusp is open source. You can always take a look. And you can always
> >submit a patch.

> But you can't get the patch accepted, that's issue causing all this 
> discussion.

If you send me a reasonably-sized patch, that actually fixes
something, I'm likely to apply it. If you send me 14K line monster...

> >>I'm not exactly an expert, but I don't think suspend-to-ram is more
> >>difficult than suspend-to-disk (probably quite the contrary), and
> >>there are a lot in common.
> >
> >As you said, you do not know what you are talking about.
> >
> That's why people are frustrated. You blow off anyone who tells you the 
> code doesn't work. Do you really think Linus doesn't know what he's 
> talking about when he reported that it didn't work for him? Hua Zhong 
> being "Not an expert" is not the same as not knowing what he's talking 
> about.

He claims s-t-ram is easier than s-t-disk. That means that he did not
do his homework, and did not check the archives on the subject.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
