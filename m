Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbRAEACL>; Thu, 4 Jan 2001 19:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129465AbRAEACC>; Thu, 4 Jan 2001 19:02:02 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:53009 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129415AbRAEABw>; Thu, 4 Jan 2001 19:01:52 -0500
Subject: Re: [patch] big udelay's in fb drivers (2.4.0-prerelease)
To: oxymoron@waste.org (Oliver Xymoron)
Date: Fri, 5 Jan 2001 00:02:33 +0000 (GMT)
Cc: marko@l-t.ee (Marko Kreen), linux-kernel@vger.kernel.org (linux-kernel),
        torvalds@transmeta.com (Linus Torvalds),
        linux-fbdev@vuser.vu.union.edu
In-Reply-To: <Pine.LNX.4.30.0101041305080.14623-100000@waste.org> from "Oliver Xymoron" at Jan 04, 2001 01:07:12 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14EKLE-0006gk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Once the comments are unweirded, they become completely superfluous. At
> which point its best not to have them - when someone next comes along and
> changes the delay, it might end up disagreeing with the comment and
> causing confusion.

Before you remove the comments check with the author and the manuals.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
