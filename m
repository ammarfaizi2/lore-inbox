Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135651AbRA0Xhv>; Sat, 27 Jan 2001 18:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135711AbRA0Xhm>; Sat, 27 Jan 2001 18:37:42 -0500
Received: from mail.diligo.fr ([194.153.78.251]:26884 "EHLO mail.diligo.fr")
	by vger.kernel.org with ESMTP id <S135651AbRA0Xhf>;
	Sat, 27 Jan 2001 18:37:35 -0500
Date: Sun, 28 Jan 2001 00:35:02 +0100
From: patrick.mourlhon@wanadoo.fr
To: clock@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: CBQ simply doesn't work
Message-ID: <20010128003502.A2846@MourOnLine.dnsalias.org>
Reply-To: patrick.mourlhon@wanadoo.fr
In-Reply-To: <20010128000157.48012@ghost.btnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010128000157.48012@ghost.btnet.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> #!/bin/bash
> /sbin/insmod cls_fw
> /sbin/insmod sch_prio
> /sbin/insmod sch_cbq
> /sbin/insmod cls__u32

myne here is cls_u32

> insmod: a module named sch_cbq already exists
> insmod: cls__u32: no module by that name found

but i use 2.4... and i just feel your classifier
cannot work anymore... because of this module.

Well, this just intrigue me... i just feel
i could have done some similar mystake..

Regards,


patrick mourlhon

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
