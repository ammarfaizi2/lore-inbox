Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbQLOBhd>; Thu, 14 Dec 2000 20:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132657AbQLOBhX>; Thu, 14 Dec 2000 20:37:23 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12293 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129325AbQLOBhT>; Thu, 14 Dec 2000 20:37:19 -0500
Subject: Re: Signal 11
To: michael@linuxmagic.com (Michael Peddemors)
Date: Fri, 15 Dec 2000 01:09:29 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <0012141807080M.19494@mistress> from "Michael Peddemors" at Dec 14, 2000 06:07:08 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146jNL-0000SN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > o	We tell vendors to build RPMv3 , glibc 2.1.x
> Curious HOW do you tell vendors??

When they ask. More usefully Dan Quinlann and most vendors put together a
recommended set of things to build with and use. It warns about library
pitfalls, kernel changes and what packaging is supported. It is far from
perfect and nothing like the LSB goals but its a start and following it does
give you applications that with a bit of care run on everything.

> > o	Vendors not being stupid understand that they have a bigger market
> > 	share if they do that.
> Ummm.. I remember Oracle's first release... wasn't it JUST redhat??

I believe so, and Adabas was SuSE only, and I doubt either vendor wanted it
that way. Both actually ran fine on the other but were not supported.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
