Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276920AbRJCIro>; Wed, 3 Oct 2001 04:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276921AbRJCIre>; Wed, 3 Oct 2001 04:47:34 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56079 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276920AbRJCIrW>; Wed, 3 Oct 2001 04:47:22 -0400
Subject: Re: [QUESTION] ISA overhead
To: balbir.singh@wipro.com (BALBIR SINGH)
Date: Wed, 3 Oct 2001 09:52:39 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <3BBABC41.50203@wipro.com> from "BALBIR SINGH" at Oct 03, 2001 12:50:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ohlg-0007Vb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> All DMA has been limited to 16MB, this is ofcourse going to go
> away with the PCI DMA patch which allows PCI-DMA to use all the

PCI DMA has always been for all the mapped memory

