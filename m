Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135860AbRAWDJG>; Mon, 22 Jan 2001 22:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135819AbRAWDI4>; Mon, 22 Jan 2001 22:08:56 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:65079 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S135860AbRAWDIo>; Mon, 22 Jan 2001 22:08:44 -0500
Message-ID: <3A6CF5B7.57DEDA11@linux.com>
Date: Tue, 23 Jan 2001 03:08:39 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-test10
In-Reply-To: <Pine.LNX.4.10.10101221711560.1309-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> The ChangeLog may not be 100% complete. The physically big things are the
> PPC and ACPI updates, even if most people won't notice.
>
>                 Linus
>
> ----
>
> pre10:
>  - got a few too-new R128 #defines in the Radeon merge. Fix.
>  - tulip driver update from Jeff Garzik
>  - more cpq and DAC elevator fixes from Jens. Looks good.
>  - Petr Vandrovec: nicer ncpfs behaviour
>  - Andy Grover: APCI update
>  - Cort Dougan: PPC update
>  - David Miller: sparc updates
>  - David Miller: networking updates
>  - Neil Brown: RAID5 fixes

Do the tulip driver updates address the increasingly common NETDEV timeout
repots?

-d

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
