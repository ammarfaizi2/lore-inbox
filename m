Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266135AbRGGMMY>; Sat, 7 Jul 2001 08:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266157AbRGGMMO>; Sat, 7 Jul 2001 08:12:14 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64777 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266151AbRGGMME>; Sat, 7 Jul 2001 08:12:04 -0400
Subject: Re: 2.4.6 PCMCIA NET modular build breakage
To: rmk@arm.linux.org.uk (Russell King)
Date: Sat, 7 Jul 2001 13:12:26 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010707101657.C10927@flint.arm.linux.org.uk> from "Russell King" at Jul 07, 2001 10:16:57 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Iqwk-0005kf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Seems like its something that appeared between 2.4.5 and 2.4.6.  Anyone
> know the correct fix, other than reversing the change?

I build with all pcmcia network drivers modular on my test builds, what
am I missing here ?
