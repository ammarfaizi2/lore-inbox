Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278582AbRJSScE>; Fri, 19 Oct 2001 14:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278583AbRJSSby>; Fri, 19 Oct 2001 14:31:54 -0400
Received: from msgbas1tx.cos.agilent.com ([192.25.240.37]:21214 "HELO
	msgbas2.cos.agilent.com") by vger.kernel.org with SMTP
	id <S278582AbRJSSbr>; Fri, 19 Oct 2001 14:31:47 -0400
Message-ID: <01A7DAF31F93D511AEE300D0B706ED9208E4A1@axcs13.cos.agilent.com>
From: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: pci_alloc_consistent question
Date: Fri, 19 Oct 2001 12:32:19 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List,

Is there any limitation on the amount of contiguous dmaable memory that
can be allocated using a single call to pci_alloc_consistent() ?

Regards,
-hiren
