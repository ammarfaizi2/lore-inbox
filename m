Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbUKPXlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbUKPXlZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 18:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUKPXiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 18:38:55 -0500
Received: from smtp103.rog.mail.re2.yahoo.com ([206.190.36.81]:36715 "HELO
	smtp103.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262136AbUKPXig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 18:38:36 -0500
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: [BUG][2.6.10-rc2-bk1] ACPI S3 suspend to RAM broken (may be USB unable to resume)
Date: Tue, 16 Nov 2004 18:38:27 -0500
User-Agent: KMail/1.7
Cc: Len Brown <len.brown@intel.com>, acpi-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411161838.28344.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As of 2.6.10-rc1 + I can no longer resume from S3 (suspend-to-RAM),  When it 
begins to resume, it seems to get stuck with USB (going to confirm).. The 
laptop stays in a stuck state (cresent-moon remains lit).

I have IBM-ACPI extras turned on (compiled in).

Anyone else report this?

Shawn.
