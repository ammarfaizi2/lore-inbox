Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292423AbSBUPDm>; Thu, 21 Feb 2002 10:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292422AbSBUPDd>; Thu, 21 Feb 2002 10:03:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62213 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292419AbSBUPDS>; Thu, 21 Feb 2002 10:03:18 -0500
Subject: Re: [DRIVER][RFC] SC1200 Watchdog driver
To: zwane@linux.realnet.co.sz (Zwane Mwaikambo)
Date: Thu, 21 Feb 2002 15:16:55 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        wingel@acolyte.hack.org (Christer Weinigel), wingel@nano-system.com,
        jgarzik@mandrakesoft.com, roy@karlsbakk.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202211619320.11932-100000@netfinity.realnet.co.sz> from "Zwane Mwaikambo" at Feb 21, 2002 04:27:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16duxr-0007DV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks Alan and Jeff for the input, i'll cleanup this stuff. Out of 
> interest, do we normally take in patches for specialised embedded boxes? I 

A lot of the watchdogs are for specific embedded boards. It is improving as
vendors (notably Intel) figure that watchdogs on the chipset are not much
silicon and very useful

> to integrate. I presume they'd get accepted if the code was broken up into 
> seperate modules instead of being overly specialised. For example, the 
> CRIS stuff in the Etrax tree (developer.axis.com).

Etrax is an entire architecture - its a bit differently weird 8)
