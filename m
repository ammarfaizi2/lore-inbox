Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161015AbWBTQd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbWBTQd3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161023AbWBTQc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:32:57 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2189 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161020AbWBTQcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:32:48 -0500
Date: Mon, 20 Feb 2006 14:37:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Lee Revell <rlrevell@joe-job.com>, Matthias Hensler <matthias@wspse.de>,
       Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220133724.GA17979@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060220101018.GA21817@kobayashi-maru.wspse.de> <1140430528.3429.11.camel@mindpipe> <200602202044.53794.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602202044.53794.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 20-02-06 20:44:48, Nigel Cunningham wrote:
> Hi.
> 
> On Monday 20 February 2006 20:15, Lee Revell wrote:
> > On Mon, 2006-02-20 at 11:10 +0100, Matthias Hensler wrote:
> > > > Why can't people understand that arguing "it works" without any
> > > > consideration of possible performance tradeoffs is not a good enough
> > > > argument for merging?
> > >
> > > It sure isn't the argument, you are right. My main concern here is to
> > > throw away a working implementation and starting over from the scratch,
> > > instead of solving these problems.
> >
> > Take it up with the author for not working more closely with the kernel
> > developers while Suspend2 was being developed, AFAICT a LOT of this
> > could have been avoided with better communication.
> 
> Perhaps, but maybe there's more going on here than that.

Yes, there is:

1) you don't really watch mainline development.

2) you are not trying to improve mainline suspend, all you want is to
merge suspend2.

3) you ask me to trust you to clean it up after merge.

4) you still have code that was declared unacceptable 12 months
ago. ("press C to continue..." from kernel!)

5) you refuse to use existing mainline features, even through bugs
that forced you to reimplement them were fixed _long_ time ago.

6) you spread FUD about swsusp. (I.e. latest attempt to redefine
"working").

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
