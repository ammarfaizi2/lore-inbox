Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWAIPgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWAIPgn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 10:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWAIPgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 10:36:43 -0500
Received: from xenotime.net ([66.160.160.81]:28584 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964796AbWAIPgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 10:36:41 -0500
Date: Mon, 9 Jan 2006 07:36:37 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Lee Revell <rlrevell@joe-job.com>
cc: Yaroslav Rastrigin <yarick@it-territory.ru>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>, andersen@codepoet.org,
       linux-kernel@vger.kernel.org
Subject: Re: [OT?] Re: Why the DOS has many ntfs read and write driver,but
 the linux can't for a long time
In-Reply-To: <1136819703.9957.10.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0601090735520.15949@shark.he.net>
References: <174467f50601082354y7ca871c7k@mail.gmail.com> 
 <200601091403.46304.yarick@it-territory.ru>  <1136814862.9957.5.camel@mindpipe>
  <200601091751.27405.yarick@it-territory.ru> <1136819703.9957.10.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2006, Lee Revell wrote:

> On Mon, 2006-01-09 at 17:51 +0300, Yaroslav Rastrigin wrote:
> > Hi, Lee,
> > On 9 January 2006 16:54, you wrote:
> > > >
> > >
> > > Where are the bug reports?  You didn't expect these to just fix
> > > themselves did you?
> > Been there, done that. Bugreport about malfunctioning (due to ACPI) 3c556 in IBM ThinkPad T20 was looked at once in a few months without any progress,
> > and I've finally lost track of it after changing hardware. In more than a year this problem wasn't solved, so I'm assuming bugreports aren't so effective.
> > 2200BG ping and packet loss problem was reported in ipw2200-devel mailing list recently (by another user), and the only answer was
> > "Switch to version 1.0.0" (which is tooo old and missing needed features and bugfixes, so recommentation was unacceptable). So I'm assuming addressing
> > developers directly is not too effective either.
> > Two other options I see are to debug/fix it by myself and try to stimulate others monetarily. First option isn't really affordable for me ,
> > so I'm trying to research second.
>
> Bug reports certainly are effective, but if no one else can reproduce
> your problem then obviously it can't be fixed.

That's not a good attitude IMO.  I'd bet that Linus and Andrew have fixed
lots of bugs that they couldn't reproduce.

> A bug report that gets no responses is a good sign that you need to
> provide more information or work a little harder to debug it yourself.

-- 
~Randy
