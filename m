Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292122AbSCNBMV>; Wed, 13 Mar 2002 20:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311464AbSCNBML>; Wed, 13 Mar 2002 20:12:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:65289 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292122AbSCNBMA>; Wed, 13 Mar 2002 20:12:00 -0500
Subject: Re: linux-2.5.6 scsi DMA mapping and compilation fixes (not yet working)
To: adam@yggdrasil.com (Adam J. Richter)
Date: Thu, 14 Mar 2002 01:27:13 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <200203140102.RAA05788@adam.yggdrasil.com> from "Adam J. Richter" at Mar 13, 2002 05:02:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lK1R-00080i-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I think I may have gotten confused here.  Are you only
> talking about the NCR53*80* drivers (pas16, seagate, t128,
> dmx3191, dtc), or the '80 and the '9x drivers (NCR53C9x.c,

5380 - I've not touch the 9x stuff - so NCR5380, g_NCR5380, t128 etc.

> 	NCR5380.c in 2.4.18 and 2.5.7-pre1 are identical files,

Cool

