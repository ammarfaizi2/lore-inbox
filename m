Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265509AbUFXU05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265509AbUFXU05 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 16:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265515AbUFXU05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 16:26:57 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:29655 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S265509AbUFXU0m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 16:26:42 -0400
Date: Thu, 24 Jun 2004 16:26:26 -0400
From: Yaroslav Halchenko <yoh@psychology.rutgers.edu>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: alienware hardware
Message-ID: <20040624202626.GS728@washoe.rutgers.edu>
Mail-Followup-To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040624191026.GP728@washoe.rutgers.edu> <200406242315.56213.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406242315.56213.vda@port.imtp.ilyichevsk.odessa.ua>
X-Image-Url: http://www.onerussian.com/img/yoh.png
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

please have a look at
http://www.onerussian.com/Linux/bugs/alien/topout

which has 4 runs of top in it


Also I put more relevant information in 
http://www.onerussian.com/Linux/bugs/alien/

Spasibki Zaranee

--
Yarik


On Thu, Jun 24, 2004 at 11:15:56PM +0300, Denis Vlasenko wrote:
> On Thursday 24 June 2004 22:10, Yaroslav Halchenko wrote:
> > Dear kernel-people,

> > Please give me hints

> > How can I track down next problem: we've got a new laptop from alienware
> > (Septa model seems to me). We've tried kernels shipped with debian:
> > 2.4.26 and 2.6.6 but then I moved to vanila 2.6.7-bk7
> > and problem persisted: during boot after some point it becomes way too
> > slow : like it is running 100MHz, but checking
> > /proc/acpi/processor/CPU1/* showed that it didn't switch to any
> > throtelling mode or anything like that. Just it runs the process in "R"
> > mode on 99.9% cpu utilization user mode:
> > CPU states:  99.8% user,   0.2% system,   0.0% nice,   0.0% idle

> full top please?
-- 
                                                  Yaroslav Halchenko
                  Research Assistant, Psychology Department, Rutgers
          Office  (973) 353-5440 x263
   Ph.D. Student  CS Dept. NJIT
             Key  http://www.onerussian.com/gpg-yoh.asc
 GPG fingerprint  3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8

