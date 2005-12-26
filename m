Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbVLZUDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbVLZUDY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 15:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbVLZUDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 15:03:24 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:46542 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S932127AbVLZUDX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 15:03:23 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: recommended mail clients [was] [PATCH] ati-agp suspend/resume support (try 2)
Date: Mon, 26 Dec 2005 20:03:38 +0000
User-Agent: KMail/1.9
Cc: Steven Rostedt <rostedt@goodmis.org>, Jaco Kroon <jaco@kroon.co.za>,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <43AF7724.8090302@kroon.co.za> <200512261535.09307.s0348365@sms.ed.ac.uk> <1135619641.8293.50.camel@mindpipe>
In-Reply-To: <1135619641.8293.50.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512262003.38552.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 December 2005 17:54, Lee Revell wrote:
> On Mon, 2005-12-26 at 15:35 +0000, Alistair John Strachan wrote:
> > On Monday 26 December 2005 14:38, Steven Rostedt wrote:
[snip]
> > >
> > > I use pine and evolution.  Pine is text based and great when I ssh into
> > > my machine to work.  Evolution is slow, but plays well with pine and it
> > > handles things needed for LKML very well. (the drop down menu "Normal"
> > > may be changed to "Preformat", which allows of inserting text files
> > > "as-is").
> >
> > Dare I say it, KMail has also been doing the Right Thing for a long time.
> > It will only line wrap things that you insert by typing; pastes are left
> > untouched.
>
> It seems that of all the popular mail clients only Thunderbird has this
> problem.  AFAICT it's impossible to make it DTRT with inline patches and
> even if it is the fact that most users get it wrong points to a serious
> usability/UI issue.
>
> Would a patch to add "Don't use Thunderbird/Mozilla Mail" to
> SubmittingPatches be accepted?  Then we can point the Mozilla developers
> at it (they have shown zero interest in fixing the problem so far) and
> hopefully this will light a fire under someone.

Fundamentally the issue with Thunderbird is that it line-wraps AFTER you 
compose an email, not during composition. I've never understood how, or why 
this is useful to the end user, except for composing HTML emails (which 
should be banned anyway).

Thunderbird is Yet Another mailer that could have been a good piece of 
software if it hadn't attempted to be a clone of Outlook Express (defaulting 
to Top Posting, HTML composition, line wrapping pastes).

It's the mindset; fixing Thunderbird is probably easy, but convincing the 
Mozilla developers to include such "fixes" is probably much harder.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
