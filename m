Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132049AbQKBBCM>; Wed, 1 Nov 2000 20:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132062AbQKBBCD>; Wed, 1 Nov 2000 20:02:03 -0500
Received: from janeway.cistron.net ([195.64.65.23]:59655 "EHLO
	janeway.cistron.net") by vger.kernel.org with ESMTP
	id <S132049AbQKBBBv>; Wed, 1 Nov 2000 20:01:51 -0500
Date: Thu, 2 Nov 2000 02:01:49 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
Message-ID: <20001102020149.A4194@cistron.nl>
In-Reply-To: <20001101234058.B1598@werewolf.able.es> <20001101235734.D10585@garloff.etpnet.phys.tue.nl> <200011012247.OAA19546@pizda.ninka.net> <8tqbrl$q59$1@enterprise.cistron.net> <3A00B5B5.A6480752@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A00B5B5.A6480752@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Nov 01, 2000 at 07:30:45PM -0500
X-NCC-RegID: nl.cistron
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Jeff Garzik:
> Miquel van Smoorenburg wrote:
> > By default Debian comes
> > with gcc 2.95.2 which compiles current 2.2.x and 2.4.x kernels just
> > fine.
> 
> <checks>  Linux-Mandrake 7.2 doesn't seem to be missing gcc patches that
> Debian has...  and in our testing we've found that some drivers are
> still miscompiled by gcc 2.95.2+fixes.  I'm not so sure you are correct
> here...

Really? Interesting! I'm not claiming I am completely correct, I'm
just stating what seems to be current Debian policy. Can you tell
me what drivers are miscompiled by 2.95.2, I'd appreciate that.

Mike.
-- 
People get the operating system they deserve.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
