Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273638AbRIXVsS>; Mon, 24 Sep 2001 17:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273643AbRIXVsH>; Mon, 24 Sep 2001 17:48:07 -0400
Received: from ns1.austin.rr.com ([24.93.35.63]:56841 "EHLO ns2.austin.rr.com")
	by vger.kernel.org with ESMTP id <S273638AbRIXVry>;
	Mon, 24 Sep 2001 17:47:54 -0400
Date: Mon, 24 Sep 2001 16:49:53 -0500 (CDT)
From: Jeff Meininger <jeffm@boxybutgood.com>
X-X-Sender: <jeffm@mangonel.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: 2D graphics: KGI, GGI, fbdev, DRI, svgalib, oh my!!!
Message-ID: <Pine.LNX.4.33.0109241617240.3945-100000@mangonel.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to design a simple 2D game for linux, mainly as a way to learn
as much as I can about the linux kernel, graphics hardware, and whatever
lies between.  It would basically involve shooting little alpha-blended
spaceships that would fade in (becoming more and more opaque) and move
around the screen (all the while being blended over a scrolling
background).

I've searched for and read some information on all of the things listed in
the subject line of this message.  I've learned a thing or two, but I'm
still not confident enough in my understanding of them to choose one and
start writing code.  Indeed, some of them are based on others, so I may
have to choose two.  :)

If my ultimate goal is a maximum level of hardware acceleration,
especially for scrolling and alpha-blending, which linux graphics
interface would be the best choice for my needs?

Please note that my question is a theoretical one, not a practical one.
I'm not asking which system currently has the best accelerated drivers;
I'm asking which one has the best potential for taking advantage of all a
card has to offer.

It might be that my very question is flawed.  If so, please enlighten me!

I'm not subscribed, so please kindly Cc me in your reply.

Thanks!
-Jeff Meininger

