Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264906AbRGELq7>; Thu, 5 Jul 2001 07:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264908AbRGELqs>; Thu, 5 Jul 2001 07:46:48 -0400
Received: from [202.140.153.5] ([202.140.153.5]:7697 "EHLO
	techctd.techmas.hcltech.com") by vger.kernel.org with ESMTP
	id <S264906AbRGELqd>; Thu, 5 Jul 2001 07:46:33 -0400
Message-ID: <3B4453E6.F4342781@techmas.hcltech.com>
Date: Thu, 05 Jul 2001 17:17:50 +0530
From: Vasu Varma P V <pvvvarma@techmas.hcltech.com>
Organization: HCL Technologies
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel Linux <linux-kernel@vger.kernel.org>
Subject: DMA memory limitation?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there any limitation on DMA memory we can allocate using
kmalloc(size, GFP_DMA)? I am not able to acquire more than
14MB of the mem using this on my PCI SMP box with 256MB ram.
I think there is restriction on ISA boards of 16MB.
Can we increase it ?

thx,
Vasu

