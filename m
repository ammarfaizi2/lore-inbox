Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129809AbQKBGtZ>; Thu, 2 Nov 2000 01:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129958AbQKBGtQ>; Thu, 2 Nov 2000 01:49:16 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:9234 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S129809AbQKBGtB>;
	Thu, 2 Nov 2000 01:49:01 -0500
Message-ID: <3A010E3C.BADAAB94@mandrakesoft.com>
Date: Thu, 02 Nov 2000 01:48:28 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Wayne.Brown@altec.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
In-Reply-To: <8625698B.00200009.00@smtpnotes.altec.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wayne.Brown@altec.com wrote:
> What I haven't seen yet is
> an explanation of why kgcc can't be used for compiling *everything*

It can.  But if we are talking about 2.4.x, I want my kernel built with
the improved gcc-2.95.2 -- unless there is a good reason not to do so --
and kgcc is egcs-1.1.2 not gcc-2.95.2 on my system.

> and why
> another compiler even needs to be installed.

Cuz the kernel should not dictate the compiler choice for the entire
distro.

-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
