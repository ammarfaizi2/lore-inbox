Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272462AbRH3VFp>; Thu, 30 Aug 2001 17:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272463AbRH3VFf>; Thu, 30 Aug 2001 17:05:35 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12292 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272462AbRH3VFX>; Thu, 30 Aug 2001 17:05:23 -0400
Subject: Re: NFS in 2.4.8/9ac
To: ted@cypress.com (Thomas Dodd)
Date: Thu, 30 Aug 2001 22:08:56 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B8EA974.9060201@cypress.com> from "Thomas Dodd" at Aug 30, 2001 04:00:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cZ3Y-0001qB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.7-ac10 worked fine.2.4.8-ac8 through 2.4.9-ac3
> have trouble. I have not tested 2.4.8-ac[1..7] yet.

Ok can you transplant drivers/net/tulip from a working -ac into the
current tree and see if that fixes it - that tells us if its a network
driver bug or a kernel core bug.

Alan
