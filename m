Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265344AbRF0SMx>; Wed, 27 Jun 2001 14:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265341AbRF0SMo>; Wed, 27 Jun 2001 14:12:44 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16133 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265339AbRF0SMd>; Wed, 27 Jun 2001 14:12:33 -0400
Subject: Re: EEPro100 bug in 2.4.6pre5
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Wed, 27 Jun 2001 19:12:21 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <3B3A2176.11AF40E3@mandrakesoft.com> from "Jeff Garzik" at Jun 27, 2001 02:09:58 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FJna-0005bB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you have a bug report of this actually breaking?

I've not been able to make 2.4.6pre5 stay up long enough to do any real
testing on this. It just keeps hanging all the time anyway

> eepro100 is doing standard PCI PM.  The only reason AFAICS why it was
> breaking for people was that the previous PCI PM code did not do all the
> stuff it needed to do.  PCI PM should cover the various cases correctly,
> now, ditto eepro100.

The they should fix Config.in

