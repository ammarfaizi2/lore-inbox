Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263873AbTLED6R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 22:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263857AbTLED6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 22:58:16 -0500
Received: from bay7-dav17.bay7.hotmail.com ([64.4.10.121]:44047 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263873AbTLED6N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 22:58:13 -0500
X-Originating-IP: [24.61.138.213]
X-Originating-Email: [jason_kingsland@hotmail.com]
From: "Jason Kingsland" <Jason_Kingsland@hotmail.com>
To: "Larry McVoy" <lm@bitmover.com>, "Erik Andersen" <andersen@codepoet.org>,
       "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Paul Adams" <padamsdev@yahoo.com>, <linux-kernel@vger.kernel.org>
References: <20031205012124.GB15799@work.bitmover.com>
Subject: Re: Linux GPL and binary module exception clause?
Date: Thu, 4 Dec 2003 22:58:18 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <BAY7-DAV17IiC08B4wQ0000344d@hotmail.com>
X-OriginalArrivalTime: 05 Dec 2003 03:58:12.0041 (UTC) FILETIME=[00832390:01C3BAE4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Dec 04, 2003 at 06:03:49PM -0700, Erik Andersen wrote:
> linux/COPYING says: This copyright does *not* cover user programs
> that use kernel services by normal system calls - this is merely
> considered normal use of the kernel, and does *not* fall under
> the heading of "derived work".

Larry McVoy adds:
> Given the GPL rules you have to disregard Linus' rules that are extensions
> and work off of standard law.  When you get there it becomes an issue of
> boundaries and the law seems to clearly support Linus' point of view, he
> didn't need to make that clarification, whether he did or not, that's what
> is true in the eyes of the law.


Actually, about two years ago a large company I previously worked at
performed a formal legal review of the GPL, as part of a due-dilligence
review whether to use Linux rather than a commercial OS in some of its
products.

One of the points raised was that the license clarification for user
programs was added by Linus to copying.txt well before most other authors
started working on the kernel - it can be traced back to a nascent version
of Linux to which most everyone else then submitted their code into later
on.

It was the opinion of the IPR lawyer reviewing the license that the "user
program" clarification is therefore a part of the core Linux license, is
legally binding and applies to all such subsequent code submitted by other
authors.

It's a subtle point, but I thought it would be worth a mention. Ultimately,
it would be for the courts to decide I guess, if any GPL copyright dispute
ever makes it that far.

Just goes to show that some companies are concerned about working
effectively with the GPL - it took several weeks of highly paid IPR lawyers
to formate a policy document which they considered acceptable use.
