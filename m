Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVBGGR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVBGGR4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 01:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVBGGRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 01:17:33 -0500
Received: from web52203.mail.yahoo.com ([206.190.39.85]:30128 "HELO
	web52203.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261358AbVBGGRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 01:17:22 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=lxWC6BS0wPUyQxwdX4J5zn2VMVKLECnfUw1Zyge7ae7y0uL3L6zLsOblQ3G25o+uw77lcD1zVzmYsHWVpg0bkRGorr0Be9psUHniM3xREcDiQZN9icv3wn96MJ/Pxu0/ucLiihwL5Zo3xdfSPhRRboBnEJq13gHZr1R6Q01Bn+s=  ;
Message-ID: <20050207061718.47940.qmail@web52203.mail.yahoo.com>
Date: Sun, 6 Feb 2005 22:17:18 -0800 (PST)
From: linux lover <linux_lover2004@yahoo.com>
Subject: How to read file in kernel module?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
        I have written one /proc file creation kernel
module. This module creates /proc/file and defied
operations on it. Also i have written user program
that will read & write to /proc files from user space.
Now what i want is to use same bufproc_read &
bufproc_write  functions defined in /proc file
handling kernel module to be used in another kernel
module to read that /proc/file in kernel module.The
second kernel module only used to read /proc file in
kernel. I am not understanding how can i open that
/proc/file in second kenrel module to read in kernel?
regards,
linux_lover.



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Helps protect you from nasty viruses. 
http://promotions.yahoo.com/new_mail
