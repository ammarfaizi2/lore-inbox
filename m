Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288577AbSADKVx>; Fri, 4 Jan 2002 05:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288581AbSADKVn>; Fri, 4 Jan 2002 05:21:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36879 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288577AbSADKVW>; Fri, 4 Jan 2002 05:21:22 -0500
Subject: Re: 53c810 SCSI controller not accessible on type-2 config PCI [Kerne
To: Christian.Bartels@airbus.dasa.de (Bartels, Christian)
Date: Fri, 4 Jan 2002 10:32:11 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <ADC649D6283BD511B2A90008C71E93BF33A430@s02mks8.ham.airbus.dasa.de> from "Bartels, Christian" at Jan 04, 2002 10:38:14 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16MRe0-0003RT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     Non-VGA device: NCR 53c810 (rev 1).
>       Medium devsel.  IRQ 10.  Master Capable.  Latency=80.  
>       I/O at 0xd000 [0xd001].

What does this device look like in 2.2.18 ?
