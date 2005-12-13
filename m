Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbVLMUPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbVLMUPb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 15:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbVLMUPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 15:15:31 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:60392 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751368AbVLMUPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 15:15:31 -0500
Subject: Re: 2.6.14-rt22
From: john stultz <johnstul@us.ibm.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1134181771.4002.4.camel@leatherman>
References: <1134172105.12624.27.camel@cmn3.stanford.edu>
	 <1134181771.4002.4.camel@leatherman>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 12:15:19 -0800
Message-Id: <1134504919.3323.2.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 18:29 -0800, john stultz wrote:
> If you add a "return 0;" to the top of
> verify_pmtmr_rate() in drivers/clocksource/acpi_pm.c does the acpi_pm
> timer keep proper time?

Hey Fernando,
	You replied to my other question, but I haven't heard anything back
about the one above. If you have time to test this, I'd really
appreciate it.

thanks again!
-john

