Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264848AbRFYG4O>; Mon, 25 Jun 2001 02:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbRFYG4E>; Mon, 25 Jun 2001 02:56:04 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26891 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264848AbRFYGzv>; Mon, 25 Jun 2001 02:55:51 -0400
Subject: Re: AMD thunderbird oops
To: joeja@mindspring.com
Date: Mon, 25 Jun 2001 07:55:27 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Springmail.105.993439024.0.29949400@www.springmail.com> from "joeja@mindspring.com" at Jun 24, 2001 11:17:04 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15EQHP-0001ET-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just upgradede my system to an 1200Mhz AMD Athlon Thundirbird (266Mhz FSB) processor  / 512Meg of RAM, and an Asus kt7a motherboard.  
> 
> It is oppsing left and right.  I recompiled the kernel with Athelon as the CPU but keep getting these oopses..
> 
> I also get these same problems while trying to install RH 7.1
> 
> Anyone know is this a supported processor / MB and has anyone had these problems?

Random oopses normally indicate faulty board cpu or ram (and the fault may 
even just be overheating or dimms not in the sockets cleanly). I doubt its
the board design or model that is the problem, you probably jut have a faulty
component somewhere if its oopsing randomly even during installs and stuff

memtest86, and heatsink compound may be your best friends

