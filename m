Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265693AbUFXVal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265693AbUFXVal (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265691AbUFXVaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:30:06 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:63959 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S265693AbUFXV1R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:27:17 -0400
Date: Thu, 24 Jun 2004 17:27:06 -0400
From: Yaroslav Halchenko <yoh@psychology.rutgers.edu>
To: Chad Kitching <CKitching@powerlandcomputers.com>
Cc: Yaroslav Halchenko <yoh@psychology.rutgers.edu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: alienware hardware
Message-ID: <20040624212706.GX728@washoe.rutgers.edu>
Mail-Followup-To: Chad Kitching <CKitching@powerlandcomputers.com>,
	Yaroslav Halchenko <yoh@psychology.rutgers.edu>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <18DFD6B776308241A200853F3F83D507169DB2@pl6w2kex.lan.powerlandcomputers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18DFD6B776308241A200853F3F83D507169DB2@pl6w2kex.lan.powerlandcomputers.com>
X-Image-Url: http://www.onerussian.com/img/yoh.png
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for replying

do you mean while resting?

here it is

http://www.onerussian.com/Linux/bugs/alien/toplazy

if during some other application running - just say which to try :-)

--
Yarik


On Thu, Jun 24, 2004 at 03:56:13PM -0500, Chad Kitching wrote:
> How about a top output without dpkg installing or removing stuff?

> > -----Original Message-----
> > From: Yaroslav Halchenko [mailto:yoh@psychology.rutgers.edu]
> > Sent: June 24, 2004 3:26 PM
> > To: Denis Vlasenko
> > Cc: linux kernel mailing list
> > Subject: Re: alienware hardware


> > please have a look at
> > http://www.onerussian.com/Linux/bugs/alien/topout

> > which has 4 runs of top in it


> > Also I put more relevant information in 
> > http://www.onerussian.com/Linux/bugs/alien/

> > Spasibki Zaranee

> > --
> > Yarik


> > On Thu, Jun 24, 2004 at 11:15:56PM +0300, Denis Vlasenko wrote:
> > > On Thursday 24 June 2004 22:10, Yaroslav Halchenko wrote:
> > > > Dear kernel-people,

> > > > Please give me hints

> > > > How can I track down next problem: we've got a new laptop 
> > from alienware
> > > > (Septa model seems to me). We've tried kernels shipped 
> > with debian:
> > > > 2.4.26 and 2.6.6 but then I moved to vanila 2.6.7-bk7
> > > > and problem persisted: during boot after some point it 
> > becomes way too
> > > > slow : like it is running 100MHz, but checking
> > > > /proc/acpi/processor/CPU1/* showed that it didn't switch to any
> > > > throtelling mode or anything like that. Just it runs the 
> > process in "R"
> > > > mode on 99.9% cpu utilization user mode:
> > > > CPU states:  99.8% user,   0.2% system,   0.0% nice,   0.0% idle

> > > full top please?
> > -- 
> >                                                   Yaroslav Halchenko
> >                   Research Assistant, Psychology Department, Rutgers
> >           Office  (973) 353-5440 x263
> >    Ph.D. Student  CS Dept. NJIT
> >              Key  http://www.onerussian.com/gpg-yoh.asc
> >  GPG fingerprint  3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8

> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/


-- 
                                                  Yaroslav Halchenko
                  Research Assistant, Psychology Department, Rutgers
          Office  (973) 353-5440 x263
   Ph.D. Student  CS Dept. NJIT
             Key  http://www.onerussian.com/gpg-yoh.asc
 GPG fingerprint  3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8

