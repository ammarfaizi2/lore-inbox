Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267771AbTB1LaE>; Fri, 28 Feb 2003 06:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267773AbTB1LaE>; Fri, 28 Feb 2003 06:30:04 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:54966 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S267771AbTB1LaD>; Fri, 28 Feb 2003 06:30:03 -0500
Message-ID: <20030228114012.18138.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Fri, 28 Feb 2003 12:40:12 +0100
Subject: Re: Mouse generating two mouse click events instead of one
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: binary man <the_binary_man@yahoo.fr> 
Date: Fri, 28 Feb 2003 11:36:36 +0100 
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> 
Subject: Re: Mouse generating two mouse click events instead of one 
 
> On Fri, 28 Feb 2003 07:37:34 +0100 
> "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> wrote: 
>  
> > ----- Original Message -----  
> > From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>  
> > Date: 27 Feb 2003 23:46:37 +0000   
> > To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>  
> > Subject: Re: Mouse generating two mouse click events instead of one  
> >   
> > > On Thu, 2003-02-27 at 22:33, Felipe Alfaro Solana wrote:  
> > > this often happends when you have two inputs in XFree86 config pointing  
> > > to the same device.  
> >   
> > But I don't... :-(  
> > More ideas ;-)  
> > --  
> Perhaps you use /dev/gpmdata as device for X, but you don't use "MouseSystems" as protocol ( always for X) 
? 
> Or perhaps you use gpm, but it isn't correctly configured ? Does your mouse works correctly on console ? 
> Or perhaps your mouse is broken ;) 
 
Sorry for the confusion: I *did* have two mouse input devices configured on XF86Config: one for my 
Intellimouse mouse and another one for the laptop built-in PS/2 mouse. What is really curious is that the PS/2 
touchpad wasn't working as it's modules wasn't loaded and neither /dev/psmouse nor /dev/psaux where 
generating any input events. 
 
Thanks to all! 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
