Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbTEWIgv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 04:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263952AbTEWIgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 04:36:51 -0400
Received: from mail.uptime.at ([62.116.87.11]:62956 "EHLO mail.uptime.at")
	by vger.kernel.org with ESMTP id S263953AbTEWIgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 04:36:47 -0400
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: "'Sven Krohlas'" <darkshadow@web.de>
Cc: <marcelo@conectiva.com.br>, <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
Date: Fri, 23 May 2003 10:48:44 +0200
Organization: UPtime system solutions
Message-ID: <002c01c32108$1e4bb980$020b10ac@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <3ECDCA64.3090604@web.de>
X-MailScanner-Information: Please contact UPtime Systemloesungen for more information
X-MailScanner: clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-6.1, required 4.8,
	BAYES_01, IN_REP_TO, QUOTED_EMAIL_TEXT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ ... ]
> > You didn't see a kernel panic as well? I'm asking, because 
> I have the 
> > same problems with one of my machines...
> 
> No panic, nothing in the logs.

Same for me...
 
> > When was this problem introduced? Does 2.4.19, or 2.4.20 work well?
> 
> 2.4.19 & .20 worked "fine", well, at least without DMA mode. 
> But they are stable.

I installed 2.4.19 (because I know it's stable - at least for me) yesterday on
my machine and no it runs stable again (it seems, because it's now up for more
than 15 hours). With 2.4.21-rc[1,2], I never had such a long uptime. :-)

[ ... ]

OK. So now I have to say: _Don't_ use 2.4.20-rc* if you have a aic7xxx. You can
use 2.4.19 and maybe 2.4.20(?).

Best regards,
 Oliver

