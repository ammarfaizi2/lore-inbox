Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132534AbRDATgM>; Sun, 1 Apr 2001 15:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132540AbRDATgC>; Sun, 1 Apr 2001 15:36:02 -0400
Received: from colorfullife.com ([216.156.138.34]:6406 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132534AbRDATfs>;
	Sun, 1 Apr 2001 15:35:48 -0400
Message-ID: <001c01c0bae2$e523fc90$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <lm@bitmover.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: bug database braindump from the kernel summit
Date: Sun, 1 Apr 2001 21:32:40 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There was a lot of discussion about possible tools
> that would dig out the /proc/pci info

I think the tools should not dig too much information out of the system.
I remember some Microsoft (win98 beta?) bugtracking software that
insisted on sending a several hundert kB long compressed blob with every
bug report.
IMHO it must be possible to file bugreports without the complete hw info
if I know that the bug isn't hw related.

--
    Manfred




