Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132152AbRDMWf4>; Fri, 13 Apr 2001 18:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132144AbRDMWfq>; Fri, 13 Apr 2001 18:35:46 -0400
Received: from ausxc08.us.dell.com ([143.166.99.216]:23665 "EHLO
	ausxc08.us.dell.com") by vger.kernel.org with ESMTP
	id <S132125AbRDMWfd>; Fri, 13 Apr 2001 18:35:33 -0400
Message-ID: <CDF99E351003D311A8B0009027457F140810E1E5@ausxmrr501.us.dell.com>
From: Matt_Domsch@Dell.com
To: alan@lxorguk.ukuu.org.uk, dougg@torque.net
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: RE: [RFC][PATCH] adding PCI bus information to SCSI layer
Date: Fri, 13 Apr 2001 17:31:52 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> An ioctl might be better. We already have an ioctl for 
> querying the lun
> information for a disk. We could also return the bus 
> information for its
> controller(s) [remember multipathing]

I provide such, and a test program at http://domsch.com/linux/scsi for
trying it out.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Systems Group
Linux OS Development
www.dell.com/linux


