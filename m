Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132158AbRAUAaa>; Sat, 20 Jan 2001 19:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132637AbRAUAaT>; Sat, 20 Jan 2001 19:30:19 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:48913 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S132158AbRAUAaK>;
	Sat, 20 Jan 2001 19:30:10 -0500
Message-ID: <3A6A2D8D.D55655D5@mandrakesoft.com>
Date: Sat, 20 Jan 2001 19:30:05 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tobias Burnus <burnus@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Ethernet drivers: SiS 900, Netgear FA311
In-Reply-To: <3A6A2B9A.5F40CA04@gmx.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobias Burnus wrote:
> I think those drivers have not yet been merged. Since I happend to have
> those (and had problem to get them run with the default kernel) I'd like
> to asked whether those can be included into the kernel. They are GNU
> licensed. Seemingly the SiS updates the existing sis900 driver, the
> FA311 is not yet supported by the kernel.

Not true, see natsemi.c (in 2.4.x at least).

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
