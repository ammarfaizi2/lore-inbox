Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVCCJnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVCCJnK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 04:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVCCJmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 04:42:15 -0500
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:25553 "EHLO
	ppsw-4.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261861AbVCCJlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 04:41:06 -0500
Date: Thu, 3 Mar 2005 09:40:59 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: akpm <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntfs: fix printk format warning (ia64)
In-Reply-To: <20050302215146.7a971d99.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.60.0503030938340.26782@hermes-1.csi.cam.ac.uk>
References: <20050302215146.7a971d99.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Wed, 2 Mar 2005, Randy.Dunlap wrote:
> ntfs: Fix printk format warnings on ia64:

Thanks!  I will apply it to my tree so it will be in next -mm and then in 
next NTFS release in mainline.

ps. You obviously compiled with ntfs debugging enabled...  I had never 
bothered fixing up those warnings as most people don't...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
