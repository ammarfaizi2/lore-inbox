Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbUKPT31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbUKPT31 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 14:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbUKPT1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 14:27:51 -0500
Received: from fmr11.intel.com ([192.55.52.31]:11962 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S262111AbUKPT01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 14:26:27 -0500
Subject: [BKPATCH] ACPI for 2.4
From: Len Brown <len.brown@intel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Willy Tarreau <willy@w.ods.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1100633170.5876.1002.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 16 Nov 2004 14:26:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, please do a 

	bk pull bk://linux-acpi.bkbits.net/24-latest-release

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/24-latest-release/acpi-20040326-24-latest-release.diff.gz

This will update the following files:

 drivers/acpi/system.c |    1 -
 1 files changed, 1 deletion(-)

through these ChangeSets:

<len.brown@intel.com> (04/11/16 1.1458.1.7)
   [ACPI] fix NMI during poweroff
   http://bugzilla.kernel.org/show_bug.cgi?id=1206
   
   Signed-off-by: Len Brown <len.brown@intel.com>




