Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbTE0Jc1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 05:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbTE0Jc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 05:32:27 -0400
Received: from mail.uptime.at ([62.116.87.11]:41404 "EHLO mail.uptime.at")
	by vger.kernel.org with ESMTP id S262963AbTE0Jc0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 05:32:26 -0400
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: "'Marc-Christian Petersen'" <m.c.p@wolk-project.de>,
       "'Willy Tarreau'" <willy@w.ods.org>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
Date: Tue, 27 May 2003 11:44:12 +0200
Organization: UPtime system solutions
Message-ID: <003801c32434$8795d9f0$020b10ac@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <200305271044.53866.m.c.p@wolk-project.de>
X-MailScanner-Information: Please contact UPtime Systemloesungen for more information
X-MailScanner: clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-5.9, required 4.1,
	BAYES_10, EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT,
	REPLY_WITH_QUOTES)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen <m.c.p@wolk-project.de> wrote:
> On Tuesday 27 May 2003 10:38, Oliver Pitzeier wrote:
> > I also changed the whole server (the one which had the aix7xxx 
> > problems) in the meantime... Changed the Adaptec 2940, now 
> there is a 
> > Adaptec 29160. I switched from a Dual-P3 to a P4. And well, the 
> > interessting part, I switched from 2.4.20(-XX) to 2.4.19. 
> EVERYTHING 
> > runs faster and stable now!

> try 2.4.18 and you'll maybe s/faster/"fuck damn fast as speed 
> of light"/

Thanks Marc-Christian!

This is what I'll try on my development server. :-) And then I may switch at the
production system as well. :-)

Best regards,
 Oliver

