Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264719AbRFSS4Q>; Tue, 19 Jun 2001 14:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264702AbRFSS4G>; Tue, 19 Jun 2001 14:56:06 -0400
Received: from msgbas1x.cos.agilent.com ([192.6.9.33]:25841 "HELO
	msgbas1.cos.agilent.com") by vger.kernel.org with SMTP
	id <S264709AbRFSSzs>; Tue, 19 Jun 2001 14:55:48 -0400
Message-ID: <FEEBE78C8360D411ACFD00D0B7477971880AB2@xsj02.sjs.agilent.com>
From: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: how to get DMA'able memory within 4GB on 64-bit machine
Date: Tue, 19 Jun 2001 12:55:30 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List,

Is there a way for a driver to ask kernel to
give DMA'able memory within 4GB ? I read about
pci_alloc_consistent(). But I could not find out
whether that guarantees the DMA'able memory to be
within 4GB or not. Is there any other kernel routine
that I should call from Driver to get such a memory ?

Regards,
-hiren
hiren_mehta@agilent.com
