Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262517AbVAPONR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbVAPONR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 09:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbVAPOMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 09:12:10 -0500
Received: from mail.gmx.de ([213.165.64.20]:52158 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262517AbVAPN4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 08:56:10 -0500
Date: Sun, 16 Jan 2005 14:56:05 +0100 (MET)
From: "Daniel Schmidt" <dan1965@gmx.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Kernel config: "Use TOS as routing key"
X-Priority: 3 (Normal)
X-Authenticated: #25905207
Message-ID: <1812.1105883765@www1.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

some time ago, there was an option "Use TOS as routing key" in the kernel
configuration. I used it to priorize for example ssh connections, by
modifying their TOS value using iptables.

This option seems to have gone in a recent 2.6.10 kernel. Is there any way
to reenable it?

Thank you in advance.

Daniel.

-- 
+++ Sparen Sie mit GMX DSL +++ http://www.gmx.net/de/go/dsl
AKTION für Wechsler: DSL-Tarife ab 3,99 EUR/Monat + Startguthaben
