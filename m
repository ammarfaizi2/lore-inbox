Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264480AbRFITQU>; Sat, 9 Jun 2001 15:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264481AbRFITQK>; Sat, 9 Jun 2001 15:16:10 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43016 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264480AbRFITQA>; Sat, 9 Jun 2001 15:16:00 -0400
Subject: Re: IRQ problems on new Toshiba Libretto
To: lentsch@nal.go.jp (Aron Lentsch)
Date: Sat, 9 Jun 2001 20:14:27 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0106092217330.1008-100000@triton.nal.go.jp> from "Aron Lentsch" at Jun 10, 2001 12:01:48 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E158oBn-0004J4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> about half of my devices are unusable. I am getting the
> message "PCI: No IRQ known for interrupt pin A of
> device 00:00.0. Please try using pci=biosirq." This
> message is repeated for the following devices:

That sounds like IRQ routing problems. Im sure Linus as the crusoe expert and
the irq routing guru would like to know

Did you try the pci=biosirq boot option btw ?


