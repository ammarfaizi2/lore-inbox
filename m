Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129248AbQLCXKX>; Sun, 3 Dec 2000 18:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129410AbQLCXKN>; Sun, 3 Dec 2000 18:10:13 -0500
Received: from smtprelay.abs.adelphia.net ([64.8.20.11]:44187 "EHLO
	smtprelay3.abs.adelphia.net") by vger.kernel.org with ESMTP
	id <S129248AbQLCXKF>; Sun, 3 Dec 2000 18:10:05 -0500
Date: Sun, 3 Dec 2000 17:42:03 -0500 (EST)
From: "Steven N. Hirsch" <shirsch@adelphia.net>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Phantom PS/2 mouse persists..
In-Reply-To: <20001203161940.A24531@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.21.0012031739360.3253-100000@pii.fast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2000, Jeff V. Merkey wrote:

> > On Sun, Dec 03, 2000 at 06:27:52PM +0000, Alan Cox wrote:
> > > 
> > > I've fixed the major case. I can see no definitive answer to the other ghost
> > > PS/2 stuff (except maybe USB interactions). I take it like the others 2.4test
> > > also misreports a PS/2 mouse being present.
> > > 
> > > Anyway I think its no longer a showstopper for 2.2.18. Someone with an affected
> > > board can piece together the picture

> I just tested 2.2.18-24 as a boot kernel with anaconda -- works great -- 
> mouse problem on PS/2 system is nailed.  

<sigh>  I always seem to own the wierd hardware.  I agree the mouse
mis-detection isn't a showstopper - just damn annoying.

FWIW, USB isn't compiled into the kernel in question.

Steve


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
