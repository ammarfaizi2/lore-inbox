Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWACJ7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWACJ7O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 04:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWACJ7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 04:59:13 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:41129 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750916AbWACJ7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 04:59:13 -0500
Message-Id: <6.1.1.1.2.20060103105620.02c523e0@192.168.6.12>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Tue, 03 Jan 2006 10:58:41 +0100
To: graham.gower@gmail.com
From: Roger While <simrw@sim-basis.de>
Subject: Re: [PATCH] [TRIVIAL] prism54/islpci_eth.c: dev_kfree_skb in
  irq context
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-SIMBasis-MailScanner-Information: Please contact the ISP for more information
X-SIMBasis-MailScanner: Found to be clean
X-SIMBasis-MailScanner-From: simrw@sim-basis.de
X-ID: ZwBIGmZB8edlHg1pEgsT0gbd1HwWUpg2w4AwgqaUC1fLbPNK9gjqcA@t-dialin.net
X-TOI-MSGID: ca93c8c9-8a46-4936-9671-feeb7afd9008
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What makes you think this is in IRQ context ?


