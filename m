Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265618AbRF1KE5>; Thu, 28 Jun 2001 06:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265621AbRF1KEr>; Thu, 28 Jun 2001 06:04:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4874 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265618AbRF1KEb>; Thu, 28 Jun 2001 06:04:31 -0400
Subject: Re: VIA 686B/Data Corruption FAQ
To: gareth.hughes@acm.org (Gareth Hughes)
Date: Thu, 28 Jun 2001 11:03:53 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <3B3A8EF4.8F8DF887@acm.org> from "Gareth Hughes" at Jun 28, 2001 11:57:08 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FYeP-0006Yq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> http://www.viahardware.com/686bfaq.shtm
> 
> Couldn't find a mention of this in the archives, but those interested in
> the VIA chipset issues should check this out.  The page contains the
> following officail statement from VIA:

Yeah I've seen it, but they won't tell people what is in it which is useless
to non windows people. The whole procedure is quite complex because the fixups
depend which PCI cards you have (eg ES137x 'SB PCI 64/SB PCI 128' cards don't
work with the base set of fixups but apparently use a different set)

Alan

