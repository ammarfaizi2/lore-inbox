Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWBVS0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWBVS0M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 13:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWBVS0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 13:26:12 -0500
Received: from tomts16.bellnexxia.net ([209.226.175.4]:32690 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1750773AbWBVS0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 13:26:10 -0500
Message-ID: <43FCAC84.5070901@torque.net>
Date: Wed, 22 Feb 2006 13:25:08 -0500
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org, tomfa@debian.org, kumba@gentoo.org
Subject: [ANNOUNCE] sdparm 0.97
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
housekeeping functions are supported. sdparm supports both
the lk 2.4 and 2.6 series.

For more information and downloads see:
http://www.torque.net/sg/sdparm.html

Changelog:
http://www.torque.net/sg/p/sdparm.ChangeLog


Doug Gilbert
