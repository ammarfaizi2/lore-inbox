Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbVKAWs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbVKAWs0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 17:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbVKAWs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 17:48:26 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:13763 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751378AbVKAWsZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 17:48:25 -0500
Subject: Re: [RFC][PATCH 1/12] Reduced NTP rework (part 1)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1130883849.27168.458.camel@cog.beaverton.ibm.com>
References: <1130883795.27168.457.camel@cog.beaverton.ibm.com>
	 <1130883849.27168.458.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 14:48:21 -0800
Message-Id: <1130885302.27168.487.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 14:24 -0800, john stultz wrote:

> This patch applies ontop of my ntp-shift-right patch I posted awhile
> back.

I forgot to remove this from the description file. The ntp-shift-right
patch is already in 2.6.14-rc5-mm1, which this patch applies against.

Sorry for the confusion.
-john


