Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269906AbRHMXIP>; Mon, 13 Aug 2001 19:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269907AbRHMXH4>; Mon, 13 Aug 2001 19:07:56 -0400
Received: from msgbas2x.cos.agilent.com ([192.25.240.37]:51663 "HELO
	msgbas2.cos.agilent.com") by vger.kernel.org with SMTP
	id <S269906AbRHMXHu>; Mon, 13 Aug 2001 19:07:50 -0400
Message-ID: <FEEBE78C8360D411ACFD00D0B7477971880B27@xsj02.sjs.agilent.com>
From: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: how to install redhat linux to a scsi disk for which driver is no
	t present on the installation media
Date: Mon, 13 Aug 2001 17:07:56 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List,

Can somebody guide me on how to install RedHat Linux (e.g. 7.1)
to a scsi disk which is connected to a scsi controller for which the 
driver is not present on the installation media ? 

I want the installation prodecure to ask for driver diskette
and when I insert the driver diskette, it will load the driver
for the controller from the floppy-disk and find out what all 
devices are connected to it and then probably start installation 
on one of them.

Regards,
-hiren
