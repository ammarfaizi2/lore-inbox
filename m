Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261225AbRELLYI>; Sat, 12 May 2001 07:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261224AbRELLX6>; Sat, 12 May 2001 07:23:58 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:17668 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S261225AbRELLXr>; Sat, 12 May 2001 07:23:47 -0400
From: mdaljeet@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
Message-ID: <CA256A4A.003E8B45.00@d73mta05.au.ibm.com>
Date: Sat, 12 May 2001 16:52:27 +0530
Subject: dma error
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Was there any change in the PCI initialization code between versions
2.4.0-test8 and 2.4.2.?

I am working on a card and for the same register settings of the card, DMA
from host memory to card memory is successfull for the 2.4.0-test8 but on
2.4.2 kernel, the data transfer is successfull but data gets corrupted.

However the DMA from card memory to system memory is succesull on both the
versions of kernel.

I am not on mailing list. So reply to my id as listed in CC.

Thanks,
Daljeet Maini


