Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286187AbSAEDtD>; Fri, 4 Jan 2002 22:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287493AbSAEDsy>; Fri, 4 Jan 2002 22:48:54 -0500
Received: from mx7.sac.fedex.com ([199.81.194.38]:50953 "EHLO
	mx7.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S286187AbSAEDsl>; Fri, 4 Jan 2002 22:48:41 -0500
Date: Sat, 5 Jan 2002 11:48:33 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Jeff Chua <jchua@fedex.com>
Message-ID: <Pine.LNX.4.43.0201051146430.13715-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/05/2002
 11:48:36 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/05/2002
 11:48:38 AM,
	Serialize complete at 01/05/2002 11:48:39 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/05/2002
 11:48:39 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I posted this before, but still no response from anyone (lkml or scsi)

I can't get the aic7xxx to work on the HP LH4r ...

Linux version 2.4.18pre1

Message is ...

        aic7xxx: PCI Device 1:2:0 failed memory mapped test
        ahc_pci:1:2:0: No SCB space found
        Trying to free free IRQ18

However it worked fine on the HP LH6000r ...

        scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
                <Adaptec 2940 Ultra SCSI adapter>
                aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

Any help is very much appreciated.



Thanks,
Jeff
[ jchua@fedex.com ]

