Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265231AbUAJPQe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 10:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265232AbUAJPQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 10:16:33 -0500
Received: from gprs214-70.eurotel.cz ([160.218.214.70]:385 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265231AbUAJPQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 10:16:32 -0500
Date: Sat, 10 Jan 2004 16:15:42 +0100
From: Pavel Machek <pavel@suse.cz>
To: George Anzinger <george@mvista.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: kgdb cleanups
Message-ID: <20040110151542.GC532@elf.ucw.cz>
References: <20040109183826.GA795@elf.ucw.cz> <3FFF2304.8000403@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFF2304.8000403@mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >No real code changes, but cleanups all over the place. What about
> >applying?
> >
> >Ouch and arch-dependend code is moved to kernel/kgdb.c. I'll probably
> >do x86-64 version so that is rather important.
> >
> >								Pavel
> A few comments:
> 
> I like the code seperation.  Does it follow what Amit is doing?  It would 
> be nice if Amit's version and this one could come together around
> >this.

No, it does not follow Amit's work.

...and that's a problem because Amit's work looks way better than
this. I guess I need to start again, relative to Amit's patches this
time.

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
