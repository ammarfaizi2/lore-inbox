Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275990AbRKCXA2>; Sat, 3 Nov 2001 18:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275752AbRKCXAS>; Sat, 3 Nov 2001 18:00:18 -0500
Received: from [202.44.245.6] ([202.44.245.6]:20150 "EHLO prdr30.prd.go.th")
	by vger.kernel.org with ESMTP id <S275743AbRKCW77>;
	Sat, 3 Nov 2001 17:59:59 -0500
Date: Sat, 3 Nov 2001 23:59:20 +0100
From: victor <ixnay@infonegocio.com>
X-Mailer: The Bat! (v1.53d)
Reply-To: victor <ixnay@infonegocio.com>
X-Priority: 3 (Normal)
Message-ID: <144182173191.20011103235920@infonegocio.com>
To: linux-kernel@vger.kernel.org
Subject: problem whit kernel 2.4.X
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

i cant boot ok with a kernel 2.4.X (any version)

i compile and boot the 2.2.19  whitout problem (the 2.2.20 problem is in other mail) but when i boot whit 2.4 series the
scsi subsystem  fails

i have a alcor alphastation 5/266 and this are the loop messages

the scsi controller is a Qlogic isp 1020 and the driver i am using is
Qlogic PCI

scsi: aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 0
scsi: aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 0 
scsi: aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 0 
scsi: aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 0 

what i am doing wrog :?

thaks in advantage

-- 
Best regards,
 victor                          mailto:ixnay@infonegocio.com

