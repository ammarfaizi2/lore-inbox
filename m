Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292857AbSB0V1p>; Wed, 27 Feb 2002 16:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292965AbSB0V1L>; Wed, 27 Feb 2002 16:27:11 -0500
Received: from mailer3.bham.ac.uk ([147.188.128.54]:27839 "EHLO
	mailer3.bham.ac.uk") by vger.kernel.org with ESMTP
	id <S292962AbSB0V0m>; Wed, 27 Feb 2002 16:26:42 -0500
Date: Wed, 27 Feb 2002 21:26:39 +0000 (GMT)
From: Mark Cooke <mpc@star.sr.bham.ac.uk>
X-X-Sender: mpc@pc24.sr.bham.ac.uk
To: Alex Davis <alex14641@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: VIA Northbridge Workaround in 2.4.18 Causing Video Problems
In-Reply-To: <20020227180113.61446.qmail@web9204.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0202272125260.8511-100000@pc24.sr.bham.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2002, Alex Davis wrote:

> Sounds like a perfect candidate for a kernel config option.

Well - maybe a command line override to not make the (official) via 
recommended mod.  We can always hope that board manufacturers will 
(eventually) produce bios revs with fixed parameters too.

Mark

> >> So long as I am running a kernel that includes my hack, there's no
> >> problem. My main concern is that the next time that people with a system
> >> like mine want to upgrade their distribution, the distribution's kernel
> >> will include this workaround; those people (myself included) will then
> >> have a miserable time doing the upgrade. 
> 
> >Yes, this problem is curious since it seems to work for some/most
> >people and, as Alan pointed, not for some others...
> 
> __________________________________________________
> Do You Yahoo!?
> Yahoo! Greetings - Send FREE e-cards for every occasion!
> http://greetings.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
+-------------------------------------------------------------------------+
Mark Cooke                  The views expressed above are mine and are not
Systems Programmer          necessarily representative of university policy
University Of Birmingham    URL: http://www.sr.bham.ac.uk/~mpc/
+-------------------------------------------------------------------------+

