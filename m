Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131480AbRDBXMv>; Mon, 2 Apr 2001 19:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131497AbRDBXMm>; Mon, 2 Apr 2001 19:12:42 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38673 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131480AbRDBXMc>; Mon, 2 Apr 2001 19:12:32 -0400
Subject: Re: EXT2-fs error
To: R.E.Wolff@BitWizard.nl (Rogier Wolff)
Date: Tue, 3 Apr 2001 00:13:16 +0100 (BST)
Cc: khromy@khromy.ath.cx (khromy), linux-kernel@vger.kernel.org
In-Reply-To: <200103300657.IAA07806@cave.bitwizard.nl> from "Rogier Wolff" at Mar 30, 2001 08:57:48 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kDVe-0006rj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I got the following while rm -rf'ing my mozilla cvs checkout.  Deadly or not deadly?
> 
> Highly deadly. 
> 
> Your disk is dropping bits, or, more likely, your RAM. This is very,
> very bad.

if it was 2.2 I'd believe it. 2.4 is still showing these kind of problems in
software on many VIA chipset athlon boards and under extreme loads on other
boxes too.
