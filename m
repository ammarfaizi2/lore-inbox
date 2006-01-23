Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWAWExl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWAWExl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 23:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWAWExl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 23:53:41 -0500
Received: from xenotime.net ([66.160.160.81]:23207 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932082AbWAWExk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 23:53:40 -0500
Date: Sun, 22 Jan 2006 20:53:49 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andi Kleen <ak@suse.de>, tali@admingilde.org
Cc: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Fixing make mandocs
Message-Id: <20060122205349.0ec46cbe.rdunlap@xenotime.net>
In-Reply-To: <200601230552.09142.ak@suse.de>
References: <200601230531.27609.ak@suse.de>
	<20060122204921.613349e5.rdunlap@xenotime.net>
	<200601230552.09142.ak@suse.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2006 05:52:08 +0100 Andi Kleen wrote:

> On Monday 23 January 2006 05:49, Randy.Dunlap wrote:
> > On Mon, 23 Jan 2006 05:31:27 +0100 Andi Kleen wrote:
> > 
> > > 
> > > Here would be a good janitor task for 2.6.16. make mandocs currently
> > > doesn't build because a number of descriptions are missing parameters etc.
> > > It would be good if someone could fix that and submit patches for 2.6.16.
> > > 
> > > It should be relatively straight forward, if one cannot figure out
> > > what a missing parameter does adding a dummy description ("Undocumented") 
> > > would be also ok.
> > > 
> > > -Andi
> > 
> > Lots of these have been fixed in the last 2-3 days by Martin Waitz
> > and/or me and have been posted on lkml.  Martin is collecting them
> > in his kernel-doc tree.
> 
> Ok good. Are they going into 2.6.16?

I have no idea.  Depends on whether Martin (cc-ed) or Andrew
pushes them, I guess.

---
~Randy
