Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266177AbUF3BHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266177AbUF3BHH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 21:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266179AbUF3BHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 21:07:07 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:48601 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S266177AbUF3BHF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 21:07:05 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: not detectable
To: linux-kernel@vger.kernel.org
Subject: Missing config entries
Date: Tue, 29 Jun 2004 21:07:03 -0400
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406292107.03143.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.59.165] at Tue, 29 Jun 2004 20:07:04 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I just took note of an odd error message from amanda, so I took a look 
at linux-2.6.7mm3, then -mm2, and found that while the advansys code 
is still there in the drivers/scsi dir, the config file entries are 
not, so its not possible to build this driver into the kernel 
starting with 2.6.7-mm3 without hacking it back into the .config.

Was ths intentional?

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
