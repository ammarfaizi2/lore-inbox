Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbTEVPHU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 11:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbTEVPHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 11:07:19 -0400
Received: from mail.uptime.at ([62.116.87.11]:3298 "EHLO mail.uptime.at")
	by vger.kernel.org with ESMTP id S261923AbTEVPHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 11:07:17 -0400
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: "'Sven Krohlas'" <darkshadow@web.de>, <marcelo@conectiva.com.br>,
       <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
Date: Thu, 22 May 2003 17:19:08 +0200
Organization: UPtime system solutions
Message-ID: <004a01c32075$7e2a7500$020b10ac@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <3EBE9FB1.7040102@web.de>
X-MailScanner-Information: Please contact UPtime Systemloesungen for more information
X-MailScanner: clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-6.6, required 4.8,
	BAYES_01, EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT,
	REPLY_WITH_QUOTES)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Krohlas <darkshadow@web.de> wrote:
> > Here goes release canditate 2. The aic7xxx problems should be fixed.
> 
> I've still got the same stability problems as with rc1.
> I booted rc2 and it was working fine for two or three hours. 
> Then I thought "Hey, while I go to work I could rip and 
> encode a CD". Well, so did I, and just as it started to rip 
> the 2nd track (and to encode the first one with oggenc) the 
> system froze. Sound stopped playing, the mouse froze, nothing 
> worked.

You didn't see a kernel panic as well? I'm asking, because I have the same
problems with one of my machines...

When was this problem introduced? Does 2.4.19, or 2.4.20 work well?

> As before I found nothing in the logs.

Me too. The system freezes completly. I believed it's a problem with the
temperature at our server housing location, but it seems it is not (mounted
additional fans during the night and now the system is dead again).

[ ... ] 

> My system is a AMD K6-2+, Asus P5A, SB AWE 64 ISA PnP (I used 
> Alsa 0.9.2, but in rc1 I also had problems without it), 
> nVidia TNT, two cheap network cards and a few disks.

My one is a Dual-P III 1GHz... I have no USB, Sound or that stuff enabled...
It's also a SCSI-only system if this does matter...

Best regards,
 Oliver

