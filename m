Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262233AbVF2D7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbVF2D7J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 23:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVF2D7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 23:59:09 -0400
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:45770 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S262265AbVF2D7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 23:59:00 -0400
Message-ID: <42C21C80.5060802@bigpond.net.au>
Date: Wed, 29 Jun 2005 13:58:56 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Possible excessive logging from sym53c8xx_2 SCSI driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 29 Jun 2005 03:58:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a system with a LSI Logic/Symbios Logic 53c810 SCSI device with 
an external Iomega Zip drive and an internal Iomega Jaz drive attached 
both of which appear to be operating normally.  However, I am also 
getting the following message:

Jun 29 13:15:04 mudlark kernel: sd 0:0:6:0: phase change 6-7 9@37caa7a0 
resid=7.

every 2 seconds (approximately).  Does it indicate some hardware problem 
that I should be concerned about or can I ignore it?  If it's just 
informative does it have to be repeated so frequently?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
