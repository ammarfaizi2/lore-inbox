Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274198AbRI3VkA>; Sun, 30 Sep 2001 17:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274221AbRI3Vju>; Sun, 30 Sep 2001 17:39:50 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29448 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274198AbRI3Vjd>; Sun, 30 Sep 2001 17:39:33 -0400
Subject: Re: DMA problem (?) w/2.4.6-xfs and ServerWorks OSB4 Chipset
To: mjustice@austin.rr.com
Date: Sun, 30 Sep 2001 22:45:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01093016084007.00965@bozo> from "Marvin Justice" at Sep 30, 2001 04:08:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15noOS-0007gw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alright. Until the situation clarifies you might tell RH turn off OSB4 by 
> default in future releases. It caused us no end of grief with 2.4.3-12.

Blacklisting seagate drives on the OSB4 is already on the todo list - its
taken a long time to figure out what was going on - it was only because
someone had > 100 boxes and knew they all did this that we got anywhere
