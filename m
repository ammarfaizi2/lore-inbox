Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbUA0LAG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 06:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbUA0LAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 06:00:06 -0500
Received: from ns1.sys-net.it ([194.244.21.114]:6078 "EHLO mail.sys-net.it")
	by vger.kernel.org with ESMTP id S263244AbUA0LAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 06:00:03 -0500
Message-ID: <4576.193.227.212.131.1075201177.squirrel@webmail.sys-net.it>
Date: Tue, 27 Jan 2004 11:59:37 +0100 (CET)
Subject: 
From: "Nicola Canepa" <nicola.canepa@sys-net.it>
To: <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.11 [cvs])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SysNet-MailAV: 1.1 (www.sys-net.it)
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to use kernel 2.6.0 (the SuSE binary RPM), and I found some
problems with USB.

In particular, my USB mouse stopped working when I plugged in my USB
storage (external hard disk),and the same happened when I
plugged/unplugged the AC adapter from my laptop (Acer Aspire 1300 - AMD
Athlon XP 1600+).
Simply removing and plugging in again the mouse solved the problem, but
it's not a nice behaviour.

Nicola Canepa <nicola.canepa@sys-net.it>
Veritas Certified
Tel: 0521-918369
SysNet,   Via Dossi 8,    27100 Pavia  - Italy
Tel.: +39 0382 573859,      Fax: +39 0382 531274



