Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130069AbRAaSQw>; Wed, 31 Jan 2001 13:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130968AbRAaSQm>; Wed, 31 Jan 2001 13:16:42 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21769 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130069AbRAaSQZ>; Wed, 31 Jan 2001 13:16:25 -0500
Subject: Re: [PATCH] Making Cyrix III boot
To: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser)
Date: Wed, 31 Jan 2001 18:16:16 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <20010129034300.I1173@nightmaster.csn.tu-chemnitz.de> from "Ingo Oeser" at Jan 29, 2001 03:43:00 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14O1nm-0002pG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The Cyrix III of my employer doesn't boot without this patch.
> Reason: There are no MSRs in this range.
> 
> Since hpa didn't send a better fix, I attached the band-aid fix
> for you, so that people can boot.

HPA's suggested fix is in the -ac tree

> Linus, please apply.

Linus please apply hpa's correct fix instead
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
