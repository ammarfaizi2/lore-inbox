Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBFX3b>; Tue, 6 Feb 2001 18:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129956AbRBFX3V>; Tue, 6 Feb 2001 18:29:21 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:35851 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129952AbRBFX3Q>;
	Tue, 6 Feb 2001 18:29:16 -0500
Message-ID: <3A8088B1.7E4B4604@mandrakesoft.com>
Date: Tue, 06 Feb 2001 18:28:49 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jocelyn Mayer <jocelyn.mayer@netgem.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: FA-311 / Natsemi problems with 2.4.1
In-Reply-To: <3A806A22.4020204@netgem.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jocelyn Mayer wrote:
> 
> I found something from OpenBSD:
> the natsemi chip (in fact DP83815)
> is quite the same as SiS900 one.

If that is true, maybe you can hack drivers/net/sis900.c to get it to
work with the FA-311?

	Jeff



-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
