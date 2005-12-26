Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbVLZESe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbVLZESe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 23:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbVLZESd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 23:18:33 -0500
Received: from mx1.rowland.org ([192.131.102.7]:57605 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1750994AbVLZESd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 23:18:33 -0500
Date: Sun, 25 Dec 2005 23:18:32 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Lee Revell <rlrevell@joe-job.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] CONFIG_USB_BANDWIDTH broken
In-Reply-To: <1135570637.8293.26.camel@mindpipe>
Message-ID: <Pine.LNX.4.44L0.0512252317350.15623-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Dec 2005, Lee Revell wrote:

> On Sun, 2005-12-25 at 22:58 -0500, Alan Stern wrote:
> > On Sun, 25 Dec 2005, Lee Revell wrote:
> > 
> > > CONFIG_USB_BANDWIDTH breaks USB audio.  This has been a problem for at
> > > least 6 months.
> > > 
> > > Typical bug report:
> > > 
> > > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1642
> > > 
> > > (search bug tracker for CONFIG_USB_BANDWIDTH to see many more)
> > > 
> > > Is anyone working on fixing this?
> > 
> > The bug reports don't mention which USB host controller driver was being 
> > used.

> Thanks, I'll try to get this info from the users.
> 
> So the solution for now is to educate users not to use it (and
> especially, distros not to enable it).

That's right.

Alan Stern

