Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277097AbRJVRGI>; Mon, 22 Oct 2001 13:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277115AbRJVRFt>; Mon, 22 Oct 2001 13:05:49 -0400
Received: from www.transvirtual.com ([206.14.214.140]:45066 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S277104AbRJVRFg>; Mon, 22 Oct 2001 13:05:36 -0400
Date: Mon, 22 Oct 2001 10:04:21 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: The new X-Kernel !
In-Reply-To: <20011021215351.C19390@vega.digitel2002.hu>
Message-ID: <Pine.LNX.4.10.10110220954490.1738-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > have a adapter to connect a PS/2 keyboard or mouse to the iPAQ at work. I
> > also have a alchemy board which allows you to plug in usb mice/keyboards. 
> > 
> > Plus for real game support I really like to see OpenGL use direct input.
> > Sorry but you need real time response in games. Have input events going
> > back a forth between the X client and the X server is just a waste.

[snip]...
 
> But don't move anything into kernel space which is possible in user space
> as well! 

I think we are misunderstanding each other here. I just want to see some
kind of locking like DRI for input if "direct input" would ever be
implemented. I would like to see also a standard api used for all the
keyboards and mice. This is why I'm a a fan of the input api. Lets face
it. The XFree86 developement cycle is many many many times longer than
linux. This way as soon as a driver using the standard input api is
avaliable for linux it is supported under XFree86. 

