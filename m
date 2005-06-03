Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVFCNPC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVFCNPC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 09:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVFCNOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 09:14:52 -0400
Received: from zorg.st.net.au ([203.16.233.9]:22210 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S261254AbVFCNOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 09:14:38 -0400
Message-ID: <42A057CD.7050103@torque.net>
Date: Fri, 03 Jun 2005 23:14:53 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] sdparm 0.93
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sdparm is a command line utility designed to get and set
SCSI device parameters (cf hdparm for ATA disks). Apart
from SCSI devices (e.g. disks, tapes and enclosures) sdparm
can be used on any device that uses a SCSI command set
(e.g. CD/DVD drives). sdparm also can list VPD pages including
the device identification page.

The major addition in version 0.93 is transport protocol
specific modes pages for FCP, SPI and SAS.

For more information and downloads see:
http://www.torque.net/sg/sdparm.html

ChangeLog:
http://www.torque.net/sg/p/sdparm.ChangeLog

Doug Gilbert


