Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129094AbQKBTGy>; Thu, 2 Nov 2000 14:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129129AbQKBTGo>; Thu, 2 Nov 2000 14:06:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37956 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129094AbQKBTGi>; Thu, 2 Nov 2000 14:06:38 -0500
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
To: Tim@Rikers.org (Tim Riker)
Date: Thu, 2 Nov 2000 19:07:12 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3A01B8BB.A17FE178@Rikers.org> from "Tim Riker" at Nov 02, 2000 11:55:55 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13rPhi-0001ng-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. There are architectures where some other compiler may do better
> optimizations than gcc. I will cite some examples here, no need to argue

I think we only care about this when they become free software.

> 2. There are architectures where gcc is not yet available, but vendor C
> compilers are.

That need to run Linux - name one ? Why try to solve a problem when it hasn't
happened yet. Let whoever needs to solve it do it. 

Alan


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
