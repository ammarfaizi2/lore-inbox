Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262525AbREUWvb>; Mon, 21 May 2001 18:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262526AbREUWvV>; Mon, 21 May 2001 18:51:21 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61193 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262525AbREUWvQ>; Mon, 21 May 2001 18:51:16 -0400
Subject: Re: SMC-IRCC broken? 2.4.5-pre4 / -ac5+
To: pawel.worach@mysun.com
Date: Mon, 21 May 2001 23:48:35 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <32f42309df.309df32f42@mysun.com> from "Pawel Worach" at May 22, 2001 12:16:13 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E151yTb-00012f-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The kernel stops while booting at:
> TCP: Hash tables configured (established 16384 bind 16384)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> SMC IrDA Controller found; IrCC version 2.0, port 0x118, dma=3, irq=3

IRDA compiled in  ? If so is it ok modular . It sounds like yet another boot
ordering wonder

