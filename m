Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318180AbSHIIR3>; Fri, 9 Aug 2002 04:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318188AbSHIIR2>; Fri, 9 Aug 2002 04:17:28 -0400
Received: from kim.it.uu.se ([130.238.12.178]:48025 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S318180AbSHIIR2>;
	Fri, 9 Aug 2002 04:17:28 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15699.31589.634056.607809@kim.it.uu.se>
Date: Fri, 9 Aug 2002 10:20:53 +0200
To: Pete de Zwart <dezwart@froob.net>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: 2.4.19: drivers/usb/printer.c usblpX on fire
In-Reply-To: <20020809060344.GC6340@niflheim>
References: <20020809060344.GC6340@niflheim>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete de Zwart writes:
 > Is there a reason that in 2.4.19's drivers/usb/printer.c if the printer status
 > code from is greater than 2 it states that it is on fire instead of printing
 > the unknown error code?

Dunno, but the parport lp.c also goes into "printer on fire" mode, in my case
whenever the black ink cartridge becomes empty :-(

/Mikael
