Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289172AbSBJCSA>; Sat, 9 Feb 2002 21:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289198AbSBJCRt>; Sat, 9 Feb 2002 21:17:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62222 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289172AbSBJCRc>; Sat, 9 Feb 2002 21:17:32 -0500
Subject: Re: ALI 15X3 DMA Freeze
To: kernel@iggy.triode.net.au (Linux Kernel Mailing List)
Date: Sun, 10 Feb 2002 02:30:59 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020210124207.C5191@iggy.triode.net.au> from "Linux Kernel Mailing List" at Feb 10, 2002 12:42:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Zjlb-0000Bh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm using kernel 2.4.18-pre9, which has a problem when I switch DMA on 
> the IDE hard drive. With DMA enabled, I cannot complete a kernel
> compile without the machine locking up. The motherboard is an

Start by picking up the ide updates either from the -ac kernel or from
Andre's web site. 
