Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263299AbTCNJXX>; Fri, 14 Mar 2003 04:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263300AbTCNJXX>; Fri, 14 Mar 2003 04:23:23 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:57065 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S263299AbTCNJXV>; Fri, 14 Mar 2003 04:23:21 -0500
Message-ID: <20030314093403.23734.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: "J. Hidding" <J.Hidding@student.rug.nl>, linux-kernel@vger.kernel.org
Date: Fri, 14 Mar 2003 10:34:03 +0100
Subject: Re: linux-2.5.64-mm5 crashes on software eject of cdrom
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "J. Hidding" <J.Hidding@student.rug.nl> 
Date: 	Fri, 14 Mar 2003 10:04:30 +0100 
To: linux-kernel@vger.kernel.org 
Subject: linux-2.5.64-mm5 crashes on software eject of cdrom 
 
> Linux 2.5.64-mm5 seems to crash when I do an eject on  
> either the cdrom/dvdrom or the cd-rw, by a software  
> command. (1: gnome-cdplr-applet, 2: grip auto-ejecting, 3:  
> final test with a simple: eject). 
>  
> I couldn't find any log reporting on this problem. 
> I use an 850 MHz Athlon, VIA-<something> mainboard, 256 M  
> memory, a Samsung cd/dvd-rom, a Benq cd-rw. Running the  
> newest Gentoo Linux. 
 
You're not alone on this issue... I have experimented the 
same problems with 2.5.64-mm5 and 2.5.64-mm6 on my 
RedHat Phoebe3 laptop. 
 
Don't know what's causing it, but haven't experienced 
this kind of freezes with stock 2.5 kernels. 
 
Thanks! 
 
   Felipe 
 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
