Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263190AbTCLObT>; Wed, 12 Mar 2003 09:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263192AbTCLObT>; Wed, 12 Mar 2003 09:31:19 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:56325 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id <S263190AbTCLObR>;
	Wed, 12 Mar 2003 09:31:17 -0500
Message-ID: <002101c2e8a5$8358d4c0$2400a8c0@compaq3>
From: "David Shirley" <dave@cs.curtin.edu.au>
To: <vda@port.imtp.ilyichevsk.odessa.ua>, <linux-kernel@vger.kernel.org>
References: <041b01c2e86a$870822f0$64070786@synack> <200303121340.h2CDe3u30029@Port.imtp.ilyichevsk.odessa.ua> <000a01c2e89e$e9ab9c50$2400a8c0@compaq3> <200303121353.h2CDrhu30117@Port.imtp.ilyichevsk.odessa.ua>
Subject: Re: Help, eth0: transmit timed out!
Date: Wed, 12 Mar 2003 22:41:48 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tried a different NIC, another 3c905c.

Yeah i know about the modules thing, i turned it off
in case that was the problem.

D
----- Original Message ----- 
From: "Denis Vlasenko" <vda@port.imtp.ilyichevsk.odessa.ua>
To: "David Shirley" <dave@cs.curtin.edu.au>; <linux-kernel@vger.kernel.org>
Sent: Wednesday, March 12, 2003 9:50 PM
Subject: Re: Help, eth0: transmit timed out!


> On 12 March 2003 15:54, David Shirley wrote:
> > Its strange we have another machine, exact same setup,
> > hardware/software and it doesn't have any problems.
> 
> Did you try to swap some hardware? NIC would be the first
> to swap.
> 
> > The other thing is that sometimes the machine freezes totally,
> > and othertimes it comes back after 30 secs??
> 
> If it's a driver problem, anything is possible.
> 
> > FYI: Its not a modular kernel, but ill try the printk thing.
> 
> Modular one will be far easier (faster) to play with.
> You just unload the module, recompile and reload.
> No reboot cycles.
> --
> vda
> 
