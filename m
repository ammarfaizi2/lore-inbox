Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131573AbRC0Uva>; Tue, 27 Mar 2001 15:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131584AbRC0UvU>; Tue, 27 Mar 2001 15:51:20 -0500
Received: from linas.org ([207.170.121.1]:15356 "HELO backlot.linas.org")
	by vger.kernel.org with SMTP id <S131573AbRC0UvD>;
	Tue, 27 Mar 2001 15:51:03 -0500
Subject: Re: mouse problems in 2.4.2 -> lost byte
To: jsimmons@linux-fbdev.org (James Simmons)
Date: Tue, 27 Mar 2001 14:50:21 -0600 (CST)
Cc: Gunther.Mayer@t-online.de (Gunther Mayer), linas@linas.org,
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.31.0103271226140.847-100000@linux.local> from "James Simmons" at Mar 27, 2001 12:29:28 PM
From: linas@linas.org
X-Hahahaha: hehehe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010327205021.291411B7A5@backlot.linas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's been rumoured that James Simmons said:
> 
> 
> >This is easily explained: some byte of the mouse protocol was lost.
> >(Some mouse protocols are even designed to allow
> >easy resync/recovery by fixed bit patterns!)
> >
> >Write an intelligent mouse driver for XFree86 to compensate for
> >lost bytes.
> 
> Or write a kernel input device driver. In fact I probable have a mouse
> driver for you. What kind of mouse do you have? 

logitech trackman marble wheel. 

send me the driver.  Are you working on getting the thing incorporated
into xf86? should I pester someone over there about it?  should I assume
that 'everything will be OK', if I wait long enough?

--linas
