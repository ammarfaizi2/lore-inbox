Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272256AbRHWM7s>; Thu, 23 Aug 2001 08:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272257AbRHWM7i>; Thu, 23 Aug 2001 08:59:38 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46342 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272256AbRHWM7b>; Thu, 23 Aug 2001 08:59:31 -0400
Subject: Re: Shutdown and power off on a multi-processor machine
To: ptb@it.uc3m.es
Date: Thu, 23 Aug 2001 14:01:52 +0100 (BST)
Cc: pozsy@sch.bme.hu (Pozsar Balazs),
        linux-kernel@vger.kernel.org (linux kernel)
In-Reply-To: <200108230945.LAA01478@xilofon.it.uc3m.es> from "Peter T. Breuer" at Aug 23, 2001 11:45:13 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Zu7M-0003nS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The machine that most annoys me in this regard is the dell poweredge at which I am
> sitting ... it's been a long time since I booted 2.2 on it, but I think things
> went better.
> 
> The bios has no options vis-a-vis apm, etc.
> 
> I have been running all kernels 2.4.0 to 2.4.8. I think 2.4.8 may be a bit better,
> but it needs time to get a feel for the stats.

The -ac kernel tree knows a lot about Dell poweredge and reboot
requirements, courtesy of the nice folks at Dell.

Alan
