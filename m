Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264388AbUD2Nfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbUD2Nfr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 09:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264513AbUD2Nfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 09:35:47 -0400
Received: from web90001.mail.scd.yahoo.com ([66.218.94.59]:61016 "HELO
	web90001.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S264501AbUD2Nfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 09:35:46 -0400
Message-ID: <20040429133545.35335.qmail@web90001.mail.scd.yahoo.com>
Date: Thu, 29 Apr 2004 06:35:45 -0700 (PDT)
From: Shobhit Mathur <shobhitmmathur@yahoo.com>
Subject: Latest /proc implementation ?.....
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am implementing a /proc interface for our HBA which
registers as a SCSI HBA with the SCSI-midlayer. 
Hello,

I am aware of existing /proc/ implementations wherein
buffer-size is limited and data upto 4096 bytes
only is displayable via the "proc_info" entry-point in
the Scsi_Host_Template structure.

I would like to know what is the new methodology of
implementing /proc which is supposed to have overcome
the buffer-limitation of the earlier /proc handling.

- Kindly let me know

- Thank you

- Shobhit Mathur


	
		
__________________________________
Do you Yahoo!?
Win a $20,000 Career Makeover at Yahoo! HotJobs  
http://hotjobs.sweepstakes.yahoo.com/careermakeover 
