Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVCOS25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVCOS25 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 13:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVCOS0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 13:26:15 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:13966 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261741AbVCOSZN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 13:25:13 -0500
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A3)
From: john stultz <johnstul@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
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
In-Reply-To: <Pine.LNX.4.58.0503142116320.16655@schroedinger.engr.sgi.com>
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0503142116320.16655@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 10:25:06 -0800
Message-Id: <1110911106.30498.457.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-14 at 21:37 -0800, Christoph Lameter wrote:
> Note that similarities exist between the posix clock and the time sources.
> Will all time sources be exportable as posix clocks?

At this point I'm not familiar enough with the posix clocks interface to
say, although its probably outside the scope of the initial timeofday
rework.

Do you have a link that might explain the posix clocks spec and its
intent?

thanks
-john

