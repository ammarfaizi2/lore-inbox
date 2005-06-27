Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVF0UEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVF0UEo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVF0UEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 16:04:43 -0400
Received: from [212.76.84.231] ([212.76.84.231]:25605 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S261458AbVF0UE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 16:04:29 -0400
Message-Id: <200506272004.XAA09696@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kswapd flaw
Date: Mon, 27 Jun 2005 23:04:08 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Thread-Index: AcV7U2C4NhiVhET/Rha0ce0C8Wkaeg==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In 2.4.31 kswapd starts paging during OOMs even w/o swap enabled.

Is there a way to fix/disable this behaviour?

Thanks!

