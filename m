Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbRAPQsU>; Tue, 16 Jan 2001 11:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbRAPQsB>; Tue, 16 Jan 2001 11:48:01 -0500
Received: from mail2.megatrends.com ([155.229.80.11]:6672 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S129401AbRAPQrw>; Tue, 16 Jan 2001 11:47:52 -0500
Message-ID: <1355693A51C0D211B55A00105ACCFE64E95191@ATL_MS1>
From: Venkatesh Ramamurthy <Venkateshr@ami.com>
To: "'Dominik Kubla'" <dominik.kubla@uni-mainz.de>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>
Cc: "'David Woodhouse'" <dwmw2@infradead.org>,
        "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: RE: Linux not adhering to BIOS Drive boot order?
Date: Tue, 16 Jan 2001 11:43:29 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is due to the fixed ordering of the scsi drivers. You can change the
> order of the scsi hosts with the "scsihosts" kernel parameter. See
> linux/drivers/scsi/scsi.c
	[Venkatesh Ramamurthy]  I think it would be a nice idea if we can
make this process automatic , with out user typing in the order and
remembering it. The fact that a kernel developer is not using the machines
daily to get his work done should be in our minds. If we do this Linux would
become more user friendly

> Yours,
>   Dominik
> -- 
> http://petition.eurolinux.org/index_html - No Software Patents In Europe!
> http://petition.lugs.ch/ (in Switzerland)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
