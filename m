Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265130AbRFUTPk>; Thu, 21 Jun 2001 15:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265127AbRFUTPa>; Thu, 21 Jun 2001 15:15:30 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23300 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265130AbRFUTPQ>; Thu, 21 Jun 2001 15:15:16 -0400
Subject: Re: Controversy over dynamic linking -- how to end the panic
To: mharrold@cas.org (Mike Harrold)
Date: Thu, 21 Jun 2001 20:14:11 +0100 (BST)
Cc: ttabi@interactivesi.com (Timur Tabi), linux-kernel@vger.kernel.org
In-Reply-To: <200106211904.PAA10433@mah21awu.cas.org> from "Mike Harrold" at Jun 21, 2001 03:04:21 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15D9u7-0001xo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1) Oracle Corp. builds their database for Linux on a Linux system.
> 2) Said system comes with standard header files, which happen in this case to
>    be GPL'd header files.
> 3) Oracle Corp.'s database becomes GPL.
> 
> There's not a court in the civilised world that would uphold the GPL in that
> scenario.

Yes but the concern is the USA 8)

An application is clearly not a derivative work in the general case, and they
are linked with glibc which is LGPL and gives the users the choice and right
to run non-free apps. 

In fact the people in the application space trying to take away the users
rights are Microsoft with its new 'no free software allowed' licenses on 
Windows libraries.

Drivers are a more complex issue. I'm not opposed to binary only drivers, 
providing its easy to tell they are there and dump all bug reports about them.
Freedom generally includes the right to give up freedom. I'll tell people its
a bad idea but once they get caught, well it was their right to do so...

Alan

