Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269390AbRHWSAC>; Thu, 23 Aug 2001 14:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269436AbRHWR7n>; Thu, 23 Aug 2001 13:59:43 -0400
Received: from msgbas2x.cos.agilent.com ([192.25.240.37]:28645 "HELO
	msgbas2.cos.agilent.com") by vger.kernel.org with SMTP
	id <S269390AbRHWR7f>; Thu, 23 Aug 2001 13:59:35 -0400
Message-ID: <FEEBE78C8360D411ACFD00D0B7477971880B3E@xsj02.sjs.agilent.com>
From: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: releasing driver to kernel in source+binary format
Date: Thu, 23 Aug 2001 11:59:49 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

We want to release a linux scsi hba-driver for our fibre-channel
HBAs and make it part of the kernel source tree. Because of IP 
related issues, we can only release one part of the sources with 
GPL. We want to release the other part in the binary format (.o)
as a library which needs to be linked with the first part.
If somebody can advise me on how to go about this, I would
appreciate it. 

I went through the "SubmittingDrivers" file
which does not talk about this kind of special cases.

Regards,
-hiren
Agilent Technologies.
