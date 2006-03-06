Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751670AbWCFVyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbWCFVyF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752434AbWCFVyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:54:05 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30083 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751670AbWCFVyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:54:03 -0500
Date: Mon, 6 Mar 2006 22:53:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: M?ns Rullg?rd <mru@inprovide.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] inotify hack for locate
Message-ID: <20060306215332.GA4836@elf.ucw.cz>
References: <35fb2e590603051336t5d8d7e93i986109bc16a8ec38@mail.gmail.com> <1141594983.14714.121.camel@mindpipe> <20060305230821.GA20768@kvack.org> <yw1xu0acbhby.fsf@agrajag.inprovide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xu0acbhby.fsf@agrajag.inprovide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 05-03-06 23:30:09, M?ns Rullg?rd wrote:
> Benjamin LaHaise <bcrl@kvack.org> writes:
> 
> > On Sun, Mar 05, 2006 at 04:43:03PM -0500, Lee Revell wrote:
> >> updatedb runs at nice 20 on most distros, and with the CFQ scheduler the
> >> IO priority follows the nice value, so why does it still kill the
> >> machine?
> >
> > Running updatedb on a laptop when you're sitting in an airplane running 
> > off of batteries is Not Nice to the user.  I know, I've had it happen far 
> > too many times.
> 
> Running updatedb only if AC powered shouldn't be too difficult.

That makes locate useless on some machines. I have sharp zaurus C3000
here... It is either powered on *or* connected on AC, but very rarely
connected to ac while turned on. Well, its power plug located at weird
place and old software version that prevents charging while turned on
is contributory factor, but...

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
