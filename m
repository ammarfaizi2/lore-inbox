Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129807AbRAWLBI>; Tue, 23 Jan 2001 06:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129878AbRAWLA6>; Tue, 23 Jan 2001 06:00:58 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:45761 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129807AbRAWLAs>; Tue, 23 Jan 2001 06:00:48 -0500
Message-ID: <3A6D6602.BCA969E2@uow.edu.au>
Date: Tue, 23 Jan 2001 22:07:46 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Tigran Aivazian <tigran@veritas.com>
CC: Chmouel Boudjnah <chmouel@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre8/10 klogd taking 100% of CPU time -- bug?
In-Reply-To: <m3g0iaxzr6.fsf@giants.mandrakesoft.com> <Pine.LNX.4.21.0101231044220.1386-100000@penguin.homenet>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian wrote:
> 
> Asset Tag: Ñ^L.
> Asset Tag: Ò^L.
> 
> Btw, that Asset Tag printk's are surely buggy, aren't they? Aren't they
> supposed to dump in hex instead of some unprintable stuff?

I bugged Alan about that a few weeks back and he mumbled
something cryptic.  It seems he's going to take it out sometime.

As far as the klogd problem is concerned, see

	http://www.uwsg.iu.edu/hypermail/linux/kernel/0101.1/1053.html

for a probable solution.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
