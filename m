Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292386AbSBUNri>; Thu, 21 Feb 2002 08:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292383AbSBUNr2>; Thu, 21 Feb 2002 08:47:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45060 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292386AbSBUNrP>; Thu, 21 Feb 2002 08:47:15 -0500
Subject: Re: AIC7XXX 6.2.5 driver
To: axboe@suse.de (Jens Axboe)
Date: Thu, 21 Feb 2002 14:01:33 +0000 (GMT)
Cc: scarfoglio@arpacoop.it (Carlo Scarfoglio), linux-kernel@vger.kernel.org,
        gibbs@scsiguy.com (Justin T. Gibbs)
In-Reply-To: <20020221075253.GH2654@suse.de> from "Jens Axboe" at Feb 21, 2002 08:52:53 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dtmv-0006z2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You should ask Justin whether he has submitted it for inclusion or not.
> I offered to port to 2.5 at least, but heard nothing.

I was sent a patch for it which included some scsi changes, broke support
for the CMD ide controllers and didn't apply in the aic7xxx area. So I
threw it in /dev/null
