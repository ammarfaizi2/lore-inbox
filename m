Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270616AbRHNNGJ>; Tue, 14 Aug 2001 09:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270617AbRHNNF7>; Tue, 14 Aug 2001 09:05:59 -0400
Received: from mail2.megatrends.com ([155.229.80.11]:6667 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S270616AbRHNNFu>; Tue, 14 Aug 2001 09:05:50 -0400
Message-ID: <1355693A51C0D211B55A00105ACCFE6402D25F2B@ATL_MS1>
From: "Atul Mukker." <Atulm@ami.com>
To: "'MEHTA,HIREN (A-SanJose,ex1)'" <hiren_mehta@agilent.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: how to install redhat linux to a scsi disk for which driver i
	s no t present on the installation media
Date: Tue, 14 Aug 2001 09:00:24 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RedHat ( and most other distributions ) support install time driver update
diskette. More info for RedHat is available at
http://people.redhat.com/dledford



> -----Original Message-----
> From:	MEHTA,HIREN (A-SanJose,ex1) [SMTP:hiren_mehta@agilent.com]
> Sent:	Monday, August 13, 2001 7:08 PM
> To:	'linux-kernel@vger.kernel.org'
> Subject:	how to install redhat linux to a scsi disk for which driver
> is no t present on the installation media
> 
> Hi List,
> 
> Can somebody guide me on how to install RedHat Linux (e.g. 7.1)
> to a scsi disk which is connected to a scsi controller for which the 
> driver is not present on the installation media ? 
> 
> I want the installation prodecure to ask for driver diskette
> and when I insert the driver diskette, it will load the driver
> for the controller from the floppy-disk and find out what all 
> devices are connected to it and then probably start installation 
> on one of them.
> 
> Regards,
> -hiren
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
