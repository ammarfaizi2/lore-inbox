Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbQLFXua>; Wed, 6 Dec 2000 18:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129415AbQLFXuU>; Wed, 6 Dec 2000 18:50:20 -0500
Received: from smtp.lax.megapath.net ([216.34.237.2]:25875 "EHLO
	smtp.lax.megapath.net") by vger.kernel.org with ESMTP
	id <S129406AbQLFXuC>; Wed, 6 Dec 2000 18:50:02 -0500
Message-ID: <3A2EC91A.20206@megapathdsl.net>
Date: Wed, 06 Dec 2000 15:17:46 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12 i686; en-US; m18) Gecko/20001202
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jerdfelt@valinux.com, usb@in.tum.de
Subject: Re: test12-pre6
In-Reply-To: <20001206200803.C847@arthur.ubicom.tudelft.nl> <Pine.LNX.4.10.10012061131320.1873-100000@penguin.transmeta.com> <20001206210928.G847@arthur.ubicom.tudelft.nl> <3A2EAA62.1DB6FCCC@mandrakesoft.com> <3A2EC472.40900@megapathdsl.net> <3A2EC824.3C814C48@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

<snip>

> eh?  It's self-evident from Erik's patch that pci_enable_device's return
> call is already being tested, thus you only need to add a call to
> pci_set_master.

Sorry.  I'll shut up now and go back to doing something
I actually am somewhat knowledgable about -- namely, testing.

Please forgive the noise,

	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
