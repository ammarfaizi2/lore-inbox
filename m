Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTDQTEQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 15:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbTDQTEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 15:04:15 -0400
Received: from ohsmtp01.ogw.rr.com ([65.24.7.36]:7116 "EHLO
	ohsmtp01.ogw.rr.com") by vger.kernel.org with ESMTP id S261893AbTDQTEP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 15:04:15 -0400
Message-ID: <000501c30514$486cf1d0$0200a8c0@satellite>
From: "Dave Mehler" <dmehler26@woh.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: rh9 2.5 kernel additional information
Date: Thu, 17 Apr 2003 15:05:16 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
    Adding to my previous message, i reran the kernel configuration. I
ensured that the keyboard, mouse, and display settings were set right, and
that my processor and loadable module settings are also right. The only
thing i added was framebuffer console support, but that didn't make a
difference, after it hit the initrd it just hung. Any ideas?
Thanks.
Dave.

