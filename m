Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137203AbRAHHpQ>; Mon, 8 Jan 2001 02:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143377AbRAHHpF>; Mon, 8 Jan 2001 02:45:05 -0500
Received: from ns1.megapath.net ([216.200.176.4]:45586 "EHLO megapathdsl.net")
	by vger.kernel.org with ESMTP id <S137203AbRAHHow>;
	Mon, 8 Jan 2001 02:44:52 -0500
Message-ID: <3A596FAC.1020401@megapathdsl.net>
Date: Sun, 07 Jan 2001 23:43:40 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-ac1 i686; en-US; m18) Gecko/20001231
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, David Hinds <dhinds@sonic.net>
Subject: Are PCI add-on Cardbus Readers supported by the 2.4.0 kernel?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I would like to perform more PCMCIA/Cardbus testing
on a wider array of systems.  I am considering buying
a Ratoc Cardbus PC Adapter (model number CBS51U).

Here are the specs:

	PCI-CardBus Bridge adapter board
	Allows CardBus PC Cards to be shared by both portable and desktop PC.
	Supplied ISA-IRQ routing board allows you to use 16-bit PC Cards.
	Automatic detection between 16-bit and CardBus PC Card.
	ACPI support
	for PC with PCI slot/ISA slot

	Bus type : Type II CardBus
	Bus mastering : Yes

	Data Transfer Rate
	Compression : (Native/Uncompressed)

The specs mention Win98 support.  Hopefully that doesn't
mean this is some sort of "WinCardbus Reader" heap of junk.

Has anyone gotten this board or a similar one from
another manufacturer to work?

Thanks,
	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
