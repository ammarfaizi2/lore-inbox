Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbSKVKGT>; Fri, 22 Nov 2002 05:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbSKVKGT>; Fri, 22 Nov 2002 05:06:19 -0500
Received: from robur.slu.se ([130.238.98.12]:61703 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S261353AbSKVKGR>;
	Fri, 22 Nov 2002 05:06:17 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15838.1306.900100.541977@robur.slu.se>
Date: Fri, 22 Nov 2002 11:21:14 +0100
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Robert Olsson <Robert.Olsson@data.slu.se>,
       linux-kernel@vger.kernel.org
Subject: Re: e1000 fixes (NAPI)
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Seems like FreeBSD is now getting on this train too. Someone sent me this link.
http://info.iet.unipi.it/~luigi/polling/

Cheers.

						--ro


Jeff V. Merkey writes:
 > 
 > Thanks
 > 
 > jeff
 > 
 > On Thu, Nov 21, 2002 at 12:31:08PM -0500, Jeff Garzik wrote:
 > > Jeff V. Merkey wrote:
 > > 
 > > > >NAPI poll does not happen in an interrupt.  Doing things in interrupts
 > > > >is the source of problems that NAPI is trying to solve.
 > > > >
 > > > >Other than that, please read the code and NAPI paper...  :)
 > > >
 > > >
 > > >
 > > >
 > > > Where can I find it?
 > > 
 > > 
 > > 
 > > In the link Robert Ollson gave to you (paper), and the Linux kernel (code).
 > > 
 > > 	Jeff
 > > 
 > > 
