Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129339AbRBZReR>; Mon, 26 Feb 2001 12:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129336AbRBZReI>; Mon, 26 Feb 2001 12:34:08 -0500
Received: from [199.183.24.200] ([199.183.24.200]:13290 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129331AbRBZRd6>; Mon, 26 Feb 2001 12:33:58 -0500
Date: Mon, 26 Feb 2001 12:33:09 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David <dllorens@lsi.uji.es>, linux-kernel@vger.kernel.org
Subject: Re: Posible bug in gcc
Message-ID: <20010226123309.A16592@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <3A9A8489.224CF54C@inf.uji.es> <E14XRFC-0001ay-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14XRFC-0001ay-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Feb 26, 2001 at 05:15:28PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2001 at 05:15:28PM +0000, Alan Cox wrote:
> > I think I heve found a bug in gcc. I have tried both egcs 1.1.2 (gcc
> > 2.91.66) and gcc 2.95.2 versions.
> > 
> > I am attaching you a simplified test program ('bug.c', a really simple
> > program).
> 
> Well gcc-bugs would be the better place to send it but this is a known problem
> fixed in CVS gcc 2.95.3, CVS gcc 3.0 branch and gcc 2.96 (unofficial, Red Hat)

I'm not sure if it is known, at least not known to me, but definitely not
fixed in any of gcc 2.95.2, CVS gcc 3.0 branch, CVS gcc 3.1 head, gcc 2.96-RH.

	Jakub
