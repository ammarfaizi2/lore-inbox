Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292666AbSCRTvO>; Mon, 18 Mar 2002 14:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292594AbSCRTuy>; Mon, 18 Mar 2002 14:50:54 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:33550 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S292555AbSCRTuw>; Mon, 18 Mar 2002 14:50:52 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A7715@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: PCI drivers - memory mapped vs. I/O ports
Date: Mon, 18 Mar 2002 11:50:41 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a PCI device can be programmed equally well via I/O port space or memory
space, what are the reasons to chose one space over the other when writing
the driver?

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------


