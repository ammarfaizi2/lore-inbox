Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281917AbRKZQux>; Mon, 26 Nov 2001 11:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281921AbRKZQuk>; Mon, 26 Nov 2001 11:50:40 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:23814 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S281917AbRKZQuf>; Mon, 26 Nov 2001 11:50:35 -0500
Date: Mon, 26 Nov 2001 13:33:07 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: David Relson <relson@osagesoftware.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Release Policy [was: Linux 2.4.16  ]
In-Reply-To: <4.3.2.7.2.20011126113409.00bfaa70@mail.osagesoftware.com>
Message-ID: <Pine.LNX.4.21.0111261328450.13681-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Nov 2001, David Relson wrote:

> Marcelo,
> 
> Thank you for stepping forward to be the maintainer of the 2.4 tree.  This 
> is a very valuable and important service for use Linux users.
> 
> Also, thank you for releasing 2.4.16.  I have it building on my linux box 
> as I write this message :-)
> 
> Over the last few days, there have been lots of messages regarding "Kernel 
> Release" and "-preX vs. -rcX".  You, as the official maintainer of kernel 
> 2.4 are the person who actually creates the release policy and makes it happen.
> 
> Would you care to share your thoughts on this matter?

Sorry for not being able to discuss this issues... Its just that I'm too
busy doing the maintenance and other stuff at Conectiva at the same time
(people are flooding me with patches, btw, please stop for a while).

Daniel Quinlan suggested me to release a "pre-final" release before the
real final one (which would catch most "stupid" bugs), and I think thats a
nice way of solving the problem.

I'll _probably_ do that --- not sure yet, though. 

