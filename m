Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261796AbSI2VOe>; Sun, 29 Sep 2002 17:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261797AbSI2VOe>; Sun, 29 Sep 2002 17:14:34 -0400
Received: from h108-129-61.datawire.net ([207.61.129.108]:31711 "EHLO
	mail.datawire.net") by vger.kernel.org with ESMTP
	id <S261796AbSI2VOd> convert rfc822-to-8bit; Sun, 29 Sep 2002 17:14:33 -0400
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Kernel panic/exception dump support in 2.5?
Date: Sun, 29 Sep 2002 17:20:09 -0400
User-Agent: KMail/1.4.6
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209291640030.594-100000@coredump.sh0n.net> <1033334307.13795.11.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1033334307.13795.11.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200209291720.09913.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a 2.5 patch floating around?

Shawn.

On September 29, 2002 05:18 pm, Alan Cox wrote:
> On Sun, 2002-09-29 at 21:42, Shawn Starr wrote:
> > It would really be nice if I could capture kernel exceptions/and oopsies
> > on a file, or over a network connection. Redirecting console=lp0 to
> > printer doesnt really let me paste dumps to LKML =)
> >
> > Any solutions? Will we have a way to properly dump kernel failures
> > (exceptions/oopies) somewhere?
>
> The netdump patch can do this, including the actual kernel image

