Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265213AbTLFR1W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 12:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265214AbTLFR1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 12:27:21 -0500
Received: from web14909.mail.yahoo.com ([216.136.225.61]:54181 "HELO
	web14909.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265213AbTLFR1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 12:27:21 -0500
Message-ID: <20031206172720.52128.qmail@web14909.mail.yahoo.com>
Date: Sat, 6 Dec 2003 09:27:20 -0800 (PST)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: [PATCH] FIx  'noexec' behavior
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes Mozilla fail to load on my system. If I back it out everything
is fine again. No error messages, Mozilla just hangs for about thirty seconds
and exits.

CUPS also hangs at shutdown.

epiphany works both ways.

Running up2date Fedora and current 2.6 kernel.
P4, 2.8 HT, SMP enabled, ACPI


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
New Yahoo! Photos - easier uploading and sharing.
http://photos.yahoo.com/
