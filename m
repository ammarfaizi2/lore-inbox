Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbTK3Unk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 15:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTK3Unk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 15:43:40 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:46577 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S263142AbTK3Unj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 15:43:39 -0500
Message-ID: <001301c3b782$a1afa460$02c8a8c0@steinman>
Reply-To: "Adam Kropelin" <akropel1@rochester.rr.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: Anyone have a working sparc64 Ultra 5/10 .config for recent 2.6.0-testN?
Date: Sun, 30 Nov 2003 15:43:37 -0500
Organization: Kroptech
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to get recent 2.5.x and 2.6.0-testN kernels running on
my Ultra 10 without any luck so far. In all cases the boot hangs
immediately after...

Remapping the kernel... done.
Booting Linux...
<hang>

2.4.x kernels build and boot ok. My system is stock Aurora 1.0 (Ansel)
with
module-init-tools-0.9.15-pre3.

Given the many changes to the kernel config and my inexperience at
configuring a sparc64 kernel I presume I've messed up the .config
somehow. If anyone has a working sparc64 config for Ultra 5/10/etc, I'd
appreciate taking a look at it...

TIA
--Adam

