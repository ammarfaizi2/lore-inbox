Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131161AbQLFBZl>; Tue, 5 Dec 2000 20:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131160AbQLFBZb>; Tue, 5 Dec 2000 20:25:31 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5636 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131030AbQLFBZT>; Tue, 5 Dec 2000 20:25:19 -0500
To: michal@harddata.com (Michal Jaegermann)
Date: Wed, 6 Dec 2000 00:57:13 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20001205151813.A1062@mail.harddata.com> from "Michal Jaegermann" at Dec 05, 2000 03:18:13 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E143StY-0000CS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> depmod: *** Unresolved symbols in /lib/modules/2.2.18pre24/misc/agpgart.o
> depmod:         smp_call_function
> depmod:         smp_num_cpus
> 
> The machine affected is actually Alpha but likely this is not relevant.

For ksyms the architecture is often very relevant so thanks for warning me what
you are using. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
