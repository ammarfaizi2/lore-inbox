Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbTION5m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 09:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbTION5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 09:57:42 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:64674 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261384AbTION5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 09:57:40 -0400
Subject: Re: Developing Kernel Code newbie
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Drake <dsd@reactivated.net>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F658B36.2010503@reactivated.net>
References: <000d01c37b5f$47722b80$1101a8c0@CARTMAN>
	 <3F6579CD.5010609@cyberone.com.au>  <3F658B36.2010503@reactivated.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063634144.2674.26.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Mon, 15 Sep 2003 14:55:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-15 at 10:49, Daniel Drake wrote:
> I'm in a similar situation here.. a C/C++ beginner, very keen to work on 
>   the Linux kernel.
> Those two books you mentioned, the latest editions cover the 2.4 series 
> kernel. Would reading these still be useful for working on the 2.6 (and 
> onwards) kernels?

The kernel is cool, but it is a large piece of code with a lot of ideas
in it that some folks find challenging (interrupts, multiprocessing,
threads and locking) [One thing to be said at least the Java taught
university folks understand some of this unlike those they used to feed
pascal]

Have fun but if you find the kernel daunting and hard work, don't give
up but pick up something smaller, easier to understand and use a
debugger on - like desktop applications, then come back and try the
kernel again later.


