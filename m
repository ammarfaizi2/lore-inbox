Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265821AbUAKK24 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 05:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265826AbUAKK2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 05:28:53 -0500
Received: from indianer.linux-kernel.at ([212.24.125.53]:14490 "EHLO
	indianer.linux-kernel.at") by vger.kernel.org with ESMTP
	id S265821AbUAKK2t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 05:28:49 -0500
From: "Oliver Pitzeier" <oliver@linux-kernel.at>
To: "'Thomas Steudten'" <alpha@steudten.com>
Cc: "'Ivan Kokshaysky'" <ink@jurassic.park.msu.ru>,
       "'Falk Hueffner'" <falk.hueffner@student.uni-tuebingen.de>,
       "'Richard Henderson'" <rth@twiddle.net>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>, <linux-alpha@vger.kernel.org>,
       <akpm@osdl.org>
Subject: RE: Kernel Panic: kernel-2.6.1 for alpha in scsi context ll_rw_blk.c
Date: Sun, 11 Jan 2004 11:26:23 +0100
Organization: linux-kernel.at
Message-ID: <023d01c3d82d$5d7013e0$020b10ac@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <40002F69.9020302@steudten.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-MailScanner-Information-linux-kernel.at: Please contact your Internet E-Mail Service Provider for more information
X-MailScanner-linux-kernel.at: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I test the new 2.6.1 kernel and run in the same problem as 
> before. The reason is, that the patch from Ivan isn´t there 
> in the kernel source tree.
> 
> Please add the patch to the mainline.

For me it works without patching anything. I still use my Digital Alpha AS
1000A for testing new kernels. I currently have no Compaq DS10 available,
else I would try this as well :-(

Best regards,
 Oliver

