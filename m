Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131614AbRBJT1Q>; Sat, 10 Feb 2001 14:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131651AbRBJT1H>; Sat, 10 Feb 2001 14:27:07 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46346 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131614AbRBJT0x>; Sat, 10 Feb 2001 14:26:53 -0500
Subject: Re: 2.4.2-pre3 and 2.4.1-ac9 sound corruption
To: oleavr@online.no (Ole Andre Vadla Ravnaas)
Date: Sat, 10 Feb 2001 19:27:30 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7630470.981825632015.JavaMail.webmail1@wm-java1.fg.online.no> from "Ole Andre Vadla Ravnaas" at Feb 10, 2001 06:20:32 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14RfgE-00029m-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After upgrading to 2.4.2-pre3 I get sound corruption (I believe this proble=
> m has existed since pre2, since I suspect the " - driver sync up with Alan"=
>  part of the changes in pre2 to be the source of the problem. I've also tri=

No es1370 changes went in

> ed 2.4.1-ac9, which gives me the exact same problems (sound corruption, rea=
> lly "weird" sound).

Are you using XFree86 4.0 on a matrox card ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
