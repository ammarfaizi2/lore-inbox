Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263487AbRFKStX>; Mon, 11 Jun 2001 14:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263536AbRFKStN>; Mon, 11 Jun 2001 14:49:13 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33540 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263487AbRFKStC>; Mon, 11 Jun 2001 14:49:02 -0400
Subject: Re: UDMA on Dell Inspiron 8000
To: dogbert@clue4all.net (Brian J. Conway)
Date: Mon, 11 Jun 2001 19:47:28 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.BSF.4.33.0106111421300.90812-100000@clue4all.net> from "Brian J. Conway" at Jun 11, 2001 02:26:12 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E159Wim-0000Cy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> PCI_IDE: unknown IDE controller on PCI bus 00 device f9, VID=8086,
> DID=244a

The i815 mobile chipset isnt in Linus kernel tables at that point. I think it
should be in by 2.4.5, but its in -ac if not
