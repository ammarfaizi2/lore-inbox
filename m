Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbULDVXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbULDVXq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 16:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbULDVXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 16:23:46 -0500
Received: from stress.telefonica.net ([213.4.129.135]:53087 "EHLO
	tnetsmtp2.mail.isp") by vger.kernel.org with ESMTP id S261165AbULDVXn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 16:23:43 -0500
From: Jose Alberto Reguero <jareguero@telefonica.net>
To: linux-kernel@vger.kernel.org
Subject: wine and kernel 2.6.10-rc3
Date: Sat, 4 Dec 2004 22:23:45 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412042223.45364.jareguero@telefonica.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't use wine with kernels 2.6.10-rc3
With kernel 2.6.9 it works.
My system is an amd64 linux.
I read in the list that ptrace break wine , and find a patch 
for this, but the patch is only for i386 kernels.
There is a patch for amd64 kernels?
Thanks

log:
wine: Unhandled exception (thread 0009), starting debugger...
wine: Unhandled exception (thread 000b), starting debugger...
wine: Unhandled exception (thread 000d), starting debugger...
wine: Unhandled exception (thread 000f), starting debugger...
........
