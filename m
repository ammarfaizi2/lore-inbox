Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287502AbSBCSAo>; Sun, 3 Feb 2002 13:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287513AbSBCSAf>; Sun, 3 Feb 2002 13:00:35 -0500
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:44292 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S287502AbSBCSAW>; Sun, 3 Feb 2002 13:00:22 -0500
Subject: Re: stumped with APM suspend/resume problem going from 2.4.5 ->
	2.4.17
From: Matt <mjg23@yahoo.com>
To: Thomas Hood <jdthood@mail.com>
Cc: linux-kernel@vger.kernel.org,
        Luis Miguel Tavora <lmtavora@saturno.fis.uc.pt>
In-Reply-To: <1012758216.806.44.camel@thanatos>
In-Reply-To: <1012758216.806.44.camel@thanatos>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 03 Feb 2002 13:00:13 -0500
Message-Id: <1012759220.1054.3.camel@blackbird.sectionone>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks for your reply.

unfortunately, my apm problems happen even with no devices (pcmcia or
usb) pluggin in.

On Sun, 2002-02-03 at 12:43, Thomas Hood wrote:
> > ... ever since I got a USB scanner and camera ...
> > "apm -s" and 
> > then resume causes the machine to hang.  On resume, even
> > outside of X, the screen blanks or appears but doesn't
> > respond to keyboard input.  No oops, no messages, no nothing.
> > The only choice I have at that point is a hard reset.
> 
> This sounds similar to an earlier report:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=101224645320919&w=2
> 
> >  If the computer is  put to rest 
> > (apm -s) with the (logitech) usb  mouse plugged in, 
> > the  PC doesn't recover at all,  going into a 
> > reboot sequence. If the mouse is  unplugged before 
> > "apm -s", everything goes  well... 
> > No problem as  well if the mouse is connected to 
> > the PS2 port. 
> 
> Sounds like a USB problem to me.  It would be most useful
> to know exactly which kernels have the problem and which
> ones don't.
> 
> --
> Thomas Hood



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

