Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbQKDB2D>; Fri, 3 Nov 2000 20:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132334AbQKDB1y>; Fri, 3 Nov 2000 20:27:54 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:520 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S132333AbQKDB1n>;
	Fri, 3 Nov 2000 20:27:43 -0500
Message-ID: <3A036608.4A9BF17B@mandrakesoft.com>
Date: Fri, 03 Nov 2000 20:27:36 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Ford <david@linux.com>
CC: Alan Cox <alan@redhat.org>, tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
In-Reply-To: <E13rj9s-0003c4-00@the-village.bc.nu> <3A032828.6B57611F@linux.com> <3A0329DA.38A90824@mandrakesoft.com> <3A03335F.8E2B71B5@linux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:
> The odd part is that it used to work "way back when".  Was this just a fluke?

That may have been back in the legacy days.  Ejecting ne2k should be ok
as long as you are using ne2k-pci or pcnet_cs.  Eject serial looks like
bad news unless you are using serial_cs (which is impossible at the
moment, AFAIK).

-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
