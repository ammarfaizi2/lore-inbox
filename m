Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264619AbTHVQDn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 12:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264627AbTHVQDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 12:03:43 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:19372 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264619AbTHVQDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 12:03:40 -0400
Date: Fri, 22 Aug 2003 18:03:25 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add a couple pci ids to pci_ids.h
In-Reply-To: <200308221202.h7MC2dW0028913@hera.kernel.org>
Message-ID: <Pine.GSO.4.21.0308221801120.13238-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Aug 2003, Linux Kernel Mailing List wrote:
> ChangeSet 1.1104, 2003/08/22 08:53:10-03:00, jgarzik@pobox.com
> 
> 	[PATCH] add a couple pci ids to pci_ids.h
> 
> diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> --- a/include/linux/pci_ids.h	Fri Aug 22 05:02:40 2003
> +++ b/include/linux/pci_ids.h	Fri Aug 22 05:02:40 2003
> @@ -1648,6 +1648,9 @@
>  #define PCI_DEVICE_ID_TIGON3_5703	0x1647

0x1647 = 5703

>  #define PCI_DEVICE_ID_TIGON3_5704	0x1648

0x1648 = 5704

>  #define PCI_DEVICE_ID_TIGON3_5702FE	0x164d
> +#define PCI_DEVICE_ID_TIGON3_5705	0x1653

0x1653 != 5705 -> *** BEEP ***
0x1653 = 5715

> +#define PCI_DEVICE_ID_TIGON3_5705M	0x165d
> +#define PCI_DEVICE_ID_TIGON3_5782	0x1696

0x1696 = 5782

Or am I too paranoid?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

