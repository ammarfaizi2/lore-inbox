Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275002AbTHLC3A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 22:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275003AbTHLC3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 22:29:00 -0400
Received: from core.kaist.ac.kr ([143.248.147.118]:30082 "EHLO
	core.kaist.ac.kr") by vger.kernel.org with ESMTP id S275002AbTHLC27
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 22:28:59 -0400
Message-ID: <003801c36078$e23b1250$a5a5f88f@core8fyzomwjks>
From: "Cho, joon-woo" <jwc@core.kaist.ac.kr>
To: <linux-kernel@vger.kernel.org>
Subject: [Q] Is  'I/O memory'  managed as page?
Date: Tue, 12 Aug 2003 11:24:40 +0900
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

'I/O memory' is memory in device (like PCI/ISA device).

And that memory is mapped into virtual memory by ioremap function.


After mapping, is 'I/O memory' managed as page like memory on host?

Please answer, thanks!


