Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131465AbQKBAbS>; Wed, 1 Nov 2000 19:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131776AbQKBAa6>; Wed, 1 Nov 2000 19:30:58 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:45835 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131465AbQKBAat>;
	Wed, 1 Nov 2000 19:30:49 -0500
Message-ID: <3A00B5B5.A6480752@mandrakesoft.com>
Date: Wed, 01 Nov 2000 19:30:45 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
In-Reply-To: <20001101234058.B1598@werewolf.able.es> <20001101235734.D10585@garloff.etpnet.phys.tue.nl> <200011012247.OAA19546@pizda.ninka.net> <8tqbrl$q59$1@enterprise.cistron.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:
> By default Debian comes
> with gcc 2.95.2 which compiles current 2.2.x and 2.4.x kernels just
> fine.

<checks>  Linux-Mandrake 7.2 doesn't seem to be missing gcc patches that
Debian has...  and in our testing we've found that some drivers are
still miscompiled by gcc 2.95.2+fixes.  I'm not so sure you are correct
here...

-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
