Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131487AbQLRJTD>; Mon, 18 Dec 2000 04:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131496AbQLRJSx>; Mon, 18 Dec 2000 04:18:53 -0500
Received: from [203.200.144.37] ([203.200.144.37]:54279 "HELO
	nest.stpt.soft.net") by vger.kernel.org with SMTP
	id <S131487AbQLRJSn>; Mon, 18 Dec 2000 04:18:43 -0500
Organization: NeST India
Message-ID: <F6E1228667B6D411BAAA00306E00F2A548461A@pdc2.nestec.net>
From: MOHAMMED AZAD <mohammedazad@nestec.net>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: reg memory allocated by kmalloc
Date: Mon, 18 Dec 2000 14:16:34 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I would like to know.. is memory allocated by kmalloc always double word
aligned????.. and is this suitable for dma only if i use GFP_DMA priority...
i mean dma for a pci device... or can i just specify GFP_KERNEL and use
it.... is it safe to proceed in this way???

thanks
azad
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
