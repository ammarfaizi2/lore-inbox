Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132391AbQKXJbU>; Fri, 24 Nov 2000 04:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132285AbQKXJbL>; Fri, 24 Nov 2000 04:31:11 -0500
Received: from xerxes.thphy.uni-duesseldorf.de ([134.99.64.10]:59542 "EHLO
        xerxes.thphy.uni-duesseldorf.de") by vger.kernel.org with ESMTP
        id <S132391AbQKXJbD>; Fri, 24 Nov 2000 04:31:03 -0500
Date: Fri, 24 Nov 2000 10:00:53 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: More PCI ID's for linux-2.4.0-test11/include/linux/pci_ids.h
In-Reply-To: <20001123175955.A7314@baldur.yggdrasil.com>
Message-ID: <Pine.LNX.4.10.10011240956320.30803-100000@chaos.thphy.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

On Thu, 23 Nov 2000, Adam J. Richter wrote:

> 	The following patch adds some missing PCI_VENDOR_ID's and
> PCI_DEVICE_ID's that are scattered throughout a bunch of .c files in
> drivers/isdn/hisax/.  The definitions in the .c files are protected
> by '#ifndef PCI_VENDOR_ID_...', so it is not necessary to remove
> those declarations from the .c files during the code freeze unless
> you want to (and I would be happy to provide a patch for that too).

Actually, I'm currently working on the same thing currently. (Also,
__init/__exit etc) It'ld be very much appreciated if you sent your patches
through the maintainer (i4ldeveloper@listserv.isdn4linux.de), so that we
can avoid duplicated effort.

--Kai

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
