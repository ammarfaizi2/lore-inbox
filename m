Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263527AbTLDVxK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 16:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263528AbTLDVxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 16:53:10 -0500
Received: from may.nosdns.com ([207.44.240.96]:11223 "EHLO may.nosdns.com")
	by vger.kernel.org with ESMTP id S263527AbTLDVxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 16:53:08 -0500
Date: Thu, 4 Dec 2003 14:52:42 -0700
From: "Russell \"Elik\" Rademacher" <elik@webspires.com>
X-Mailer: The Bat! (v2.00.6) Business
Reply-To: "Rusell \"Elik\" Rademacher" <elik@webspires.com>
X-Priority: 3 (Normal)
Message-ID: <5410840093.20031204145242@webspires.com>
To: linux-kernel@vger.kernel.org
Subject: Hyperthreading Xeons Support - 2.4 Kernel - Patch Anyone?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - may.nosdns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - webspires.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

    I been wondering what the position on the developers on the hyperthreading on 2.4.x series kernels? I know it is fully supported in 2.6.x series, but it used to be supported on 2.4.20 and below and now it disappeared on 2.4.21 to 2.4.23 as far reporting the hyperthreaded Xeons processors.  If there is a patch for this that enables it and support it, I would appreciate it so I can get this back on the kernel and have it running.

    Lot of my clients are complaining about it saying they spents $$$$ for Xeons processors and linux 2.4.x don't support it anymore or don't report the number of processors properly anymore.  I for one want to shut them up. :)
-- 
Best regards,
Russell "Elik" Rademacher
Freelance Remote System Adminstrator/Tech Support    

