Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262364AbSJEPFK>; Sat, 5 Oct 2002 11:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262365AbSJEPFG>; Sat, 5 Oct 2002 11:05:06 -0400
Received: from 62-190-217-225.pdu.pipex.net ([62.190.217.225]:7941 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262364AbSJEPFG>; Sat, 5 Oct 2002 11:05:06 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210051518.g95FIdPr000532@darkstar.example.net>
Subject: Re: 2.5.x and 8250 UART problems
To: ahu@ds9a.nl (bert hubert)
Date: Sat, 5 Oct 2002 16:18:39 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
In-Reply-To: <20021005150715.GA30761@outpost.ds9a.nl> from "bert hubert" at Oct 05, 2002 05:07:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I've noticed that 8250 UART based serial port performance is poorer in
> > 2.5.x than 2.4.x and 2.2.x, on a couple of my machines.
> > 
> > The 486 SX-20 with 4 MB RAM, running 2.2.21 reliably achieves about 650
> > BPS download from another machine, with the port runnnig at 9600 bps. 
> > With 2.5.40, many characters are lost at 9600, making, e.g. a ZModem
> > transfer retry for almost every block.
> 
> Have you tried 'hdparm -u'?

Hmmm, I can do, but I thought it was a Bad Thing (tm) for ISA based controllers?  I could be wrong...

John.
