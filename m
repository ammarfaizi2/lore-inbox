Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136023AbRAWDDZ>; Mon, 22 Jan 2001 22:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135997AbRAWDDR>; Mon, 22 Jan 2001 22:03:17 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:48439 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S135939AbRAWDDB>; Mon, 22 Jan 2001 22:03:01 -0500
Message-ID: <3A6CF442.86DE8496@linux.com>
Date: Tue, 23 Jan 2001 03:02:27 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Shawn Starr <Shawn.Starr@Home.net>
CC: Jorge Nerin <comandante@zaralinux.com>, linux-kernel@vger.kernel.org,
        linux-smp@vger.kernel.org
Subject: Re: kernel BUG at slab.c:1542!(2.4.1-pre9)
In-Reply-To: <3A6C5058.C5AA7681@zaralinux.com> <3A6CB620.469A15A9@Home.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If it makes the kernel do Bad Things, the kernel needs to be fixed.

-d

Shawn Starr wrote:

> This is not a kernel bug, This is a bug in the XFree86 TrueType rendering
> extention. This has been discussed on the Xpert XFree86 mailing list. There
> is a fix in the works (depends on the TrueType fonts your using).
>
> Unless otherwise, Im using 2.4.1-pre9 with no such faults (XFree86 CVS
> X11R6.5.1 merge sources) not 4.0.2 stable.

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
