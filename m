Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVFLLEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVFLLEj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 07:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVFLLEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 07:04:39 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:14783 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S261786AbVFLLEi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 07:04:38 -0400
Date: Sun, 12 Jun 2005 12:05:39 +0100
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Willy Tarreau <willy@w.ods.org>, subbie subbie <subbie_subbie@yahoo.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: optional delay after partition detection at boot time
Message-ID: <20050612110539.GA9765@gallifrey>
References: <20050612065050.99998.qmail@web30704.mail.mud.yahoo.com> <20050612071213.GG28759@alpha.home.local> <Pine.LNX.4.62.0506121225170.11197@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506121225170.11197@numbat.sonytel.be>
User-Agent: Mutt/1.4.1i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.11-1.14_FC3smp (i686)
X-Uptime: 12:04:45 up 59 days, 10:33, 28 users,  load average: 0.00, 0.00, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Geert Uytterhoeven (geert@linux-m68k.org) wrote:

> Or make the kernel print /proc/partitions when it is unable to mount root?

I posted a patch in February to do this:

http://marc.theaimsgroup.com/?l=linux-kernel&m=110946077026065&w=2

Dave
--
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
