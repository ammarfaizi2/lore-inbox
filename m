Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135197AbRDROwP>; Wed, 18 Apr 2001 10:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135199AbRDROwI>; Wed, 18 Apr 2001 10:52:08 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41222 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135197AbRDROv6>; Wed, 18 Apr 2001 10:51:58 -0400
Subject: Re: Supplying missing entries for Configure.help -- corrections
To: esr@snark.thyrsus.com (Eric S. Raymond)
Date: Wed, 18 Apr 2001 15:52:43 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), torvalds@transmeta.com,
        axel@uni-paderborn.de, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <200104181335.f3IDZrq17002@snark.thyrsus.com> from "Eric S. Raymond" at Apr 18, 2001 09:35:53 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ptK2-0004ts-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Support for Cobalt Micro Server
>  CONFIG_COBALT_MICRO_SERVER
> -  Support for ARM-based Cobalt boxes (they have been bought by Sun and
 +  Support for MIPS-based Cobalt boxes (they have been bought by Sun and

Cobalt support was removed in the 2.4.4pre4 tree. Its not been maintained
for 2.4 because nobody is interested in doing the job
