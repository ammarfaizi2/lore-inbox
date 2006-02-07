Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbWBGW6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbWBGW6I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbWBGW54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:57:56 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54931 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030232AbWBGW5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:57:54 -0500
Date: Tue, 7 Feb 2006 23:57:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Lee Revell <rlrevell@joe-job.com>, Jim Crilly <jim@why.dont.jablowme.net>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, suspend2-devel@lists.suspend2.net,
       linux-kernel@vger.kernel.org
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060207225734.GC2753@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <1139282224.2041.48.camel@mindpipe> <20060207093317.GB1742@elf.ucw.cz> <200602071936.52245.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200602071936.52245.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 07-02-06 19:36:45, Nigel Cunningham wrote:
> Hi.
> 
> On Tuesday 07 February 2006 19:33, Pavel Machek wrote:
> > On Po 06-02-06 22:17:04, Lee Revell wrote:
> > > On Mon, 2006-02-06 at 22:01 -0500, Jim Crilly wrote:
> > > > With uswsusp it'll be more flexible in that you'll be able to use any
> > > > userland process or library to transform the image before storing it, but
> > > > the suspend and resume processes are going to be a lot more complicated.
> > > > For instance, how are you going to tell the kernel that you need the
> > > > uswsusp UI binary, /bin/gzip and /usr/bin/gpg to run after the rest of
> > > > userland has been frozen?
> > > 
> > > Unless someone at least gives a rough estimate of 1) what % of users
> > > can't suspend their laptops now and 2) of these, what % are helped by
> > > suspend2, this thread is just handwaving...
> > 
> > and 3) for what % of users, suspend2 will actually break it (bugs
> > happen).
> > 
> > Anyway it seems to be something like 1) 90% 2) 1% 3) .5%
> 
> And the source for your numbers is?....

Educated guess :-).
								Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
