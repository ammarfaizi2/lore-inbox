Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbTE0I01 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 04:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbTE0I01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 04:26:27 -0400
Received: from mail.uptime.at ([62.116.87.11]:49851 "EHLO mail.uptime.at")
	by vger.kernel.org with ESMTP id S262341AbTE0I00 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 04:26:26 -0400
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: "'Willy Tarreau'" <willy@w.ods.org>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
Date: Tue, 27 May 2003 10:38:09 +0200
Organization: UPtime system solutions
Message-ID: <000d01c3242b$4dd31a60$020b10ac@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <20030527043936.GB19309@alpha.home.local>
X-MailScanner-Information: Please contact UPtime Systemloesungen for more information
X-MailScanner: clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-6.6, required 4.1,
	BAYES_01, EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT,
	REPLY_WITH_QUOTES)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <willy@w.ods.org> wrote:
> On Tue, May 27, 2003 at 01:35:09AM +0100, Alan Cox wrote:
>  
> > One thing I will say however - I'd have done the *same* thing as 
> > Marcelo with aic7xxx during -rc which is to defer it.
> 
> I think you would at least have forwarded problem reports to 
> Justin, expecting him to look into the problem first.

As the one who started this discussion... I'd simply like to quote this and say:

_FULL_ ack!

[ ... ]

I also changed the whole server (the one which had the aix7xxx problems) in the
meantime... Changed the Adaptec 2940, now there is a Adaptec 29160. I switched
from a Dual-P3 to a P4. And well, the interessting part, I switched from
2.4.20(-XX) to 2.4.19. EVERYTHING runs faster and stable now!

Best regards,
 Oliver

