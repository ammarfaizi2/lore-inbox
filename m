Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265287AbUH0XL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbUH0XL7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 19:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbUH0XL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 19:11:59 -0400
Received: from mail1.kontent.de ([81.88.34.36]:23191 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S265287AbUH0XLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 19:11:53 -0400
From: Oliver Neukum <oliver@neukum.org>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: Summarizing the PWC driver questions/answers
Date: Sat, 28 Aug 2004 01:13:27 +0200
User-Agent: KMail/1.6.2
Cc: Kenneth Lavrsen <kenneth@lavrsen.dk>, Jesper Juhl <juhl-lkml@dif.dk>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <6.1.2.0.2.20040827215445.01c4ddb0@inet.uni2.dk> <Pine.LNX.4.61.0408272259450.2771@dragon.hygekrogen.localhost> <6.1.2.0.2.20040827233253.01c36210@inet.uni2.dk>
In-Reply-To: <6.1.2.0.2.20040827233253.01c36210@inet.uni2.dk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408280113.27530.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why not let the current driver be and then work on the alternative?
> Why is it so important that it is removed now?

Because Nemo felt that the driver was not in an acceptable shape
the way Greg was willing to accept it.

> Why does it have to be done in a way that create a problem for the common 
> users?

There's no way to remove a driver without causing somebody problems.

> Linus indicated that since Nemosoft had asked for his driver to be removed 
> noone else could take the sources as they are and add them again. So any 
> altertive would be a start from scratch? Or did I misunderstand this?
> That can take years. So I cannot update my kernel for years?

You are free to take the driver from older versions and add it to your
personal kernel. You may even publish it. You can be quite confident
that most distributors will add the driver to their kernels.

> How many normal users knows even how to compile their own kernel?
> You guys on this list talk as if anyone knows how to write a kernel module. 
> I think most of you have lost contact with the real users.
> 
> >And why is it you expect open source developers to assist in supporting
> >binary only drivers?
> 
> I am just asking for you guys to not DESTROY what is already there without 
> an alternative.

Keeping drivers against the wishes of the authors in the tree would
be very troubling for the future. I can assure you that no maintainer
will lightly pull a driver in this way.

> It is sad that you need legal counselling before you buy a USB camera.
> Besides. There are no real altertives. I have tried 4-5 other cameras using 
> for example the OV511 driver. They all failed. They were either not light

Then organize a website where people can sign a plea to Nemo to
maintain the driver out of kernel.
 
> sensitive enough for surveillance at night or the firmware/driver was so 
> unstable that the cameras froze and had to be disconnected to work again. 
> Only the pwc driven cameras are stable and good enough.

And thank him for the good work.
You are of cause also free to point out to Philips that you are creating
sales and are hampered by the secrecy of the compression method.

And give Nemo a little peace and consolation. He's very hurt now.

	Regards
		Oliver
