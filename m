Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131496AbRDCAaL>; Mon, 2 Apr 2001 20:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131476AbRDCAaB>; Mon, 2 Apr 2001 20:30:01 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:6611 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S131496AbRDCA3o>;
	Mon, 2 Apr 2001 20:29:44 -0400
Message-ID: <3AC9194F.7D7986D5@mandrakesoft.com>
Date: Mon, 02 Apr 2001 20:29:03 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-20mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gustavo Niemeyer <niemeyer@conectiva.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: can not compile 2.4.3 on alpha
In-Reply-To: <3AC86511.F3123F6C@lmt.lv> <20010402100230.B15554@tux.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gustavo Niemeyer wrote:
> Hello Andrejs!!
> > /usr/src/linux-2.4.3/include/asm/pgalloc.h:334: conflicting types for
> > `pte_alloc'

> This is happening on ia64 as well. The interface seems to have changed
> but some architectures were forgotten.

The interface changed and other architectures have not caught up yet :) 
Other archs pretty much always play catch-up to the x86 port.

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
