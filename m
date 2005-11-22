Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965111AbVKVTAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965111AbVKVTAx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbVKVTAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:00:53 -0500
Received: from nm02mta.dion.ne.jp ([61.117.3.79]:40718 "HELO
	nm02omta029.dion.ne.jp") by vger.kernel.org with SMTP
	id S965111AbVKVTAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:00:52 -0500
Date: Wed, 23 Nov 2005 04:01:30 +0900
From: Akira Tsukamoto <akira-t@s9.dion.ne.jp>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Subject: Re: athlon x2 + 2.6.14 + SMP = fast clock
Cc: cmulcahy@avesi.com, john stultz <johnstul@us.ibm.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200511211028.04431.arekm@pld-linux.org>
References: <1132537722.9627.145.camel@harry> <200511211028.04431.arekm@pld-linux.org>
Message-Id: <20051123040112.6853.AKIRA-T@s9.dion.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Nov 2005 10:28:03 +0100
Arkadiusz Miskiewicz <arekm@pld-linux.org> mentioned:
> 
> I wonder is this is x86_64 only problem?
> 
> I'm having the same problem on dual xeon 1.8GHz i686 with HT enabled, kernel 
> 2.6.14.2-4smp. Clock runs twice fast. Previously I was using 2.6.11 kernel 
> with no such problem.

My laptop, clock runs twice fast but has PentiumM, so it shouldn't be 
x86_64 specific.


> 
> cmdline is: acpi=ht nmi_watchdog=1
> 
> Unfortunately I can't do any testing right now on this machine but I'll try 
> acpi_skip_timer_override cmdline option as soon as I can.
> 
> > Chris

-- 
Akira Tsukamoto <akira-t@s9.dion.ne.jp> <>


