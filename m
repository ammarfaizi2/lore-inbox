Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbUBNQC7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 11:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbUBNQC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 11:02:59 -0500
Received: from web14902.mail.yahoo.com ([216.136.225.54]:58028 "HELO
	web14902.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262123AbUBNQC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 11:02:59 -0500
Message-ID: <20040214160254.19491.qmail@web14902.mail.yahoo.com>
Date: Sat, 14 Feb 2004 08:02:54 -0800 (PST)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: libata patch
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest 2.6 bk libata patch took my box down. It's a Dell PE400SC, 82801EB
ICH5, SATA drives. It works for a little while then I get DMA errors, then I
freeze.
It had been working fine on 2.6 for months.

I have non-RAID ICh5. One SATA drive using libata and one ATA drive.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! Finance: Get your refund fast by filing online.
http://taxes.yahoo.com/filing.html
