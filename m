Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135305AbRAVVMV>; Mon, 22 Jan 2001 16:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135303AbRAVVML>; Mon, 22 Jan 2001 16:12:11 -0500
Received: from db0bm.automation.fh-aachen.de ([193.175.144.197]:44555 "EHLO
	db0bm.ampr.org") by vger.kernel.org with ESMTP id <S133051AbRAVVL6>;
	Mon, 22 Jan 2001 16:11:58 -0500
Date: Mon, 22 Jan 2001 22:11:51 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200101222111.WAA24348@db0bm.ampr.org>
To: vandrove@vc.cvut.cz
Subject: Re: display problem with matroxfb
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Petr,

Thank you for the answer.

>Are you sure that you did not enabled both vesafb and matroxfb? They cannot
>work together. Also, does this happen only in 8bpp mode, or does this
>happen in other color depths too?

Yes, sure. I've read the docs and tested with vesafb enabled OR matroxfb
enabled, never both.
This happens with both 8bpp or 16bpp. 

Is there a specific configuration file for the matrox ? 

---
Regards
		Jean-Luc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
