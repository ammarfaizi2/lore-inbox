Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbUBHG6U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 01:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbUBHG6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 01:58:20 -0500
Received: from mailgate01.ctimail.com ([203.186.94.111]:60817 "EHLO
	mailgate01.ctimail.com") by vger.kernel.org with ESMTP
	id S262598AbUBHG6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 01:58:19 -0500
Message-Id: <200402080657.i186v7p10163@mailgate01.ctimail.com>
From: "Francis, Chong Chan Fai" <francis.ccf@polyu.edu.hk>
To: "'Mike Fedyk'" <mfedyk@matchmail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: USB 2.0 mass storage problem
Date: Sun, 8 Feb 2004 14:58:17 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcPuDi7hel59cNS9RfSd5Gt1lgK1wAAAVyWw
In-Reply-To: <20040208063447.GB18674@srv-lnx2600.matchmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Probably a problem with pcmcia.

> I've used a usb 2.0 pci card, but the cpu usage is so high that it's just
as
> fast as the same card using the uhci-hcd driver -- and uhci uses *much*
> less cpu.

Thank you for your reply.

I don't have the performance problem with USB2.0, it read a file lightning
fast (compare with USB 1.0), but just hang shortly after a few files.

I using USB 1.0 as a work around, but my disk is 120G and the speed is
terrible.

Because the command " lspci " show the PCMCIA bus correctly, I didn't
thought it could be a problem. If it is the case, what can I do? 

