Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317369AbSGDIaN>; Thu, 4 Jul 2002 04:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317367AbSGDIaM>; Thu, 4 Jul 2002 04:30:12 -0400
Received: from lapd.cj.edu.ro ([193.231.142.101]:13790 "HELO lapd.cj.edu.ro")
	by vger.kernel.org with SMTP id <S317369AbSGDIaL>;
	Thu, 4 Jul 2002 04:30:11 -0400
Date: Thu, 4 Jul 2002 11:32:23 +0300 (EEST)
From: "Lists (lst)" <linux@lapd.cj.edu.ro>
To: "Mohamed Ghouse , Gurgaon" <MohamedG@ggn.hcltech.com>
cc: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: IRQ
In-Reply-To: <5F0021EEA434D511BE7300D0B7B6AB5303F1333C@mail2.ggn.hcltech.com>
Message-ID: <Pine.LNX.4.43L0.0207041131040.13387-100000@lapd.cj.edu.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is there any possibility 2 assign explicitly an IRQ or change the IRQ for a
> specific device after it has been assigned an IRQ.


pirq option in LILO/GRUB (read Documentation/i386/IO-APIC.txt in kernel 
sources)
or setpci

Best Regards,
Cosmin

