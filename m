Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVCQISQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVCQISQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 03:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVCQISQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 03:18:16 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:60573 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S261644AbVCQISM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 03:18:12 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: john stultz <johnstul@us.ibm.com>
Date: Thu, 17 Mar 2005 09:15:10 +0100
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A3)
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com
Message-ID: <42394A9F.30698.4E10AC@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <1110911106.30498.457.camel@cog.beaverton.ibm.com>
References: <Pine.LNX.4.58.0503142116320.16655@schroedinger.engr.sgi.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=3.88.0+V=3.88+U=2.07.079+R=06 December 2004+T=99328@20050317.081201Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Mar 2005 at 10:25, john stultz wrote:

> On Mon, 2005-03-14 at 21:37 -0800, Christoph Lameter wrote:
> > Note that similarities exist between the posix clock and the time sources.
> > Will all time sources be exportable as posix clocks?
> 
> At this point I'm not familiar enough with the posix clocks interface to
> say, although its probably outside the scope of the initial timeofday
> rework.

I'd be happy to see the required POSIX clocks at nanosecond resolution for the 
initial version. Add-Ons may follow later.

> 
> Do you have a link that might explain the posix clocks spec and its
> intent?

There's a book named like "POSIX.4: Programming for the real world" by Bill 
Gallmeister (I think).

Regards,
Ulrich

