Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267854AbTB1NJw>; Fri, 28 Feb 2003 08:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267858AbTB1NJv>; Fri, 28 Feb 2003 08:09:51 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16908 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267854AbTB1NJv>; Fri, 28 Feb 2003 08:09:51 -0500
Date: Fri, 28 Feb 2003 14:20:11 +0100
From: Pavel Machek <pavel@suse.cz>
To: Ben Collins <bcollins@debian.org>
Cc: "David S. Miller" <davem@redhat.com>, pavel@suse.cz,
       linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, ak@suse.de,
       arnd@bergmann-dalldorf.de
Subject: Re: ioctl32 consolidation -- call for testing
Message-ID: <20030228132010.GB8498@atrey.karlin.mff.cuni.cz>
References: <20030226222606.GA9144@elf.ucw.cz> <20030227195135.GN21100@phunnypharm.org> <20030227202739.GO21100@phunnypharm.org> <20030227.121302.86023203.davem@redhat.com> <20030227203440.GP21100@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030227203440.GP21100@phunnypharm.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >    From: Ben Collins <bcollins@debian.org>
> >    Date: Thu, 27 Feb 2003 15:27:39 -0500
> >    
> >    Here it is. Sparc64's macros for ioctl32's assumed that cmd was u_int
> >    instead of u_long. This look ok to you, Dave?
> > 
> > We would love to see that patch :-)
> 
> It was real small...so small that it slipped through mutt's open() call
> and never got attached :)

Applied.

							Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
