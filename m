Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263576AbUEGNl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263576AbUEGNl7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 09:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbUEGNl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 09:41:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63145 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263576AbUEGNl5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 09:41:57 -0400
Date: Fri, 7 May 2004 10:42:53 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Mario Vanoni <vanonim@bluewin.ch>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.26: first crash 100%, NFS?
Message-ID: <20040507134253.GB10613@logos.cnet>
References: <409A8C3F.5080005@bluewin.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409A8C3F.5080005@bluewin.ch>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 09:04:31PM +0200, Mario Vanoni wrote:
> 8 machines running 2.4.26, >=19 days uptime.
> 
> P4HT3400, ASUS P4R800-V deluxe,
> 1GB memory, 1GB swap, 80GB IDE disk,
> on-board 100Mb/s LAN.
> 
> - downloaded the last KNOPPIX...en
> - 2 setitathome -nice 19 running
> 
> - mounted from another machine (UP P3-550)
> - from P3-550 machine cp -a KNOPPIX...en
> - after about 367MB of ~700MB ...
>   P4HT3400 machine dead, message on console:
> 
>   Kernel panic: Aiee, killing interrupt handler!
>   In interrupt handler -not syncing.

Hi Mario,

Unfortunately this is quite vague (for me at least). If you had copied 
the whole Kernel panic message before that we could figure out the
problem.

>   Power switch ultima ratio, following fsck.
> 
> - the console on P3-550 was logged _out_.
> 
> No time for deeper researches, sorry,
> kernel compiled -static with gcc-3.3.2,
> no modules, without all lkml helps wanted.
