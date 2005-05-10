Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVEJJ31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVEJJ31 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 05:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVEJJ31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 05:29:27 -0400
Received: from ozlabs.org ([203.10.76.45]:17644 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261594AbVEJJ3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 05:29:25 -0400
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <gregkh@suse.de>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux@dominikbrodowski.net
In-Reply-To: <20050509232103.GA24238@suse.de>
References: <20050506212227.GA24066@kroah.com>
	 <1115611034.14447.11.camel@localhost.localdomain>
	 <20050509232103.GA24238@suse.de>
Content-Type: text/plain
Date: Tue, 10 May 2005 19:29:17 +1000
Message-Id: <1115717357.10222.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-09 at 16:21 -0700, Greg KH wrote: 
> On Mon, May 09, 2005 at 01:57:14PM +1000, Rusty Russell wrote:
> > On Fri, 2005-05-06 at 14:22 -0700, Greg KH wrote:
> > > Oh, and the upstream module-init-tools maintainer needs to accept that
> > > patch one of these days...
> > 
> > ??
> 
> I've attached the original message sent to you and me below.

Yes.  It broke into small pieces against the testsuite.  I know that
Linux kernel types generally don't consider that a problem 8)

So I rewrote it yesterday, so now it passes the testsuite.  I also added
a test.  It's in 3.2-pre4: if there are no more requests/bugs in the
next couple of days, I'll make that 3.3.

Thanks for the prodding!
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

