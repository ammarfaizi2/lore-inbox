Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129352AbQLMB02>; Tue, 12 Dec 2000 20:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLMB0R>; Tue, 12 Dec 2000 20:26:17 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:20233 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129226AbQLMB0D>;
	Tue, 12 Dec 2000 20:26:03 -0500
Message-ID: <3A36C902.B5F31E11@mandrakesoft.com>
Date: Tue, 12 Dec 2000 19:55:30 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Torrey Hoffman <torrey.hoffman@myrio.com>
CC: linux-kernel@vger.kernel.org, "'adam@yggdrasil.com'" <adam@yggdrasil.com>,
        "'thockin@isunix.it.ilstu.edu'" <thockin@isunix.it.ilstu.edu>
Subject: Re: National Semiconductor DP83815 ethernet driver?
In-Reply-To: <4461B4112BDB2A4FB5635DE19958743202239C@mail0.myrio.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Torrey Hoffman wrote:
> 
> I am wondering about the current status of a driver for the NS83815 ethernet
> chip.
> 
> >From searching Google, I know some sort of driver exists. In July, Adam J.
> Richter (adam@yggdrasil.com) posted a 2.2.16 driver he obtained from Dave
> Gotwisner at Wyse Technologies. And Tim Hockin mentioned that he was using
> an NSC driver, but had made some minor modifications.

Use drivers/net/natsemi.c...  it's in 2.4.x-test.

-- 
Jeff Garzik         |
Building 1024       | These are not the J's you're lookin' for.
MandrakeSoft        | It's an old Jedi mind trick.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
