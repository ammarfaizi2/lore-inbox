Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbUDNNyg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 09:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264219AbUDNNyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 09:54:36 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:63434 "EHLO
	mailout3.samsung.com") by vger.kernel.org with ESMTP
	id S261273AbUDNNyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 09:54:35 -0400
Date: Wed, 14 Apr 2004 19:19:29 +0530
From: mohanlal jangir <mohanlal@samsung.com>
Subject: UART driver questions
To: Linux Newbies <kernelnewbies@nl.linux.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <01e401c42227$4fe62bd0$7f476c6b@sisodomain.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
X-Mailer: Microsoft Outlook Express 5.50.4927.1200
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am planning to write driver for UART. I have some questions about this.

1. How can I find base address of UART on my system?
2. Can UART also work in MMIO or PIO mode as network devices work?
3. Command "cat /proc/tty/driver/serial" displays port 0x3F8 and 0x2F8. I
also see, these values hardcoded in file serial.c (and corresponding
headers). Is it base address or I need some kind of remapping.

Regards
Mohanlal


