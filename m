Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132041AbRAPQgV>; Tue, 16 Jan 2001 11:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131984AbRAPQgG>; Tue, 16 Jan 2001 11:36:06 -0500
Received: from mail2.megatrends.com ([155.229.80.11]:26382 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S131974AbRAPQfu>; Tue, 16 Jan 2001 11:35:50 -0500
Message-ID: <1355693A51C0D211B55A00105ACCFE64E9518F@ATL_MS1>
From: Venkatesh Ramamurthy <Venkateshr@ami.com>
To: "'arjan@fenrus.demon.nl'" <arjan@fenrus.demon.nl>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>
Cc: linux-kernel@vger.kernel.org,
        "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: RE: Linux not adhering to BIOS Drive boot order?
Date: Tue, 16 Jan 2001 11:31:25 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In article <1355693A51C0D211B55A00105ACCFE64E9518C@ATL_MS1> you wrote:
> 
> > we need some kind of signature being written in the drive, which the
> kernel
> > will use for determining the boot drive and later re-order drives, if
> > required.
> 
> Like the ext2 labels? (man e2label)
	[Venkatesh Ramamurthy]  This re-ordering of the scsi drives should
be done by SCSI ML , so is incorporating ext2 fs data structure knowledge on
the SCSI ML a good idea?. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
