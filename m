Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263815AbUFXU6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbUFXU6a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 16:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUFXU6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 16:58:30 -0400
Received: from cdc868fe.powerlandcomputers.com ([205.200.104.254]:2020 "EHLO
	pl6w2kex.lan.powerlandcomputers.com") by vger.kernel.org with ESMTP
	id S261252AbUFXU61 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 16:58:27 -0400
content-class: urn:content-classes:message
Subject: RE: alienware hardware
Date: Thu, 24 Jun 2004 15:56:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <18DFD6B776308241A200853F3F83D507169DB2@pl6w2kex.lan.powerlandcomputers.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Thread-Topic: alienware hardware
Thread-Index: AcRaKcgsqJI0MtFwQJWGmZeFM0yRIQAA9OTw
From: "Chad Kitching" <CKitching@powerlandcomputers.com>
To: "Yaroslav Halchenko" <yoh@psychology.rutgers.edu>,
       "Denis Vlasenko" <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: "linux kernel mailing list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about a top output without dpkg installing or removing stuff?

> -----Original Message-----
> From: Yaroslav Halchenko [mailto:yoh@psychology.rutgers.edu]
> Sent: June 24, 2004 3:26 PM
> To: Denis Vlasenko
> Cc: linux kernel mailing list
> Subject: Re: alienware hardware
> 
> 
> please have a look at
> http://www.onerussian.com/Linux/bugs/alien/topout
> 
> which has 4 runs of top in it
> 
> 
> Also I put more relevant information in 
> http://www.onerussian.com/Linux/bugs/alien/
> 
> Spasibki Zaranee
> 
> --
> Yarik
> 
> 
> On Thu, Jun 24, 2004 at 11:15:56PM +0300, Denis Vlasenko wrote:
> > On Thursday 24 June 2004 22:10, Yaroslav Halchenko wrote:
> > > Dear kernel-people,
> 
> > > Please give me hints
> 
> > > How can I track down next problem: we've got a new laptop 
> from alienware
> > > (Septa model seems to me). We've tried kernels shipped 
> with debian:
> > > 2.4.26 and 2.6.6 but then I moved to vanila 2.6.7-bk7
> > > and problem persisted: during boot after some point it 
> becomes way too
> > > slow : like it is running 100MHz, but checking
> > > /proc/acpi/processor/CPU1/* showed that it didn't switch to any
> > > throtelling mode or anything like that. Just it runs the 
> process in "R"
> > > mode on 99.9% cpu utilization user mode:
> > > CPU states:  99.8% user,   0.2% system,   0.0% nice,   0.0% idle
> 
> > full top please?
> -- 
>                                                   Yaroslav Halchenko
>                   Research Assistant, Psychology Department, Rutgers
>           Office  (973) 353-5440 x263
>    Ph.D. Student  CS Dept. NJIT
>              Key  http://www.onerussian.com/gpg-yoh.asc
>  GPG fingerprint  3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
