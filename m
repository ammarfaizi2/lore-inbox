Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263359AbSJFIp3>; Sun, 6 Oct 2002 04:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263360AbSJFIp3>; Sun, 6 Oct 2002 04:45:29 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:54727 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP
	id <S263359AbSJFIp3>; Sun, 6 Oct 2002 04:45:29 -0400
Message-Id: <200210060846.g968klWf000632@pool-141-150-241-241.delv.east.verizon.net>
Date: Sun, 6 Oct 2002 04:46:45 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New BK License Problem?
References: <20021005112552.A9032@work.bitmover.com> <20021005184153.GJ17492@marowsky-bree.de> <20021005190638.GN585@phunnypharm.org> <3D9F3C5C.1050708@redhat.com> <20021005124321.D11375@work.bitmover.com> <3D9F49D9.304@redhat.com> <20021005162852.I11375@work.bitmover.com> <1033861827.4441.31.camel@irongate.swansea.linux.org.uk> <20021005165316.E12580@work.bitmover.com> <3D9FF435.1030604@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D9FF435.1030604@pobox.com>; from jgarzik@pobox.com on Sun, Oct 06, 2002 at 04:28:37AM -0400
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out002.verizon.net from [141.150.241.241] at Sun, 6 Oct 2002 03:51:00 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Larry McVoy wrote:
> > Anyway, we have the BK data, if you have data that says the rate of change
> > has gone down since he started using BK, let's see it.  If all you are 
> > saying is that he isn't publishing ftp-able snapshots every hour, that's
> > a problem that HPA or whoever could easily fix with a shell script.
> 
> Hourly snapshots can easily be done if wanted.
> Just a simple "crontab -e" for me.
> 
> Note they are public now, at 
> ftp://ftp.kernel.org/pub/linux/kernel/v2.5/snapshots/
> (and I promised Marcelo I would do this for 2.4 too...)

What I would like to see is a 'linux-commits' mailing list where
Woodhouse's per changeset diffs can all be posted.  Refreshing the webpage
over and over waiting for new patches isn't fun.  And that info can't be
fingered for.

I appreciate that he does it.  It's a nice service he provides.  But I'm
sure Linus could write a script that mails 'linux-commits' with a diff
for each changeset easily.

-- 
Skip
