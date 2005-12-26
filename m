Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbVLZS5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbVLZS5q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 13:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbVLZS5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 13:57:46 -0500
Received: from xenotime.net ([66.160.160.81]:59857 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932098AbVLZS5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 13:57:45 -0500
Date: Mon, 26 Dec 2005 10:58:22 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jaco Kroon <jaco@kroon.co.za>
Cc: rlrevell@joe-job.com, jason@stdbev.com, rostedt@goodmis.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz, s0348365@sms.ed.ac.uk
Subject: Re: recommended mail clients
Message-Id: <20051226105822.538a31d9.rdunlap@xenotime.net>
In-Reply-To: <43B03658.9040108@kroon.co.za>
References: <43AF7724.8090302@kroon.co.za>
	<43AFB005.50608@kroon.co.za>
	<1135607906.5774.23.camel@localhost.localdomain>
	<200512261535.09307.s0348365@sms.ed.ac.uk>
	<1135619641.8293.50.camel@mindpipe>
	<0f197de4ee389204cc946086d1a04b54@stdbev.com>
	<1135621183.8293.64.camel@mindpipe>
	<43B03658.9040108@kroon.co.za>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Dec 2005 20:28:40 +0200 Jaco Kroon wrote:

> Lee Revell wrote:
> > On Mon, 2005-12-26 at 12:09 -0600, Jason Munro wrote:
> > 
> >>On 11:54:00 am 26 Dec 2005 Lee Revell <rlrevell@joe-job.com> wrote:
> >>
> >><snip>
> >>
> >>>> Dare I say it, KMail has also been doing the Right Thing for a
> >>>> long time. It will only line wrap things that you insert by
> >>>> typing; pastes are left untouched.

sylpheed also DTRT.  (http://sylpheed.good-day.net)
It's a simple, clean email client.

> I've looked at a few clients and it seems I'm stuck with mozilla for at
> least a while.  Whilst probably the buggiest client there is it does
> look like it's the best suited for what I want.  I might switch to
> FireFox (which iirc does have an "insert file" feature - which might
> also solve this problem).

Firefox has an email interface??

> For the moment though I'm quickly hacking together a bash script that
> wraps the sendmail binary that can be used specifically for submitting
> patches (the intent is to perform certain checks for Signed-of-by lines,
> correct [PATCH] subject and so forth).  If anybody else is interrested
> I'd be more than happy to share (albeit I suspect the usefullness will
> be seriously limited).

Greg KH and Paul Jackson have both written scripts for this.
And there may be one in the quilt package.

Paul's (python) is at
  http://www.speakeasy.org/~pj99/sgi/sendpatchset
I don't recall where Greg's is (perl).

---
~Randy
