Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317958AbSGPUBc>; Tue, 16 Jul 2002 16:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317961AbSGPUBc>; Tue, 16 Jul 2002 16:01:32 -0400
Received: from msp-65-29-16-62.mn.rr.com ([65.29.16.62]:60033 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S317958AbSGPUBa>; Tue, 16 Jul 2002 16:01:30 -0400
Date: Tue, 16 Jul 2002 15:04:22 -0500
From: Shawn <core@enodev.com>
To: linux-kernel@vger.kernel.org, Stelian Pop <stelian.pop@fr.alcove.com>,
       Gerhard Mack <gmack@innerfire.net>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020716150422.A6254@q.mn.rr.com>
References: <20020716124956.GK7955@tahoe.alcove-fr> <Pine.LNX.4.44.0207161107550.17919-100000@innerfire.net> <20020716153926.GR7955@tahoe.alcove-fr> <20020716194542.GD22053@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020716194542.GD22053@merlin.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Tue, Jul 16, 2002 at 09:45:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You don't.

This is where you have a filesystem where syslog, xinetd, blogd,
bloatd-config-d2, raffle-ticketd DO NOT LIVE.

People forget so easily the wonders of multiple partitions.

On 07/16, Matthias Andree said something like:
> On Tue, 16 Jul 2002, Stelian Pop wrote:
> 
> > On Tue, Jul 16, 2002 at 11:11:20AM -0400, Gerhard Mack wrote:
> > 
> > > In other words you have a backup system that works some of the time or
> > > even most of the time... brilliant!
> > 
> > Dump is a backup system that works 100% of the time when used as 
> > it was designed to: on unmounted filesystems (or mounted R/O).
> 
> Practical question: how do I get a file system mounted R/O for backup
> with dump without putting that system into single-user mode?
> Particularly when running automated backups, this is an issue. I cannot
> kill all writers (syslog, Postfix, INN, CVS server, ...) on my
> production machines just for the sake of taking a backup.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
Shawn Leas
core@enodev.com

So, do you live around here often?
						-- Stephen Wright
