Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315414AbSGACbQ>; Sun, 30 Jun 2002 22:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315416AbSGACbP>; Sun, 30 Jun 2002 22:31:15 -0400
Received: from cambot.suite224.net ([209.176.64.2]:21516 "EHLO suite224.net")
	by vger.kernel.org with ESMTP id <S315414AbSGACbP>;
	Sun, 30 Jun 2002 22:31:15 -0400
Message-ID: <000a01c220a8$400a3300$3ff583d0@pcs686>
From: "Matthew D. Pitts" <mpitts@suite224.net>
To: "James Gale" <jimg@eskimo.com>, <linux-kernel@vger.kernel.org>
References: <20020630164932.B22175@eskimo.eskimo.com>
Subject: Re: System does not support PCI
Date: Sun, 30 Jun 2002 22:37:30 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James,

Try adding pci=bios to the boot options and see if it helps

Matthew D. Pitts
----- Original Message -----
From: "James Gale" <jimg@eskimo.com>
To: <linux-kernel@vger.kernel.org>
Sent: Sunday, June 30, 2002 7:49 PM
Subject: PCI: System does not support PCI


> All,
>
> I'm posting this in hope that someone can explain the problem
> I am seeing, or corroborate my story.  I'm not subscribed to this
> list so please CC me on any replies.  I've moved my old hard-disk
> with a 2.4 kernel to a new computer and tried to boot it up.  I
> get a strange message when I do that:
>
> PCI: System does not support PCI
>
> I don't have a /proc/pci file after boot-up either.
>
> The new computer is an Athlon based Shuttle FS40 motherboard which,
> of course, has a PCI bus.  So what would cause the kernel to think
> that this board doesn't support PCI?  I've fooled with a few different
> kernels that all give this error, but mostly I'm trying to boot my
> stock Debian 2.4.18 kernel.  Has anybody else seen this problem?
>
> Thanks,
> Jim
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

