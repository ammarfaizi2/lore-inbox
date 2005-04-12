Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbVDLIoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbVDLIoJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 04:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbVDLIoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 04:44:08 -0400
Received: from zoe.ndcservers.net ([216.23.188.144]:23272 "EHLO
	zoe.ndcservers.net") by vger.kernel.org with ESMTP id S262067AbVDLInG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 04:43:06 -0400
Message-ID: <023b01c53f3b$a8083e20$0201a8c0@ndciwkst01>
From: "mailinglist@unix-scripts.com" <mailinglists@unix-scripts.com>
To: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
References: <d2vu0u$oog$1@sea.gmane.org> <Pine.LNX.4.61.0504060209200.15520@montezuma.fsmlabs.com> <03f201c53aeb$a42d1270$0201a8c0@ndciwkst01> <Pine.LNX.4.61.0504070207430.12823@montezuma.fsmlabs.com>
Subject: Re: kernel panic - not syncing: Fatal exception in interupt
Date: Tue, 12 Apr 2005 01:43:09 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2741.2600
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2742.200
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - zoe.ndcservers.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - unix-scripts.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The machine crashed again twice today.  I have vga=791 so i caugh a bit more
of the crash.  i enabled serial redirection in the bios so i'm hoping to
catch the full dump next time.


The first screen shot is with the old resolution so didnt catch much more
here...
http://www.unix-scripts.com/shaun/host1-2005-04-12-01.png

But this screen shot got a nice chunk and looks a bit diffrent.
http://www.unix-scripts.com/shaun/host1-2005-04-12-02.png


Still looks like there is alot more that i'm missing but by glancing at that
dump, to me it definitly seams like bridging is causing this.  I'm going to
post this to the ebtables lists tomarrow also.

Best Regards,

Shaun R.


----- Original Message -----
From: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>
To: "mailinglist@unix-scripts.com" <mailinglists@unix-scripts.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, April 07, 2005 1:09 AM
Subject: Re: kernel panic - not syncing: Fatal exception in interupt


> On Wed, 6 Apr 2005, mailinglist@unix-scripts.com wrote:
>
> > No, sorry, i have to run with bridging support other wise the
guests(UML's)
> > wont be able to communicate with the outside world.
>
> Ok in that case, can you connect a serial console so that you can capture
> the entire output?
>
> Thanks,
> Zwane
>
>

