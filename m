Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSCWCEK>; Fri, 22 Mar 2002 21:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289272AbSCWCEA>; Fri, 22 Mar 2002 21:04:00 -0500
Received: from dt090ncb.san.rr.com ([204.210.46.203]:8204 "EHLO crash.cts.com")
	by vger.kernel.org with ESMTP id <S288748AbSCWCDr>;
	Fri, 22 Mar 2002 21:03:47 -0500
Date: Fri, 22 Mar 2002 18:03:45 -0800
From: Nick Pasich <npasich@crash.cts.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7-pre2 -- Error seeking in /dev/kmem.  Would someone please loo into this
Message-ID: <20020323020345.GA21353@204.210.46.203>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 I've been having the same problem and it's still happening in 2.5.7

                   ----( Nick Pasich )----

Skip Ford wrote:
 > Miles Lane wrote:
 > > Is anyone else seeing this?  I have been getting these errors
 > > throughout much of the 2.5 development cycle.  I am not sure
 > > when the problem started, since I have had a lot of trouble
 > > getting most of the 2.5 series kernels to build.
 > >
 > > Mar 17 11:15:02 turbulence kernel: Loaded 22474 symbols from
 > > /boot/System.map-2.5.7-pre2.
 > > Mar 17 11:15:02 turbulence kernel: Symbols match kernel version
2.5.7.
 > > Mar 17 11:15:02 turbulence kernel: Error seeking in /dev/kmem
 > > Mar 17 11:15:02 turbulence kernel: Symbol #af_packet, value
d98dd000
 > > Mar 17 11:15:02 turbulence kernel: Error adding kernel module table 
entry.
 >
 > Mar 17 17:05:33 s kernel: Error seeking in /dev/kmem
 > Mar 17 17:05:33 s kernel: Symbol #ipt_LOG, value d0894000
 > Mar 17 17:05:33 s kernel: Error adding kernel module table entry.
 >
 > I've been wondering about those...they're always the first syslog
 > messages when I boot wth 2.5.7-pre1.

-- 
WebSite: http://www.users.cts.com/sd/n/npasich
                       _      _     
 _ __  _ __   __ _ ___(_) ___| |__  
| '_ \| '_ \ / _` / __| |/ __| '_ \  
| | | | |_) | (_| \__ \ | (__| | | |
|_| |_| .__/ \__,_|___/_|\___|_| |_|@sd.cts.com
      |_|

