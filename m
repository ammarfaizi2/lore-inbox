Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRBKRMR>; Sun, 11 Feb 2001 12:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129137AbRBKRMH>; Sun, 11 Feb 2001 12:12:07 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63244 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129842AbRBKRLu>; Sun, 11 Feb 2001 12:11:50 -0500
Subject: Re: hard lockup (no oops) on vanilla 2.4.2-pre3 with /dev/dsp
To: indigoid@higherplane.net (john slee)
Date: Sun, 11 Feb 2001 17:12:14 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010211222032.A975@higherplane.net> from "john slee" at Feb 11, 2001 10:20:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14S02u-0004TC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hrm.  it misbehaved on ac9 now.  i'll try a different soundcard and see
> what happens.  is es1370 known to be relatively stable?  i have one of
> those lying about somewhere.

The es1370 hasnt changed much but the VM code had a little (and testing ac9
tests who different sets of behaviour). If you have ACPI enabled then disable
it next test

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
