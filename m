Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWDSPYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWDSPYw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 11:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWDSPYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 11:24:52 -0400
Received: from mx17.sac.fedex.com ([199.81.216.126]:35809 "EHLO
	mx17.sac.fedex.com") by vger.kernel.org with ESMTP id S1750880AbWDSPYv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 11:24:51 -0400
Date: Wed, 19 Apr 2006 23:26:23 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@indiana.corp.fedex.com
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: sata suspend resume ...
Message-ID: <Pine.LNX.4.64.0604192324040.29606@indiana.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 04/19/2006
 11:24:44 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 04/19/2006
 11:24:48 PM,
	Serialize complete at 04/19/2006 11:24:48 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Any change of getting suspend/resume to work on my IBM X60s notebook.

Disk model is ...

 	MODEL="ATA HTS541060G9SA00"
 	FW_REV="MB3I"

Linux 2.6.17-rc2.

System suspends ok. Resume ok. but no disk access after that.


Thanks,
Jeff
