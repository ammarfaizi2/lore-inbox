Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264375AbRGNRdu>; Sat, 14 Jul 2001 13:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264416AbRGNRdl>; Sat, 14 Jul 2001 13:33:41 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14861 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264375AbRGNRdd>; Sat, 14 Jul 2001 13:33:33 -0400
Subject: Re: (patch-2.4.6) Fix oops with Iomega Clik! (ide-floppy)
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Sat, 14 Jul 2001 18:33:45 +0100 (BST)
Cc: cw@f00f.org (Chris Wedgwood), alan@lxorguk.ukuu.org.uk (Alan Cox),
        dwmw2@infradead.org (David Woodhouse),
        hch@caldera.de (Christoph Hellwig),
        Gunther.Mayer@t-online.de (Gunther Mayer), paul@paulbristow.net,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <3B50817B.37FE29@mandrakesoft.com> from "Jeff Garzik" at Jul 14, 2001 01:29:31 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15LTIY-0001Ul-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> tangent, it would be nice to remove __KERNEL__ from at least the i386
> kernel headers in 2.5, and I think it's a doable task...

That just generates work for the glibc folks when they are working off copies
of kernel header snapshots as they need to


