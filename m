Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262614AbRFBQYY>; Sat, 2 Jun 2001 12:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262615AbRFBQYO>; Sat, 2 Jun 2001 12:24:14 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25871 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262614AbRFBQX6>; Sat, 2 Jun 2001 12:23:58 -0400
Subject: Re: Problem with kernel 2.2.19 Ultra-DMA and SMP, once more
To: Magnus.Sandberg@bluelabs.se
Date: Sat, 2 Jun 2001 17:21:29 +0100 (BST)
Cc: andre@aslab.com (Andre Hedrick), magnus.sandberg@test.bluelabs.se,
        linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
In-Reply-To: <OF9113DCEA.9630D3AB-ONC1256A5F.00425B56@bluelabs.se> from "Magnus.Sandberg@bluelabs.se" at Jun 02, 2001 02:04:48 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E156E9Z-0001tB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Andre,
> The motherboard has VIA-chipset.

2.2 does not support VIA SMP. 2.4 should get it right. 2.2.20 may support it
but I'm working on a 3 month schedule for 2.2.20

