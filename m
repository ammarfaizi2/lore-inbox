Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAECWM>; Thu, 4 Jan 2001 21:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129507AbRAECWD>; Thu, 4 Jan 2001 21:22:03 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32274 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129183AbRAECVn>; Thu, 4 Jan 2001 21:21:43 -0500
Subject: Re: [patch] big udelay's in fb drivers (2.4.0-prerelease)
To: oxymoron@waste.org (Oliver Xymoron)
Date: Fri, 5 Jan 2001 02:22:32 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), marko@l-t.ee (Marko Kreen),
        linux-kernel@vger.kernel.org (linux-kernel),
        torvalds@transmeta.com (Linus Torvalds),
        linux-fbdev@vuser.vu.union.edu
In-Reply-To: <Pine.LNX.4.30.0101041814140.14623-100000@waste.org> from "Oliver Xymoron" at Jan 04, 2001 07:31:39 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14EMWY-0006s6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  udelay(15000); /* delay 15ms */
> 
> the comment is just extra baggage. No sense touching it generally, but if
> you're gonna change it to mdelay..

The comments are 15 (50) implying someone swapped them around for a reason
and noted it
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
