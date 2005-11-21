Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbVKUBlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVKUBlV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 20:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbVKUBlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 20:41:21 -0500
Received: from zorg.st.net.au ([203.16.233.9]:35751 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S932164AbVKUBlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 20:41:20 -0500
Message-ID: <43812606.6030803@torque.net>
Date: Mon, 21 Nov 2005 11:42:30 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org, tomfa@debian.org, kumba@gentoo.org
Subject: [ANNOUNCE] sdparm 0.96
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sdparm is a command line utility designed to get and set
SCSI device parameters (cf hdparm for ATA disks). Apart
from SCSI devices (e.g. disks, tapes and enclosures) sdparm
can be used on any device that uses a SCSI command set.
Virtually all CD/DVD drives use the SCSI MMC set irrespective
of the transport. sdparm also can decode VPD pages including
the device identification page. Commands to start and stop
the media; load and unload removable media and some other
housekeeping functions are supported. sdparm can be used in
both the lk 2.4 and 2.6 series.

This release adds 'capacity', 'sense' and 'sync' commands.
Change '-ll' to add explanation of some complex mode page
field values.

For more information and downloads see:
http://www.torque.net/sg/sdparm.html

Changelog:
http://www.torque.net/sg/p/sdparm.ChangeLog


Doug Gilbert
