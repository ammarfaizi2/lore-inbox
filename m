Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbULHCKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbULHCKn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 21:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbULHCHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 21:07:34 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:13772 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262007AbULHCDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 21:03:00 -0500
Subject: Re: [RFC] new timeofday timesources (v.A1)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: tim@physik3.uni-rostock.de, george anzinger <george@mvista.com>,
       albert@users.sourceforge.net, Ulrich.Windl@rz.uni-regensburg.de,
       clameter@sgi.com, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max <amax@us.ibm.com>, mahuja@us.ibm.com
In-Reply-To: <1102471123.1281.34.camel@cog.beaverton.ibm.com>
References: <1102470914.1281.27.camel@cog.beaverton.ibm.com>
	 <1102470997.1281.30.camel@cog.beaverton.ibm.com>
	 <1102471064.1281.32.camel@cog.beaverton.ibm.com>
	 <1102471123.1281.34.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1102471376.1281.37.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 07 Dec 2004 18:02:56 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-07 at 17:58, john stultz wrote:
> All,
> 	This patch implements most of the time sources for i386 and x86-64
> (tsc, pit, cyclone, acpi-pm and hpet). It applies on top of my
> linux-2.6.10-rc3_timeofday-arch_A1 patch. It provides real timesources
> (opposed to the example jiffies timesource) that can be used for more
> realistic testing.

Ack. That last one got sent using the wrong from address. 

Please reply via johnstul@us.ibm.com.

sorry,
-john


