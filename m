Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133106AbRDRMYF>; Wed, 18 Apr 2001 08:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133103AbRDRMXq>; Wed, 18 Apr 2001 08:23:46 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:39429 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133105AbRDRMXm>; Wed, 18 Apr 2001 08:23:42 -0400
Subject: Re: Supplying missing entries for Configure.help, part 4
To: philb@gnu.org (Philip Blundell)
Date: Wed, 18 Apr 2001 13:24:34 +0100 (BST)
Cc: esr@snark.thyrsus.com (Eric S. Raymond),
        alan@lxorguk.ukuu.org.uk (Alan Cox), torvalds@transmeta.com,
        axel@uni-paderborn.de, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <E14pn6x-00049s-00@kings-cross.london.uk.eu.org> from "Philip Blundell" at Apr 18, 2001 09:14:51 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pr0g-0004bw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >+Support for Cobalt Micro Server
> >+CONFIG_COBALT_MICRO_SERVER
> >+  Support for ARM-based Cobalt boxes (they have been bought by Sun and
> >+  are now the "Server Appliance Business Unit") including the 2700 series
> 
> Aren't those machines MIPS based?

They are mips based and support for them was also removed from the kernel so
the entry doesnt want to go in. I'd rather have missing than wrong entries

