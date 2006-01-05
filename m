Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWAEP6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWAEP6P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWAEP6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:58:15 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:22227 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1750902AbWAEP6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:58:14 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: 2.6.14.5 to 2.6.15 patch
Date: Thu, 5 Jan 2006 15:55:25 +0000
User-Agent: KMail/1.9
Cc: "H. Peter Anvin" <hpa@zytor.com>, Greg KH <greg@kroah.com>,
       Nick Warne <nick@linicks.net>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org, webmaster@kernel.org
References: <200601041710.37648.nick@linicks.net> <200601051525.05613.s0348365@sms.ed.ac.uk> <9a8748490601050737y24f04505hb605fbe96fe4f92c@mail.gmail.com>
In-Reply-To: <9a8748490601050737y24f04505hb605fbe96fe4f92c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601051555.25915.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 January 2006 15:37, Jesper Juhl wrote:
> On 1/5/06, Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > On Thursday 05 January 2006 00:08, H. Peter Anvin wrote:
> > > Alistair John Strachan wrote:
> > > > Re-read the thread. The confusion here is about "going back" to
> > > > 2.6.14 before patching 2.6.15. This has nothing to do with "rc
> > > > kernels". We have this documented explicitly in the kernel but not on
> > > > the kernel.org FAQ.
> > >
> > > If you can send me some suggested verbiage I'll put it in the FAQ.  We
> > > can also make a page that's directly linked from the "stable release",
> > > kind of like we have info links for -mm patches etc.
> >
> > I hope somebody else here can minimise my logic; I think the verbosity is
> > necessary to completely explain the "patch nightmare" to everybody
> > concerned.
>
> [snip]
>
> Nice writeup, but why not simply put a copy of
> Documentation/applying-patches.txt online and link to that?
> It contains more or less the same stuff you just wrote.

It's certainly one possibility, but this file is at least 4x more verbose than 
my summary. I aimed to write something instructional, rather than provide a 
complete explanation of the "patch problem".

If this issue is large enough to get its own page on kernel.org, then a more 
complete description may indeed be justified. Comments?

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
