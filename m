Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132865AbQL3Shn>; Sat, 30 Dec 2000 13:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133087AbQL3ShX>; Sat, 30 Dec 2000 13:37:23 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:38418 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S132865AbQL3ShN>;
	Sat, 30 Dec 2000 13:37:13 -0500
Date: Sat, 30 Dec 2000 19:06:36 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: Repeatable 2.4.0-test13-pre4 nfsd Oops rears it head again
Message-ID: <20001230190636.A11235@se1.cogenit.fr>
In-Reply-To: <20001228161126.A982@lingas.basement.bogus> <200012282159.NAA00929@pizda.ninka.net> <20001228212116.A968@lingas.basement.bogus> <92ha5l$1qh$1@penguin.transmeta.com> <3A4DBC02.92C0FD9A@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3A4DBC02.92C0FD9A@uow.edu.au>
X-Organisation: Marie's fan club
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <andrewm@uow.edu.au> écrit :
[...]
> The 3c905C is a well manufactured and very feature-rich NIC which at
> present appears to have fewer problem reports than eepro100, 8139 or tulip.

I guess that the lack of problem reports for the epic chipset comes from
a smaller user base. FWIW, I haven't experienced real problems with
it (observation base: 20~30 boards). Neither did I with the few 3c905 used btw.

[...]
> Perhaps most significantly, the 905 has full scatter/gather support.

May be done for the epic. TODO++

-- 
Ueimor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
