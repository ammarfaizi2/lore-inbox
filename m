Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262087AbTCLXA0>; Wed, 12 Mar 2003 18:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262096AbTCLWwB>; Wed, 12 Mar 2003 17:52:01 -0500
Received: from [195.39.17.254] ([195.39.17.254]:11780 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262083AbTCLWvB>;
	Wed, 12 Mar 2003 17:51:01 -0500
Date: Wed, 12 Mar 2003 23:59:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: xmms (audio) skipping in 2.5 (not 2.4)
Message-ID: <20030312225945.GA5958@zaurus.ucw.cz>
References: <103200000.1046755559@[10.10.2.4]> <200303041636.00745.kernel@kolivas.org> <104910000.1046757141@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <104910000.1046757141@[10.10.2.4]>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > the  "desktop tuning" of making the max timeslice==min timeslice. Try an
> > -mm  kernel with the scheduler tunables patch and try playing with the
> > max  timeslice. Most have found that <=25 will usually stop these skips.
> > The  default max timeslice of 300ms is just too long for the desktop and 
> > interactivity estimator.
> 
> Heh, cool. I have the same patch in my tree too, fixed it without rebooting
> even ;-) Still a *tiny* bit of skipping, but infinitely better than it was.

Fixed without rebooting? You binary-patched
kernel or what?
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

