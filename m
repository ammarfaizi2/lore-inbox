Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266137AbUHNXJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbUHNXJP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 19:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266287AbUHNXJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 19:09:15 -0400
Received: from fmr99.intel.com ([192.55.52.32]:38278 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S266137AbUHNXJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 19:09:14 -0400
Subject: [BKPATCH] ACPI for 2.6
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jesse Barnes <jbarnes@sgi.com>
Content-Type: text/plain
Organization: 
Message-Id: <1092524935.5028.304.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 Aug 2004 19:08:56 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.6.8

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.8/acpi-20040715-2.6.8.diff.gz

This will update the following files:

 include/asm-ia64/acpi.h |    1 +
 init/main.c             |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

through these ChangeSets:

<len.brown@intel.com> (04/08/14 1.1731.1.31)
   [ACPI] ia64 build fix
   Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

<len.brown@intel.com> (04/08/14 1.1731.1.30)
   fix main.c build warning




