Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135240AbRD3SPS>; Mon, 30 Apr 2001 14:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135222AbRD3SPI>; Mon, 30 Apr 2001 14:15:08 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18441 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133024AbRD3SPC>; Mon, 30 Apr 2001 14:15:02 -0400
Subject: Re: 2.4 and 2GB swap partition limit
To: R.E.Wolff@BitWizard.nl (Rogier Wolff)
Date: Mon, 30 Apr 2001 19:14:39 +0100 (BST)
Cc: wakko@animx.eu.org (Wakko Warner), R.E.Wolff@BitWizard.nl (Rogier Wolff),
        xavier.bestel@free.fr (Xavier Bestel),
        goswin.brederlow@student.uni-tuebingen.de (Goswin Brederlow),
        fluffy@snurgle.org (William T Wilson), Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <200104281317.PAA04172@cave.bitwizard.nl> from "Rogier Wolff" at Apr 28, 2001 03:17:01 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uIC3-0008L1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The swap I have is 2 partitions, one on each drive both with a priority of
> > 0.  Personally, I like the way it's done on my box.
> 
> So you've spent almost $200 for RAM, and refuse to spend $4 for 1Gb of
> swap space. Fine with me. 

Stupid argument. Very stupid argument. Take a 16Gb server. You now want
to buy 64Gb of hard disk for the swap. Only because of partition limits you'll
beed at least 2 disks entirely dedicated to it, which also means a controller
a larger PSU and a bigger case.

The swap behaviour of 2.4 is a bug. 

