Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131018AbQKIO0Y>; Thu, 9 Nov 2000 09:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130286AbQKIO0O>; Thu, 9 Nov 2000 09:26:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18514 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131020AbQKIO0G>; Thu, 9 Nov 2000 09:26:06 -0500
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
To: tytso@MIT.EDU (Theodore Y. Ts'o)
Date: Thu, 9 Nov 2000 14:26:33 +0000 (GMT)
Cc: paulj@itg.ie (Paul Jakma), rothwell@holly-springs.nc.us (Michael Rothwell),
        cr@sap.com (Christoph Rohland), richardj_moore@uk.ibm.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <200011091414.JAA21924@tsx-prime.MIT.EDU> from "Theodore Y. Ts'o" at Nov 09, 2000 09:14:26 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13tsex-0001Cs-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually, he's been quite specific.  It's ok to have binary modules as
> long as they conform to the interface defined in /proc/ksyms.  

What is completely unclear is if he has the authority to say that given that
there is code from other people including the FSF merged into the tree.

I've taken to telling folks who ask about binary modules to talk to their legal
department. The whole question is simply to complicated for anyone else to
work on.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
