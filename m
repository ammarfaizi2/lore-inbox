Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280262AbRKEGqk>; Mon, 5 Nov 2001 01:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280263AbRKEGqW>; Mon, 5 Nov 2001 01:46:22 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:63228 "EHLO mail.uni-kl.de")
	by vger.kernel.org with ESMTP id <S280262AbRKEGqR>;
	Mon, 5 Nov 2001 01:46:17 -0500
Message-ID: <XFMail.20011105074614.backes@rhrk.uni-kl.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.10.10111010601190.22300-100000@ares.sot.com>
Date: Mon, 05 Nov 2001 07:46:14 +0100 (CET)
X-Face: B^`ajbarE`qo`-u#R^.)e]6sO?X)FpoEm\>*T:H~b&S;U/h$2>my}Otw5$+BDxh}t0TGU?>
 O8Bg0/jQW@P"eyp}2UMkA!lMX2QmrZYW\F,OpP{/s{lA5aG'0LRc*>n"HM@#M~r8Ub9yV"0$^i~hKq
 P-d7Vz;y7FPh{XfvuQA]k&X+CDlg"*Y~{x`}U7Q:;l?U8C,K\-GR~>||pI/R+HBWyaCz1Tx]5
Reply-To: Joachim Backes <backes@rhrk.uni-kl.de>
Organization: University of Kaiserslautern,
 Computer Center [Supercomputing division]
From: Joachim Backes <backes@rhrk.uni-kl.de>
To: Yaroslav Popovitch <yp@sot.com>
Subject: Re: kernel 2.4.12: Missing tty when logging in on the console
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 01-Nov-2001 Yaroslav Popovitch wrote: 
>  
>  Was it fixed?
>  And where find this fix..
>  
>  
>  Cheers,YP

Hi, Yaroslav,

I'm sorry, but did not find or get any fix for this problem, which is a
problem in 2.4.13 too.

Regards

Joachim Backes

--

Joachim Backes <backes@rhrk.uni-kl.de>       | Univ. of Kaiserslautern
Computer Center, High Performance Computing  | Phone: +49-631-205-2438 
D-67653 Kaiserslautern, PO Box 3049, Germany | Fax:   +49-631-205-3056 
---------------------------------------------+------------------------
WWW: http://hlrwm.rhrk.uni-kl.de/home/staff/backes.html  



>  
> ###########################################################
>  after installation of kernel 2.4.12 (migrated from 2.4.10
>  by "make oldconfig"), having problems when logging in on
>  a virtual console:
>  
>  It sems that there is no correct tty attached to the console:
>  
>  1. the ps command lists _all_ processes actually running under
>     the correspondent userid and only those running under
>     the login shell.
>  
>  2. Starting a ssh command for some other box is rejected
>     by
>  
>                  You have no controlling tty and no DISPLAY.
>                  Cannot read passphrase.
>  
>  I never had such problems when running 2.4.10 kernel.
>  
>  

Joachim Backes

--

Joachim Backes <backes@rhrk.uni-kl.de>       | Univ. of Kaiserslautern
Computer Center, High Performance Computing  | Phone: +49-631-205-2438 
D-67653 Kaiserslautern, PO Box 3049, Germany | Fax:   +49-631-205-3056 
---------------------------------------------+------------------------
WWW: http://hlrwm.rhrk.uni-kl.de/home/staff/backes.html  

