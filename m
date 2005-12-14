Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbVLNDDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbVLNDDj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 22:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbVLNDDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 22:03:39 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:55188 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S1030272AbVLNDDi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 22:03:38 -0500
Subject: Re: 2.6.14-rt22
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: john stultz <johnstul@us.ibm.com>
Cc: nando@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1134504919.3323.2.camel@leatherman>
References: <1134172105.12624.27.camel@cmn3.stanford.edu>
	 <1134181771.4002.4.camel@leatherman>  <1134504919.3323.2.camel@leatherman>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 19:02:55 -0800
Message-Id: <1134529375.2489.74.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-13 at 12:15 -0800, john stultz wrote:
> On Fri, 2005-12-09 at 18:29 -0800, john stultz wrote:
> > If you add a "return 0;" to the top of
> > verify_pmtmr_rate() in drivers/clocksource/acpi_pm.c does the acpi_pm
> > timer keep proper time?
> 
> Hey Fernando,
> 	You replied to my other question, but I haven't heard anything back
> about the one above. If you have time to test this, I'd really
> appreciate it.

Sorry, I have not had time to test this yet...

I just downgraded one of the computers to BIOS F7 (from F9) and still
had the acpi_pm timer error on boot with 2.6.14-rt22. I'll have to
recheck things. 

-- Fernando


