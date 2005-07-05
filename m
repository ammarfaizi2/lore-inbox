Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbVGEQkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVGEQkV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 12:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVGEP5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 11:57:23 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:32695 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S261896AbVGEPlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 11:41:20 -0400
Date: Tue, 5 Jul 2005 17:41:19 +0200
From: Sander <sander@humilis.net>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: "'Jens Axboe'" <axboe@suse.de>, hdaps-devel@lists.sourceforge.net,
       "'LKML List'" <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
Message-ID: <20050705154119.GB27286@favonius>
Reply-To: sander@humilis.net
References: <20050705071449.GV1444@suse.de> <000701c5815d$3c29c840$600cc60a@amer.sykes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000701c5815d$3c29c840$600cc60a@amer.sykes.com>
X-Uptime: 15:23:58 up 1 day, 33 min, 12 users,  load average: 2.89, 2.65, 2.58
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alejandro Bonilla wrote (ao):
> 	If you check the IBM software in Windows, it shows 2 things.
> 	First, when it pauses the HD and when it stops the HD. It all
> 	depends on how hard you hit the PC. In one we suspend the drive
> 	and in the other we park the drive.

This is not true. The software only parks the head, it does not spin
down the disk. That would take too much time to protect against a fall
anyway.

        Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
