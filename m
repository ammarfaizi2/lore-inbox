Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263120AbTJZNfP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 08:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbTJZNfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 08:35:14 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:40893 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S263120AbTJZNfM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 08:35:12 -0500
Date: Sun, 26 Oct 2003 13:35:10 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Missing ACPI interrupts/events after S3 suspend
Message-ID: <20031026133510.GA19227@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.6.0-test9 if I do an S3 suspend, then when the machine comes 
back pressing the power button generates no ACPI events or interrupts. 
Other events (sleep button, lid switch, plugging/unplugging AC adapter) 
still work.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
