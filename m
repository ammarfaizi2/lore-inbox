Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbTDWNew (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 09:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264031AbTDWNew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 09:34:52 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:28893 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264030AbTDWNev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 09:34:51 -0400
Date: Wed, 23 Apr 2003 09:32:56 -0400
From: Ben Collins <bcollins@debian.org>
To: Stelian Pop <stelian.pop@fr.alcove.com>,
       Tony Spinillo <tspinillo@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
Message-ID: <20030423133256.GG354@phunnypharm.org>
References: <20030423122940.51011.qmail@web14002.mail.yahoo.com> <20030423125315.GH820@hottah.alcove-fr> <20030423130139.GD354@phunnypharm.org> <20030423132227.GI820@hottah.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423132227.GI820@hottah.alcove-fr>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 03:22:27PM +0200, Stelian Pop wrote:
> On Wed, Apr 23, 2003 at 09:01:39AM -0400, Ben Collins wrote:
> 
> > > I'll leave up to the ieee1394 developpers to decide if some other,
> > > semaphore based, locking is still necessary here.
> > 
> > The patch is broken, and the problem is already fixed in our repo. Just
> > a matter of getting Marcelo to accept my patch before 2.4.21 is
> > released.
> 
> Can we see it please ?

Stelia,

http://www.linux1394.org/viewcvs/ieee1394/branches/linux-2.4

Click the "Download tarball" link and replace drivers/ieee1394 with what
you get.


Tony, you are seeing a different problem. I'll get you a patch soon (for
the record, I'm not even subscribed to linux1394-user, but to
linux1394-devel).

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
