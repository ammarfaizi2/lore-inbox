Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266434AbUFUTm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266434AbUFUTm1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 15:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266422AbUFUTm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 15:42:27 -0400
Received: from fmr01.intel.com ([192.55.52.18]:56999 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S266435AbUFUTln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 15:41:43 -0400
Subject: [BKPATCH] ACPI for 2.6
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1087846886.4319.184.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 21 Jun 2004 15:41:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.6.7

thanks,
-Len

ps. a plain patch is here:
http://linux-acpi.bkbits.net:8080/linux-acpi-release-2.6.7/gnupatch@40d735136IS3UC6I-LbwG91v0UYtLw

This will update the following files:

 arch/i386/kernel/mpparse.c   |    2 +-
 arch/x86_64/kernel/mpparse.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (04/06/21 1.1728.2.3)
   [ACPI] fix double timer interrupt mapping (Hans-Frieder Vogt)
   caused by errant fix for OSDL 2835




