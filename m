Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287518AbSBGMIE>; Thu, 7 Feb 2002 07:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287516AbSBGMHy>; Thu, 7 Feb 2002 07:07:54 -0500
Received: from saturno.fis.uc.pt ([193.136.215.208]:52235 "EHLO
	saturno.fis.uc.pt") by vger.kernel.org with ESMTP
	id <S287513AbSBGMHv>; Thu, 7 Feb 2002 07:07:51 -0500
Date: Thu, 7 Feb 2002 12:07:18 GMT
From: Luis Miguel Tavora <lmtavora@saturno.fis.uc.pt>
Message-Id: <200202071207.MAA14784@saturno.fis.uc.pt>
To: Thomas Hood <jdthood@mail.com>
Reply-To: lmtavora@saturno.fis.uc.pt
Cc: linux-kernel@vger.kernel.org,
        Luis Miguel Tavora <lmtavora@saturno.fis.uc.pt>,
        Matt <mjg23@yahoo.com>
In-Reply-To: <1012758216.806.44.camel@thanatos>
In-Reply-To: <1012758216.806.44.camel@thanatos>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP3 Imap webMail Program 2.0.11
X-Originating-IP: 193.136.200.36
Subject: Re: stumped with APM suspend/resume problem going from 2.4.5 -> 2.4.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thomas Hood <jdthood@mail.com>:

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
> 
> 

Hi there.

I've noticed the problem with kernels 2.4.7-10, as 
well as 2.4.9-13 and 2.4.17. 

As I was not able to fix it, I decided to the mouse
on PS/2

Thx

Luis

-----------------------------------------------------
This mail sent through IMP: http://web.horde.org/imp/
