Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131072AbRALPJY>; Fri, 12 Jan 2001 10:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131791AbRALPJO>; Fri, 12 Jan 2001 10:09:14 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:14090 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S131072AbRALPJE>;
	Fri, 12 Jan 2001 10:09:04 -0500
Date: Fri, 12 Jan 2001 16:06:36 +0100
From: Frank de Lange <frank@unternet.org>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-kernel@vger.kernel.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware related?
Message-ID: <20010112160636.E11091@unternet.org>
In-Reply-To: <20010110223015.B18085@unternet.org> <3A5D9D87.8A868F6A@uow.edu.au> <20010111201819.B3269@unternet.org> <3A5E0849.EB428D70@mandrakesoft.com>, <3A5E0849.EB428D70@mandrakesoft.com>; <20010112012839.A11091@unternet.org> <3A5EED14.88D8D9AF@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5EED14.88D8D9AF@uow.edu.au>; from andrewm@uow.edu.au on Fri, Jan 12, 2001 at 10:40:04PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 10:40:04PM +1100, Andrew Morton wrote:
> Frank de Lange wrote:
> > 
> > Quick and dirty conclusion: as soon as the apic comes in to play, things get
> > messy...
> Here is a debugging patch.  Could you please apply this,
> rebuild and:
> 
> 1: Type ALT-SYSRQ-A when everything is good
> 2: Type ALT-SYSRQ-A when everything is bad
> 3: send the resulting logs.

WillCo...

Now rebuilding...


Cheers//Frank

-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
