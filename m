Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272636AbRIKXPk>; Tue, 11 Sep 2001 19:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272638AbRIKXP3>; Tue, 11 Sep 2001 19:15:29 -0400
Received: from tungsten.btinternet.com ([194.73.73.81]:28361 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S272636AbRIKXPO>; Tue, 11 Sep 2001 19:15:14 -0400
From: "George Lloyd" <g.Lloyd@btinternet.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 12 Sep 2001 00:16:07 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Problem
X-mailer: Pegasus Mail for Win32 (v3.12b)
Message-Id: <E15gwkU-0004lX-00@tungsten.btinternet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was not sure where to send this report so I hope it's correct.

Since Version 2.4.3 of the kernel I have been unable to use my scsi cdrom 
drive.  The adapter card is a Adaptec AHA-1542 and the CDROM drive a 
Phillips CDD3600. When I try to mount the drive I get the following.

Vendor: Phillps Model:CD3600 CD-R/RW Rev 2.00
Type - CD-ROM ANSI SCSI Revision: 02
Detected scsi3-mmc drive: 2x6 writer cd/-w form2 cdda trgg
sr: ran out of mem for sectter pad
kernel panic : scsi_free : bad offset

Version 2.4.3 is the last version the above works on. Can you help?

George Lloyd
g.lloyd@btinternet.com
Home Page for NNA Software
http://www.nna.btinternet.co.uk

