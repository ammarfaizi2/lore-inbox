Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318032AbSHKSkL>; Sun, 11 Aug 2002 14:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318042AbSHKSkL>; Sun, 11 Aug 2002 14:40:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4880 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318032AbSHKSkK>;
	Sun, 11 Aug 2002 14:40:10 -0400
Date: Sun, 11 Aug 2002 19:43:56 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org, debian-alpha@lists.debian.org
Subject: Re: 2.4.19 eat my disc (contents)
Message-ID: <20020811184356.GC755@gallifrey>
References: <20020811175252.GB755@gallifrey> <20020811182832.GA21639@wurtel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020811182832.GA21639@wurtel.net>
User-Agent: Mutt/1.4i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 19:42:46 up  8:29,  1 user,  load average: 2.23, 2.26, 2.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Paul Slootman (paul@debian.org) wrote:
> On Sun 11 Aug 2002, Dr. David Alan Gilbert wrote:
> 
> >   I've just lost the contents of my disc on my Alpha to 2.4.19 - be
> 
> That's not absolutely sure...
> 
> > All tools were from Debian/unstable; updated immediatly prior to the 
> > kernel build.
> 
> It could of course be that during the update something trashed some
> part of the disk, which only made itself apparent after the reboot.
> 
> Golden rule: only change one thing at a time...

Sure; it was just a standard apt-get dist-upgrade (since I'd not run the
upgrade for a few weeks); not a major potato->woody transition or
anything.

> My alpha's been running 2.4.19-rc2 for more than 3 weeks now without any
> problems (the kernel also has my patches against unaligned accesses in
> the kernel, for the packet filter and for netfilter).  I don't think
> anything big would have been changed between rc2 and the final release,
> so unless it's specific to the IDE driver (I use SCSI) I doubt the
> kernel is the culprit.

I suspect the IDE driver; but that is difficult to tell.

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
