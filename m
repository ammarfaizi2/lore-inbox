Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBZUyi>; Mon, 26 Feb 2001 15:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129091AbRBZUyS>; Mon, 26 Feb 2001 15:54:18 -0500
Received: from host55.osagesoftware.com ([209.142.225.55]:13066 "EHLO
	nic.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S129051AbRBZUyJ>; Mon, 26 Feb 2001 15:54:09 -0500
Message-Id: <4.3.2.7.2.20010226155254.00ce1f00@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 26 Feb 2001 15:53:27 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: David Relson <relson@osagesoftware.com>
Subject: Re: Posible bug in gcc
Cc: jakub@redhat.com, alan@lxorguk.ukuu.org.uk (Alan Cox),
        dllorens@lsi.uji.es (David), linux-kernel@vger.kernel.org
In-Reply-To: <E14XRyY-0001gE-00@the-village.bc.nu>
In-Reply-To: <20010226123309.A16592@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:02 PM 2/26/01, Alan Cox wrote:
> > > Well gcc-bugs would be the better place to send it but this is a 
> known problem
> > > fixed in CVS gcc 2.95.3, CVS gcc 3.0 branch and gcc 2.96 (unofficial, 
> Red Hat)
> >
> > I'm not sure if it is known, at least not known to me, but definitely not
> > fixed in any of gcc 2.95.2, CVS gcc 3.0 branch, CVS gcc 3.1 head, gcc 
> 2.96-RH.
>
>Sorry my error for assuming it was the exsting known strength reduce bug


It's broken in my copy of gcc.2.95.3 ...

David


