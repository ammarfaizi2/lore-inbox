Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291355AbSBXVb6>; Sun, 24 Feb 2002 16:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291390AbSBXVbt>; Sun, 24 Feb 2002 16:31:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14096 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291355AbSBXVbh>;
	Sun, 24 Feb 2002 16:31:37 -0500
Message-ID: <3C795BB0.F8BB3818@mandrakesoft.com>
Date: Sun, 24 Feb 2002 16:31:28 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Martin Dalecki <dalecki@evision-ventures.com>,
        Troy Benjegerdes <hozer@drgw.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
In-Reply-To: <E16f5z8-0002id-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> I know what would actually help here, (the other code wasn't broken IMHO)
> and would clean this up properly for not just IDE. Add a bus_speed field
> to the struct pci_bus - that is where the info belongs and its the platform
> specific bus code that can find the bus speed out (if anyone)

agreed

-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |
