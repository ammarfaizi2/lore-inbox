Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131713AbRBJTdg>; Sat, 10 Feb 2001 14:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131677AbRBJTdQ>; Sat, 10 Feb 2001 14:33:16 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:49418 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130529AbRBJTdM>; Sat, 10 Feb 2001 14:33:12 -0500
Subject: Re: hard lockup (no oops) on vanilla 2.4.2-pre3 with /dev/dsp
To: indigoid@higherplane.net (john slee)
Date: Sat, 10 Feb 2001 19:33:53 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010211053145.A748@higherplane.net> from "john slee" at Feb 11, 2001 05:31:45 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14RfmM-0002Ao-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> it doesn't happen to me on 2.4.1-pre11 with andrew morton's low
> scheduling latency patch.

Does 2.4.1-ac9 behave ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
