Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133105AbREBNCj>; Wed, 2 May 2001 09:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135248AbREBNCU>; Wed, 2 May 2001 09:02:20 -0400
Received: from qn-212-127-137-79.quicknet.nl ([212.127.137.79]:40196 "EHLO
	mail.fluido.as") by vger.kernel.org with ESMTP id <S133105AbREBNCO>;
	Wed, 2 May 2001 09:02:14 -0400
Date: Wed, 2 May 2001 15:02:02 +0200
From: "Carlo E. Prelz" <fluido@fluido.as>
To: Matt_Domsch@Dell.com
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: 2.4.4, 2.4.4-ac1 and -ac3: oops loading future domain scsi mo dule
Message-ID: <20010502150202.B1283@qn-212-127-137-79.fluido.as>
In-Reply-To: <CDF99E351003D311A8B0009027457F140810E2ED@ausxmrr501.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <CDF99E351003D311A8B0009027457F140810E2ED@ausxmrr501.us.dell.com>; from Matt_Domsch@Dell.com on Wed, May 02, 2001 at 07:40:50AM -0500
X-operating-system: Linux qn-212-127-137-79 2.4.4-ac3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Subject: RE: 2.4.4, 2.4.4-ac1 and -ac3: oops loading future domain scsi mo dule
	Date: Wed, May 02, 2001 at 07:40:50AM -0500

Quoting Matt_Domsch@Dell.com (Matt_Domsch@Dell.com):

> > That one's mine.  It should be:
> >    scsi_set_pci_device(shpnt, pdev);
> 
> Can you please try this patch and see if it works for you?

Yesss...

scsi1: <fdomain> BIOS version 3.2 at 0xca000 using scsi id 7
scsi1: <fdomain> TMC-18C50 chip at 0x140 irq 5
scsi1 : Future Domain 16-bit SCSI Driver Version 5.50

Thanks
Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)
