Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262631AbSJEVMQ>; Sat, 5 Oct 2002 17:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262634AbSJEVMQ>; Sat, 5 Oct 2002 17:12:16 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:45554 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262631AbSJEVMQ>; Sat, 5 Oct 2002 17:12:16 -0400
Subject: Re: Updated NatSemi SCx200 patches for Linux-2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christer Weinigel <christer@weinigel.se>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <87k7kw3nc1.fsf@zoo.weinigel.se>
References: <87k7kw3nc1.fsf@zoo.weinigel.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Oct 2002 22:26:43 +0100
Message-Id: <1033853203.4079.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-05 at 16:41, Christer Weinigel wrote:
> arch/i386/kernel/scx200.c -- give kernel access to the GPIO pins
> 

Would that perhaps be better in arch/i386/kernel/cpu/...


