Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129573AbQLSNmr>; Tue, 19 Dec 2000 08:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129773AbQLSNmi>; Tue, 19 Dec 2000 08:42:38 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12554 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129573AbQLSNmb>; Tue, 19 Dec 2000 08:42:31 -0500
Subject: Re: emu10k1 broken in 2.2.18
To: rui.sousa@conexant.com
Date: Tue, 19 Dec 2000 13:13:51 +0000 (GMT)
Cc: aheitner@andrew.cmu.edu (Ari Heitner), alan@lxorguk.ukuu.org.uk,
        emu10k1-devel@opensource.creative.com, linux-kernel@vger.kernel.org,
        rsousa@grad.physics.sunysb.edu
In-Reply-To: <OF6B3623E3.C2E9E563-ONC12569BA.0030301F@conexant.com> from "rui.sousa@conexant.com" at Dec 19, 2000 09:51:49 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E148MaX-0007Fk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> want to try that. For this reason I also don't believe the problem is the
> any of the emu10k1

I dont think its the emu10k1 itself. Nor does it seem to be the init function
not being called (folks report seeing the init messages in both cases). I need
to trace the init order some time

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
