Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129342AbRBTUkL>; Tue, 20 Feb 2001 15:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129699AbRBTUkB>; Tue, 20 Feb 2001 15:40:01 -0500
Received: from chaos.analogic.com ([204.178.40.224]:10624 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129342AbRBTUjp>; Tue, 20 Feb 2001 15:39:45 -0500
Date: Tue, 20 Feb 2001 15:39:12 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mike Galbraith <mikeg@wen-online.de>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Probem with network performance 2.4.1
In-Reply-To: <Pine.LNX.4.33.0102202129260.1145-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.3.95.1010220153847.1965A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2001, Mike Galbraith wrote:

> On Tue, 20 Feb 2001, Richard B. Johnson wrote:
> 
> > There is nothing in either the VXI/Bus driver or the the Ethernet
> > driver that gives up the CPU, i.e., nobody calls schedule() in any
> > (known) path.
> 
> Check out IKD.  Ktrace is wonderful for making such unknowns visible.
> 
> 	-Mike
> 

OKay. I will do. Thanks.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


