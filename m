Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274208AbRISVwj>; Wed, 19 Sep 2001 17:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274211AbRISVw3>; Wed, 19 Sep 2001 17:52:29 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41477 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274208AbRISVwV>; Wed, 19 Sep 2001 17:52:21 -0400
Subject: Re: Locked up 2.4.10-pre11 on Tyan 815t motherboard. [EEPRO-100 bugs]
To: greearb@candelatech.com (Ben Greear)
Date: Wed, 19 Sep 2001 22:57:07 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3BA902B6.923D7ACA@candelatech.com> from "Ben Greear" at Sep 19, 2001 01:40:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jpL9-0003xg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I've fixed some of the problems in recent -ac (the power management timeout)
> > which is now in Linus tree. Arjan van de Ven also fixed some other bits.
> 
> Do you think you've fixed this?  If so, I'll give your version a try...

Its fixed on my 810 and 815 board. Whether its fixed on others I dont know
