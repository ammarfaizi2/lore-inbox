Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUFJRxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUFJRxX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 13:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUFJRxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 13:53:23 -0400
Received: from cyberhostplus.biz ([209.124.87.2]:30601 "EHLO
	server.cyberhostplus.biz") by vger.kernel.org with ESMTP
	id S262138AbUFJRxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 13:53:21 -0400
From: "Steve Lee" <steve@tuxsoft.com>
To: <linux-kernel@vger.kernel.org>
Subject: APIC error on CPU1: 00(02) && APIC error on CPU0: 00(02)
Date: Thu, 10 Jun 2004 12:53:29 -0500
Message-ID: <000401c44f13$da874e90$8119fea9@pluto>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.cyberhostplus.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - tuxsoft.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

APIC error on CPU1: 00(02)
APIC error on CPU0: 00(02)

I've spent some time trying to research these error messages, but I'm
not exactly sure what I'm looking at.  I've read that these may indicate
a faulty or soon to go faulty processor.  However, when I do get these
errors, it always involves both processors.  What are the odds both
would be dying at the same time?

Please CC, thanks!
Steve


