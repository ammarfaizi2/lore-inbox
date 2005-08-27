Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbVH0C75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbVH0C75 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 22:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbVH0C75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 22:59:57 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:40352 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030286AbVH0C74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 22:59:56 -0400
Message-ID: <430FD71C.6050704@bigpond.net.au>
Date: Sat, 27 Aug 2005 12:59:40 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: sym53c8xx_2 is flooding my syslog ...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 27 Aug 2005 02:59:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... with the following message:

Aug 21 04:53:28 mudlark kernel: ..<6>sd 0:0:6:0: phase change 6-7 
9@01ab97a0 resid=7.

every 2 seconds.  Since the problem being reported seems to have no 
effect on the operation of the scsi devices is it really necessary to 
report it so often?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
