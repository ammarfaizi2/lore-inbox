Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131850AbRAHKCr>; Mon, 8 Jan 2001 05:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132556AbRAHKCh>; Mon, 8 Jan 2001 05:02:37 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:40406 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131850AbRAHKCY>; Mon, 8 Jan 2001 05:02:24 -0500
Message-ID: <3A599198.122CE1EA@uow.edu.au>
Date: Mon, 08 Jan 2001 21:08:24 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: David Ford <david@linux.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Broken tty handling
In-Reply-To: <Pine.LNX.4.10.10101072145070.12242-100000@Huntington-Beach.Blue-Labs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:
> 
> Every once in a while I have a very frustrating problem develop.  All tty
> handling stops.
> ...
> # uname -r
> 2.4.0-test11

Fixed in test13, I suspect.

http://www.uwsg.iu.edu/hypermail/linux/kernel/0012.2/0823.html
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
