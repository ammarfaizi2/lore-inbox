Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbTIWTGv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbTIWTGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:06:51 -0400
Received: from smtp4.us.dell.com ([143.166.148.135]:60355 "EHLO
	smtp4.us.dell.com") by vger.kernel.org with ESMTP id S262192AbTIWTGk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:06:40 -0400
Date: Tue, 23 Sep 2003 14:06:40 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@dell.com>
X-X-Sender: mdomsch@iguana.localdomain
To: torvalds@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] s/Dell Computer Corporation/Dell Inc./
Message-ID: <Pine.LNX.4.44.0309231404110.11196-100000@iguana.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://mdomsch.bkbits.net/linux-2.5-dellname

This will update the following files:

 CREDITS                     |    2 +-
 arch/i386/kernel/dmi_scan.c |    2 +-
 arch/i386/kernel/edd.c      |    2 +-
 arch/ia64/kernel/mca.c      |    2 +-
 drivers/ieee1394/oui.db     |    6 +++---
 drivers/scsi/aacraid/README |    8 ++++----
 fs/partitions/efi.c         |    2 +-
 fs/partitions/efi.h         |    2 +-
 include/asm-i386/edd.h      |    2 +-
 include/linux/pci-dynids.h  |    2 +-
 10 files changed, 15 insertions(+), 15 deletions(-)

through these ChangeSets:

<Matt_Domsch@dell.com> (03/09/23 1.1326)
   s/Dell Computer Corporation/Dell Inc./
   
   Necessary due to company name change.


Only comments (or in case of drivers/ieee1394/oui.db the displayed name) are changed.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

