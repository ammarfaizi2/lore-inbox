Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135243AbRDVSmi>; Sun, 22 Apr 2001 14:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136259AbRDVSmU>; Sun, 22 Apr 2001 14:42:20 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1553 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135243AbRDVSld>; Sun, 22 Apr 2001 14:41:33 -0400
Subject: Re: Linux 2.4.3-ac12
To: jes@linuxcare.com (Jes Sorensen)
Date: Sun, 22 Apr 2001 19:42:51 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rmk@arm.linux.org.uk (Russell King),
        philb@gnu.org (Philip Blundell), junio@siamese.dhis.twinsun.com,
        manuel@mclure.org (Manuel McLure), linux-kernel@vger.kernel.org
In-Reply-To: <d366fw29sv.fsf@lxplus015.cern.ch> from "Jes Sorensen" at Apr 22, 2001 06:12:16 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rOov-0006Kc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In principle you just need 2.7.2.3 for m68k, but someone decided to
> raise the bar for all architectures by putting a check in a common
> header file.

I suspect you would find that some of the problems with the initialisers
in structures were common to 2.7.2 across all platforms, but I may be wrong

> Maybe it's time to move that check to the arch include dir instead?

I have no problem there

