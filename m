Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279981AbRK0Oyf>; Tue, 27 Nov 2001 09:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279969AbRK0OyZ>; Tue, 27 Nov 2001 09:54:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55823 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279981AbRK0OyR>; Tue, 27 Nov 2001 09:54:17 -0500
Subject: Re: 'spurious 8259A interrupt: IRQ7'
To: martin@jtrix.com (Martin A. Brooks)
Date: Tue, 27 Nov 2001 15:01:45 +0000 (GMT)
Cc: lkml@patrickburleson.com, linux-kernel@vger.kernel.org
In-Reply-To: <1793.10.119.8.1.1006872608.squirrel@extranet.jtrix.com> from "Martin A. Brooks" at Nov 27, 2001 02:50:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E168jk1-0001J7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Something I should have added to my post is that I have a Tulip based
> > NIC  from Netgear.  But I believe something is definitely amiss with
> > Athlon based  machines and Tulip cards and compiled in SMP support.
> 
> Mine is a UP box.

With IO Apic support included ? If you are using an AMD/VIA combo chipset
board that would explain it
