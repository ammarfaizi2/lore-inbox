Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbTGXLCJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 07:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTGXLCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 07:02:09 -0400
Received: from beta.galatali.com ([216.40.241.205]:21476 "EHLO
	beta.galatali.com") by vger.kernel.org with ESMTP id S262093AbTGXLCH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 07:02:07 -0400
Date: Thu, 24 Jul 2003 07:17:12 -0400
Mime-Version: 1.0 (Apple Message framework v552)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: 2.6.0-test1 Adaptec aic7899 Ultra160 SCSI grief
From: Tugrul Galatali <tugrul@galatali.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <5F99705E-BDC8-11D7-9859-000A957CBE4C@galatali.com>
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	After months of using 2.5.x with stability on my box, and using 
2.6.0-test1 since the day after its release (with the 20030714 ACPI 
patch), I had two seemingly random SCSI hangs today. One shortly after 
I booted the box in the afternoon, and one after about 15 hours of 
uptime. I was busy the first time around, but the second time I managed 
to scp out a copy of the current dmesg to another box before a hard 
power down.

	Can somebody translate the error in the dmesg into english and advise 
me on whether I want to change something in the software or the 
hardware?

http://acm.cs.nyu.edu/~tugrul/scsi/

	Thanks in advance,
		Tugrul Galatali

