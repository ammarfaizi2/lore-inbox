Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264728AbTFWHpU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 03:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264868AbTFWHpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 03:45:20 -0400
Received: from mail.uptime.at ([62.116.87.11]:25271 "EHLO mail.uptime.at")
	by vger.kernel.org with ESMTP id S264728AbTFWHpJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 03:45:09 -0400
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: "'Marcelo Tosatti'" <marcelo@conectiva.com.br>
Cc: "'Willy Tarreau'" <willy@w.ods.org>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
Date: Mon, 23 Jun 2003 09:57:39 +0200
Organization: UPtime system solutions
Message-ID: <000201c3395d$1e8c0360$020b10ac@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <Pine.LNX.4.55L.0305271701430.9487@freak.distro.conectiva>
Importance: Normal
X-MailScanner-Information: Please contact UPtime Systemloesungen for more information
X-MailScanner: clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-5.4,
	required 4.1, BAYES_10 -4.70, IN_REP_TO -0.30,
	QUOTED_EMAIL_TEXT -0.38)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcello!

Marcello Tosatti wrote:
[ ... ]
> > I also changed the whole server (the one which had the aix7xxx 
> > problems) in the meantime... Changed the Adaptec 2940, now 
> > there is a 
> > Adaptec 29160. I switched from a Dual-P3 to a P4. And well, the 
> > interessting part, I switched from
> > 2.4.20(-XX) to 2.4.19. EVERYTHING runs faster and stable now!
> 
> Does 2.4.21-rc5 work for you?

Blame me for this! I was very busy the last few weeks, that's why I answer this
mail soooooo late. Because I have the machine now at home and no longer in a
production environment, I'm able to test everything...

(FYI. The P4 machine still runs stable. :-) ).

I'll try the latest kernel 2.4.22-pre1 on the dual-machine and tell you if it
runs stable or not. I believe there are not too much people who have a Dual-PIII
with an Adaptec controller...(!?)

However...

Keep on going!

Best regards,
 Oliver

