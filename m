Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131329AbRAQKaM>; Wed, 17 Jan 2001 05:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131394AbRAQKaC>; Wed, 17 Jan 2001 05:30:02 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:16907 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131329AbRAQK3s>; Wed, 17 Jan 2001 05:29:48 -0500
Message-ID: <3A657404.7EA4AAF9@t-online.de>
Date: Wed, 17 Jan 2001 11:29:24 +0100
From: Jeffrey.Rose@t-online.de (Jeffrey Rose)
Organization: http://ChristForge.SourceForge.net/
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Giacomo Catenazzi <cate@student.ethz.ch>, linux-kernel@vger.kernel.org
Subject: Re: Problems in 2.4 kernel
In-Reply-To: <fa.fb4ouhv.1q2suj4@ifi.uio.no> <3A656C1C.60B4330C@student.ethz.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo Catenazzi wrote:
> 
> aprasad@in.ibm.com wrote:
> >
> > Sanjeev Wrote:
> > I am not able to mount my floppy drive. When I try to mount it gives me the
> > following error
> > 'mount: /dev/fd0 has wrong major or minor number'
> 
> did you update the modutils?

I will double-check. Otherwise, I have noticed that, during reboot, I
get a message that my PCI ISDN config shows a conflict with IRQ 3 for
devices: 00:01:0  and  01:08.0 which might have some bearing on this
problem.

TIA,

Jeff

-- 
<Jeffrey.Rose@t-online.de>
KEYSERVER=wwwkeys.de.pgp.net
SEARCH STRING=Jeffrey Rose
KEYID=6AD04244
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
