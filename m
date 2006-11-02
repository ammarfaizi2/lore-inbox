Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752629AbWKBGth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbWKBGth (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 01:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752645AbWKBGth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 01:49:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50054 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752629AbWKBGtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 01:49:36 -0500
Date: Wed, 1 Nov 2006 22:49:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <gregkh@suse.de>
Cc: "Martin J. Bligh" <mbligh@google.com>,
       Cornelia Huck <cornelia.huck@de.ibm.com>,
       Mike Galbraith <efault@gmx.de>, Andy Whitcroft <apw@shadowen.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
Message-Id: <20061101224915.19d1b1ac.akpm@osdl.org>
In-Reply-To: <20061102064227.GA11693@suse.de>
References: <20061031174639.4d4d20e3@gondolin.boeblingen.de.ibm.com>
	<4547833C.5040302@google.com>
	<20061031182919.3a15b25a@gondolin.boeblingen.de.ibm.com>
	<4547FABE.502@google.com>
	<20061101020850.GA13070@suse.de>
	<45480241.2090803@google.com>
	<20061102052409.GA9642@suse.de>
	<45498174.5070309@google.com>
	<20061102060225.GA11188@suse.de>
	<20061101220701.78a1fa88.akpm@osdl.org>
	<20061102064227.GA11693@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2006 22:42:27 -0800
Greg KH <gregkh@suse.de> wrote:

> On Wed, Nov 01, 2006 at 10:07:01PM -0800, Andrew Morton wrote:
> > On Wed, 1 Nov 2006 22:02:25 -0800
> > Greg KH <gregkh@suse.de> wrote:
> > 
> > > > Thanks for fixing this up. If you could post a diff somewhere against
> > > > either mainline or -mm, would make it easy to run through
> > > > test.kernel.org before you wake up tommorow ;-)
> > > 
> > > Oops, the newest -mm just came out without any of the driver core
> > > patches in it due to the problems.  I'll wait until the next -mm release
> > > then, and try to go catch up on my pending-patch-queue right now
> > > instead...
> > 
> > Let me know when
> > http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-01-driver/
> > is ready to go and I'll prepare a new rollup.
> 
> It should be ready to go right now.  Fire away :)
> 

Poor Cornelia.  All her patches broke again.
