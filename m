Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRAYNoF>; Thu, 25 Jan 2001 08:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129310AbRAYNnp>; Thu, 25 Jan 2001 08:43:45 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:16914 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129051AbRAYNni>;
	Thu, 25 Jan 2001 08:43:38 -0500
Message-ID: <3A702D2A.5B4F97FD@mandrakesoft.com>
Date: Thu, 25 Jan 2001 08:42:02 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@innominate.de>
CC: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Patches
In-Reply-To: <200101250611.f0P6BI418581@devserv.devel.redhat.com> <3A702AC1.A077A105@innominate.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> Netscape is bad news for patches, both sending and receiving.  On send
> it wraps lines and doesn't let you see the wrapped version until after
> it's sent - on receive it likes to convert tabs to spaces.  Avoid.

I use Netscape Mail all the time to send patches, and it works
beautifully 95% of the time.

If you attach the patch, Netscape detects it is text/plain and does not
encode it.  People who dislike MIME complain a bit, but at least you can
see the patch and comment on it.  And attaching the patch ensures that
no editor mangling occurs.

That said, every now and then, Netscape's text/plain autodetect will
puke and eat an attached patch.  But that happens so infrequently that
the utility outweighs the pain.

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
